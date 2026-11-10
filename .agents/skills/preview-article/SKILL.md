---
name: preview-article
description: Preview a NewSpaces.org article or site change with the exact GitHub Pages toolchain (github-pages 232 / Jekyll 3.10, safe mode) before it is posted — start the Docker preview, check the rendered routes and the article's own front matter, and show it to the user.
metadata:
  category: content
  framework: jekyll
---
# Previewing an article before it goes live

Use this when an article (or any site change) should be looked at before it is
posted: a draft in `_posts/`, "show me how it looks", "preview it", or a
spot-check after edits. This skill **never publishes** — pushing to `main` is
`preview-and-publish`, and writing the post itself is `update-article`.

## Knowledge

- **Why a container at all**: GitHub Pages builds with the `github-pages` gem
  (currently **232 → Jekyll 3.10.0**) in **safe mode**; a plain `jekyll serve`
  is usually 4.x. The repo's `Dockerfile` / `docker-compose.yml` pin the Pages
  toolchain, so what you preview is what Pages will publish.
- **Image**: `newspaces-preview:pages` — Ruby 3.3 slim + `github-pages` 232.
  Serves container port **4000**, repo bind-mounted at `/srv/site`, build output
  to `/tmp/site` (never into the checkout, so no root-owned `_site`).
- **Ports**: `PREVIEW_PORT` (default 4000). The cloud platform's preview proxy
  reaches only port **3000** on the VM, so use `PREVIEW_PORT=3000` there and stop
  whatever holds 3000 first — by PID, not by pattern.
- **Rendering parity**: Jekyll 3.10 and Jekyll 4 produce identical output for
  this theme apart from `feed.xml`'s absolute host. A difference in the
  container is therefore a real difference, not toolchain noise.
- **URLs**: permalink is `/:slug/` (no date), so the article preview lives at
  `http://localhost:<port>/<slug>/`.
- **Not on disk**: images pasted into chat. Only files in the repo (or fetchable
  URLs) can appear in a preview.
- **README-less repo**: the operational docs are these skills plus
  `scripts/verify-build.sh`.

## Instructions

### 1. Know what you are previewing

```sh
ls _posts/*-<slug>.md
ls assets/articles/<slug>/
```

If the post or its hero is missing, say so instead of previewing a half-written
article. Note the date: a future-dated post builds locally but is skipped by
Pages (`future: false`), which matters when you hand it over.

### 2. Start the Pages-accurate preview

```sh
PREVIEW_PORT=3000 docker compose up -d --build   # 4000 on a desktop with Docker
docker compose ps                                # wait for "healthy"
docker compose logs --tail=40 preview
```

Readiness means HTTP 200, not "container started":

```sh
for i in $(seq 1 60); do
  curl -fsS -o /dev/null http://127.0.0.1:3000/ && break
  sleep 1
done
```

If it is `unhealthy` or still failing after a minute, read the log: a Liquid or
front-matter error appears only there, while the process keeps serving a stale
build.

### 3. Check the article itself

With the same gem set, inside the container:

```sh
docker compose exec preview sh ./scripts/verify-build.sh <slug>
```

Expect `PASS: <slug>` and exit 0. That script covers the hero being printed
exactly once, the archive row using the thumbnail, every post still having an
archive row, the JPEGs existing in the output, and `scripts/` not leaking into
the published site. Then check the routes the article touches:

| request | expect |
| --- | --- |
| `/<slug>/` | 200 `text/html`, `<title>` is the article title |
| `/` | 200, post listed (lead if `featured: true`, else in the grid) |
| `/archive/` | 200, an `.ns-arow` row for the slug |
| `/assets/css/newspaces.css` | 200 `text/css` |
| hero and thumbnail | 200 `image/jpeg` |

Spot-check the HTML itself: the kicker is the first tag, the excerpt renders,
the hero `<img>` appears once, body figures are still in place (they are not
stripped when `image:` is set), and a **new** post has no "From the archive"
note (that note is for posts up to `archive_until`).

### 4. Show it to the user

Open `/<slug>/`, not just the home page — `cloud_show_dev_server` with port 3000
in cloud, the preview panel on desktop — and give the direct URL.

A cloud session has no browser, so you cannot see the rendering: report the
checks you ran and say the visual review is the user's. Never write "looks
good" on the strength of a 200 status.

### 5. Edits and rebuilds

The repo is bind-mounted and the watch uses polling, so saving a file rebuilds
in place — refresh the browser. If the page is stale, `docker compose restart
preview` and re-read the log. Fix the source rather than restarting repeatedly.

### 6. Leave the environment as you found it

`docker compose down` when the user is done, or leave it running and say so.
Stop only what you started (the compose service or the recorded PID); never
kill processes by name pattern.

### 7. When Docker is not available

Check `docker info`. If it fails (`permission denied ... /var/run/docker.sock`,
and no `sudo` — the case in this cloud VM), do not pretend otherwise: run
`jekyll serve --host 0.0.0.0 --port 3000`, run the same curl matrix and
`sh ./scripts/verify-build.sh <slug>`, and label the preview as Jekyll 4 rather
than the Pages toolchain. That fallback is a valid preview, just not proof of
Pages parity.

## Checklist

- [ ] Post file and assets exist; `slug:` matches the filename suffix
- [ ] Container `healthy`, `/` answers 200
- [ ] `verify-build.sh <slug>` PASS inside the container
- [ ] `/<slug>/`, `/`, `/archive/`, CSS, hero and thumbnail checked (status + type)
- [ ] Hero once, body figures intact, kicker/excerpt correct, no archive note
- [ ] Direct article URL given to the user; visuals explicitly left to them
- [ ] Nothing committed, nothing published

## Troubleshooting

- **`invalid option: --disable-disk-cache`** — Jekyll-4-only flag; the verify
  script probes for it. Do not reintroduce it.
- **Port 3000 already in use** — an earlier `jekyll serve` usually holds it;
  stop that PID (`.vly-run/preview.pid` if it was started here) and start the
  container.
- **Empty or wrong thumbnail in a listing** — `image:` / `thumbnail:` missing,
  so templates fall back; fix front matter, not layouts.
- **Hero printed twice** — `image:` missing, so the first body image is treated
  as the hero and removed from the body. Set `image:`.
- **Image 404 in the container** — the path must start with `/assets/...` and
  the file must exist under the repo root.
- **Preview fine, Pages broken** — safe mode: remove `_plugins/`, custom
  `plugins:`, or anything outside the Pages whitelist.
- **Slow rebuilds on macOS/Windows** — polling watch is intentional; a large
  `assets/` tree is the usual cost.

## Persistence across sessions

- **In the repo**: `Dockerfile`, `docker-compose.yml`, `.dockerignore`, this
  skill, `scripts/verify-build.sh`.
- **Local Docker state**: the built image and any running container — rebuild
  with `docker compose build` on a new machine; nothing lives in the workspace.
- **Ephemeral in cloud**: the container, `/tmp/site`, and any Ruby/Jekyll
  installed in the sandbox.
