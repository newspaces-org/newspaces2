---
name: preview-and-publish
description: Take a previewed NewSpaces.org article live — preflight the working tree, commit as the site's author, push to main, and confirm the GitHub Pages build actually serves the new URL.
metadata:
  category: content
  framework: jekyll
---
# Publishing an article to NewSpaces.org

Use this when the user asks to post/publish an article that has been previewed.
The preview itself belongs to `preview-article`; writing the post and its images
belongs to `update-article`. This skill is the publish half only.

## Knowledge

- **Publishing is a push to `main`** in `newspaces-org/newspaces`. GitHub Pages
  builds it and serves `newspaces.org` (CNAME). There is no deploy step, no
  artifact to upload, and no hosting builder to configure.
- **Pages builds with the `github-pages` gem** — currently **232 → Jekyll
  3.10.0** — in safe mode. A green local Jekyll 4 build says nothing about
  plugin support: safe mode ignores `_plugins/` and non-whitelisted plugins.
- **A push is not a live site.** Pages rebuilds in roughly a minute; until it
  finishes, the new URL is a 404.
- **Future-dated posts never go live** under the default `future: false`, even
  though the push succeeds.
- **Do not add a `Gemfile`** (Pages ignores it and it misleads local runs) or
  Jekyll plugins.
- The repo's verify script passes on both Jekyll 3.10 and Jekyll 4.

## Instructions

### 1. Preflight

- Require a PASS for this slug:
  `sh ./scripts/verify-build.sh <slug>` — or, with the preview container up,
  `docker compose exec preview sh ./scripts/verify-build.sh <slug>`.
  If it fails, fix the source; never weaken the script.
- `git status --porcelain` must show only the post, its assets and intended
  tooling — no `_site/`, no `.jekyll-cache/`, no `.vly-run/`.
- Confirm the post's date is today or earlier.

### 2. Decide what goes in the commit

Only this article's files plus any deliberate tooling change. Read `git diff`
and `git log --oneline -5` first, so the message and scope match the repo.

### 3. Commit as the site's author

```sh
git config user.name "Newspaces"
git config user.email "info@newspaces.org"
git add "_posts/YYYY-MM-DD-<slug>.md" "assets/articles/<slug>"
git commit --author="Newspaces <info@newspaces.org>" -m "$(cat <<'EOF'
<one plain sentence about why this article goes live>
EOF
)"
git log -1 --format='%an <%ae>'
```

Identity gotcha: Freebuff rewrites `.git/config` during managed git
operations, so set it repo-locally, pass `--author`, and verify immediately
after committing. Message style is one descriptive sentence about *why* — no
conventional-commit prefix. End with:

```
🤖 Generated with Codebuff
Co-Authored-By: Codebuff <noreply@codebuff.com>
```

Omit the footer only if the user declined attribution.

### 4. Push — only when the user asked to publish

`git push origin HEAD:main`. A preview request is not authorization to go live;
"post it" / "publish it" is.

### 5. Verify the live site

Poll the real URL rather than trusting the push:

```sh
for i in $(seq 1 30); do
  code=$(curl -s -o /dev/null -w '%{http_code}' "https://newspaces.org/<slug>/")
  [ "$code" = "200" ] && break
  sleep 10
done
curl -s "https://newspaces.org/<slug>/" | grep -o '<title>[^<]*</title>'
curl -s https://newspaces.org/archive/ | grep -c 'class="ns-arow"'
```

Also confirm the post shows on the home page. Report the status codes and URLs
you actually fetched; a successful push is not proof of a live article.

## Checklist

- [ ] `verify-build.sh <slug>` PASS, `git status` clean of build output
- [ ] Post date is not in the future
- [ ] Commit authored `Newspaces <info@newspaces.org>` and verified
- [ ] Pushed only on an explicit publish request
- [ ] Live URL 200 with the right title, archive row and home listing

## Troubleshooting

- **Pages build fails** — safe mode: remove custom plugins, `_plugins/`, or
  non-whitelisted `plugins:` entries. A local Jekyll 4 pass proves nothing here.
- **Live 404 after a few minutes** — build still queued, the post is
  future-dated, or the file was never committed (still untracked).
- **Wrong author in history** — `.git/config` was overwritten; re-set it and
  amend with `--author` **before** pushing (amending after a push needs a force
  push — ask the user, never do it unprompted).
- **Post missing from `/archive/`** — front matter lacks `title`/`layout`, or its
  tag is not in `elements` in `_config.yml`.
- **Home page does not show it** — another post is pinned with `featured: true`,
  or a newer post outranks it.

## Persistence across sessions

- **Durable**: the commit and the Pages build. Nothing else about publishing is
  stored in the workspace.
- **Ephemeral**: the local Ruby/Jekyll install, the Docker image, and any
  preview container.
