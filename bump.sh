#!/bin/sh
# Points Casks/compagnion.rb at the newest Compagnion on the download site: version,
# build and SHA-256 from <site>/downloads/latest.json (written by compagnion-website's
# build.sh). Run it after deploying a new build of the site, then commit and push.
#
#   ./bump.sh [--site <url>] [--json <latest.json>]
#
# --json reads a local latest.json (e.g. compagnion-website/dist/downloads/latest.json)
# instead of the one on the site; the cask keeps pointing at --site.
set -eu

here=$(cd "$(dirname "$0")" && pwd)
cask="$here/Casks/compagnion.rb"
site=$(sed -n 's#^  homepage "\(.*\)/"$#\1#p' "$cask")
json=""
while [ $# -gt 0 ]; do
    case "$1" in
        --site) site="${2%/}"; shift 2 ;;
        --json) json="$2"; shift 2 ;;
        *) echo "usage: $0 [--site <url>] [--json <latest.json>]" >&2; exit 2 ;;
    esac
done

if [ -n "$json" ]; then
    latest=$(cat "$json")
else
    latest=$(curl -fsSL "$site/downloads/latest.json")
fi
field() { printf '%s' "$latest" | python3 -c "import json, sys; print(json.load(sys.stdin)['$1'])"; }
version=$(field version)
build=$(field build)
sha256=$(field sha256)

sed -i '' \
    -e "s#^  version \".*\"#  version \"$version,$build\"#" \
    -e "s#^  sha256 \".*\"#  sha256 \"$sha256\"#" \
    -e "s#https://[^/\"]*/#$site/#g" \
    "$cask"
echo "compagnion ${version},${build} (${sha256}) from ${site}"
