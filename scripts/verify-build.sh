#!/bin/sh
# Verify the Jekyll build for one article without writing into the repo.
# Usage: sh ./scripts/verify-build.sh <slug>
set -eu

SLUG="${1:-}"
if [ -z "$SLUG" ]; then
  echo "usage: sh ./scripts/verify-build.sh <slug>" >&2
  exit 2
fi

POST=""
for f in _posts/*-"$SLUG".md; do
  [ -e "$f" ] && POST="$f"
done
if [ -z "$POST" ]; then
  echo "FAIL: no post matches _posts/*-$SLUG.md" >&2
  exit 2
fi
echo "post: $POST"

OUT="$(mktemp -d)"
trap 'rm -rf "$OUT"' EXIT

if ! jekyll build --destination "$OUT" --disable-disk-cache >/dev/null; then
  echo "FAIL: jekyll build failed" >&2
  exit 1
fi
echo "build: ok ($OUT)"

fail() { echo "FAIL: $*" >&2; exit 1; }

IMAGE="$(sed -n 's/^image: *//p' "$POST" | head -1)"
THUMB="$(sed -n 's/^thumbnail: *//p' "$POST" | head -1)"
PAGE="$OUT/$SLUG/index.html"
ARCHIVE="$OUT/archive/index.html"

[ -f "$PAGE" ] || fail "post page not generated at /$SLUG/"
[ -f "$ARCHIVE" ] || fail "archive page not generated"

# hero: exactly one <img> pointing at the front-matter image
if [ -n "$IMAGE" ]; then
  n=$(grep -c "src=\"$IMAGE\"" "$PAGE") || true
  [ "$n" = "1" ] || fail "hero <$IMAGE> appears $n times on the post page (expected 1)"
  echo "hero: ok ($IMAGE)"
else
  grep -q '<div class="ns-hero">' "$PAGE" || fail "no hero on the post page"
  echo "hero: ok (from body image)"
fi

# archive row block for this slug (the <img> sits on a later line than <a ...>)
ROW="$(awk -v pat="href=\"/$SLUG/\"" '
  /class="ns-arow"/ && index($0, pat) { inrow = 1 }
  inrow { print }
  inrow && /<\/a>/ { exit }
' "$ARCHIVE")"
[ -n "$ROW" ] || fail "no archive row for /$SLUG/"
if [ -n "$THUMB" ]; then
  printf '%s\n' "$ROW" | grep -q "src=\"$THUMB\"" || fail "archive row does not use thumbnail <$THUMB>"
  echo "thumbnail: ok ($THUMB)"
else
  echo "thumbnail: none declared (falls back to image/body)"
fi

# every post still has an archive row (nothing silently dropped)
NPOSTS=$(ls _posts/*.md | wc -l | tr -d ' ')
NROWS=$(grep -c 'class="ns-arow"' "$ARCHIVE" || true)
[ "$NROWS" = "$NPOSTS" ] || fail "archive has $NROWS rows for $NPOSTS posts"
echo "rows: ok ($NROWS/$NPOSTS)"

# referenced assets exist in the output and are real JPEGs
for p in "$IMAGE" "$THUMB"; do
  [ -n "$p" ] || continue
  f="$OUT$p"
  [ -f "$f" ] || fail "asset missing from build output: $p"
  hdr=$(head -c 2 "$f" | od -An -tx1 | tr -d ' \n')
  [ "$hdr" = "ffd8" ] || fail "asset is not a JPEG: $p"
  echo "asset: ok ($p, $(wc -c < "$f" | tr -d ' ') bytes)"
done

# tooling must never ship with the site (GitHub Pages publishes this build)
[ ! -e "$OUT/scripts" ] || fail "scripts/ leaked into the build output"
echo "output: ok (no scripts/ in the published site)"

echo "PASS: $SLUG"
