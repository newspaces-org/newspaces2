# syntax=docker/dockerfile:1

# Preview of the GitHub Pages build for newspaces.org.
#
# GitHub Pages does not run `gem install jekyll`: it builds with the
# `github-pages` gem (Jekyll 3.10.0 + the plugin whitelist) in safe mode.
# This image installs that gem so a container preview matches the published
# site instead of the Jekyll 4 used for quick local builds.

FROM ruby:3.3-slim

# Pinned so the preview cannot drift from the build that produced the live site.
ARG GITHUB_PAGES_VERSION=232

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    JEKYLL_ENV=production

# build-essential covers platforms without precompiled gems (nokogiri,
# commonmarker, ffi); git and curl are there for the healthcheck and debugging.
RUN apt-get update \
 && apt-get install -y --no-install-recommends build-essential git curl \
 && rm -rf /var/lib/apt/lists/* \
 && gem install github-pages -v "${GITHUB_PAGES_VERSION}" --no-document \
 && jekyll --version

WORKDIR /srv/site
EXPOSE 4000

HEALTHCHECK --interval=10s --timeout=3s --start-period=25s --retries=6 \
  CMD curl -fsS http://127.0.0.1:4000/ >/dev/null || exit 1

# --safe mirrors Pages (whitelisted plugins only, _plugins ignored);
# --force_polling keeps --watch rebuilding across Docker bind mounts;
# --destination keeps the build out of the mounted checkout, so the container
# never leaves root-owned _site files behind in the repo.
CMD ["jekyll", "serve", "--safe", "--host", "0.0.0.0", "--port", "4000", "--watch", "--force_polling", "--destination", "/tmp/site"]
