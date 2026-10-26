---
name: update-article
description: Add or update an article on the NewSpaces.org Jekyll/GitHub Pages site from uploaded markdown and images — front matter contract, image and thumbnail handling, local build verification, preview, and publishing.
metadata:
  category: content
  framework: jekyll
---
# Updating articles on NewSpaces.org

Use this skill whenever the user provides markdown (and/or images) for a new
article, or asks to change an existing one.

## Knowledge

- **Stack**: plain Jekyll 4 site, published by **GitHub Pages** from `main`
  (`newspaces-org/newspaces`, CNAME `newspaces.org`). No plugins, no npm, no
  package.json — the repo config for this project is Jekyll itself.
- **Posts**: `_posts/YYYY-MM-DD-<slug>.md`. `_config.yml` defaults give every
  post `layout: post` and permalink `/:slug/` (no date in the URL).
- **Front matter fields that matter**:
  - `layout: post`
  - `title:` `date:` `slug:` (slug must equal the filename suffix)
  - `tags:` — must come from the `elements` list in `_config.yml`
    (Sea, Air, Space, Underground, Infrastructure, Environments, Experiences);
    the first tag is the kicker and drives archive filtering.
  - `excerpt:` — one sentence, ends with `…`, quoted.
  - `image:` — the hero (article page 2:1 figure, home lead figure).
  - `thumbnail:` — the listing crop (archive row, home "seconds", related
    grid). Falls back to `image:` when absent.
  - Optional `featured: true` pins a post as the home lead.
- **Image resolution rules** (`_includes/post-image.html`): with `thumb=true`
  (every listing) the order is `thumbnail` → `image` → first `<img>` in the
  body; on the post page / home lead it is `image` → first body `<img>`.
  When `page.image` is set the first body image is **not** stripped, so body
  figures stay in place.
- **Asset layout**: `assets/articles/<slug>/`. Filenames must be URL-safe —
  no spaces (legacy folders have them and need `%20` everywhere).
  - hero: ≥2000 px wide, ~2:1 crop friendly, progressive JPEG, ~50–90 KB
  - thumbnail: **3:2**, 720×480, progressive JPEG, ~20 KB
  - listings use `object-fit: cover`, so aspect matters more than size.
- **Look**: `_config.yml` has `look: eco` (natural-colour photos, no halftone
  or CMYK plate treatment). Posts from ≤ 2015 get an "From the archive" note;
  new posts do not.
- **Pasted chat images are not written to disk.** Only files that exist in the
  workspace (or URLs fetchable with `curl`) can be used. If the user pastes
  images into chat, ask them to drop the files into
  `assets/articles/<slug>/` or send links.

## Instructions

1. **Collect inputs.** Confirm the markdown file path(s) and the image files
   actually exist (`ls`). If the user only pasted images in chat, ask for the
   files or URLs before doing anything else.
2. **Work out identity**: slug (kebab-case), publication date, filename
   `_posts/YYYY-MM-DD-<slug>.md`, asset folder `assets/articles/<slug>/`.
3. **Normalise the markdown** into that filename with the front matter above
   (keep the body the user gave you; fix only encoding/line-break issues).
   Add `image:` and `thumbnail:` when assets are ready.
4. **Prepare images** with Pillow if the source needs it
   (`pip install pillow pillow-avif-plugin` handles AVIF/WebP sources):
   - hero: crop/resize to ≥2000 px wide, `quality=82, optimize=True, progressive=True`
   - thumbnail: centre-crop to 3:2 then `resize((720, 480), LANCZOS)`,
     `quality=80, optimize=True, progressive=True`
   - verify both open cleanly (`Image.open(p).verify()`).
5. **Optional body figures**: markdown `![alt](/assets/articles/<slug>/file.jpg)`
   with their own alt text (the hero's alt is the post title, set by
   `figure.html`). Place them next to the paragraph they illustrate.
6. **Verify the build** — this is mandatory before reporting done:
   `sh ./scripts/verify-build.sh <slug>`
   It builds into a temp dir (so nothing is written into the repo) and asserts
   the hero renders exactly once, the archive row uses the thumbnail, every
   post still has an archive row, and the referenced JPEGs exist in the
   output. Fix failures at the source; never weaken the script.
7. **Preview** (only if the user wants to look at it):
   `freebuff-preview start`, then `freebuff-preview status` / `logs`.
   The commands are already saved (`jekyll serve --host 0.0.0.0 --port
   ${PORT:-4000}`, install = `jekyll` if missing). **Never** run
   `jekyll serve` / `bun run dev` from the shell — it would steal the managed
   preview port. If the preview looks stale, fix the cause, then
   `freebuff-preview restart`.
8. **Publishing** happens by pushing to `main` — GitHub Pages builds it.
   Do not set up Freebuff deploys for this repo (the hosting builder is
   Node-only; Jekyll cannot run there). Do not add Jekyll plugins or
   `baseurl`; keep `_config.yml` GitHub-Pages compatible.
9. **Git**: the Changes panel owns Save/commit/push. Only run git delivery
   commands when the user asks. When asked to commit, author as
   `Newspaces <info@newspaces.org>`: set it repo-locally
   (`git config user.name "Newspaces"` / `git config user.email
   "info@newspaces.org"`) and pass it explicitly on the commit, then verify
   with `git log -1 --format='%an <%ae>'` — Freebuff rewrites `.git/config`
   during its managed git operations and can silently replace the identity.
   Message style is one
   plain descriptive sentence (no conventional-commit prefixes) explaining
   *why*, ending with the Codebuff footer:
   ```
   🤖 Generated with Codebuff
   Co-Authored-By: Codebuff <noreply@codebuff.com>
   ```

## Checklist

- [ ] Post file at `_posts/YYYY-MM-DD-<slug>.md`, `slug:` matches filename
- [ ] `tags` drawn from `elements` in `_config.yml`; `excerpt` quoted + `…`
- [ ] `image:` and `thumbnail:` set; both files under `assets/articles/<slug>/`
- [ ] Image filenames URL-safe; thumbnail is 3:2 720×480; hero ≥2000 px JPEG
- [ ] `sh ./scripts/verify-build.sh <slug>` passes
- [ ] `git status` shows only intended files (no `_site/`, no `.jekyll-cache/`)
- [ ] Committed/pushed only on explicit request

## Troubleshooting

- **Empty thumbnail in a listing** — the post has no `image:`/`thumbnail:`
  and no `<img>` in its rendered body; set front matter rather than editing
  templates.
- **Hero printed twice** — `image:` is missing, so the layout treats the
  first body image as the hero and strips it from the body. Set `image:`.
- **Image 404 in the built site** — path must start with `/assets/...` and the
  file must live under the repo root (Jekyll copies `assets/` verbatim).
- **Local build fine but Pages fails** — Pages runs `github-pages` in safe
  mode; remove any plugin or config key it does not whitelist.

## Persistence across sessions

What survives a session close, and where it lives:

- **In the repo (pushed to `main`)** — this skill, `scripts/verify-build.sh`,
  `.gitignore`, and `_config.yml`. GitHub Pages never publishes tooling:
  dot-paths (`.agents/`, `.gitignore`) are skipped by Jekyll itself, and
  `scripts/` is listed under `exclude:` (the verify script fails if it ever
  leaks into the build output).
- **In Freebuff project settings (outside the sandbox)** — the preview
  commands. They are stored by the platform, not in the workspace, so they
  load automatically in a new session. Re-create them any time with:

  ```sh
  freebuff-preview set-install 'command -v jekyll >/dev/null 2>&1 || gem install jekyll --no-document'
  freebuff-preview set 'jekyll serve --host 0.0.0.0 --port ${PORT:-4000}' 4000
  ```

- **Ephemeral (rebuilt with the sandbox)** — ruby/Jekyll itself and any
  Python imaging package. The install command reinstalls Jekyll on preview
  start; for image work run `pip install pillow pillow-avif-plugin` again.
  Git identity is **not** carried by the repo: `.git/config` is local to this
  workspace, Freebuff can overwrite it, and a fresh clone will not have it —
  so re-set it and verify the author before every commit (see step 9).
