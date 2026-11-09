#!/bin/sh
# Points Casks/compagnion.rb at the newest release of innovative365nl/compagnion: the
# version and build from its tag (v<version>-<build>) and the SHA-256 of its disk image,
# as GitHub reports it. Run it after scripts/publish.sh in CodeCompagnion, then commit
# and push.
#
#   ./bump.sh [<tag>]
set -eu

here=$(cd "$(dirname "$0")" && pwd)
cask="$here/Casks/compagnion.rb"
releases=innovative365nl/compagnion

release=$(gh release view ${1:+"$1"} --repo "$releases" --json tagName,assets)
field() {
    printf '%s' "${release}" | python3 -c "
import json, sys
release = json.load(sys.stdin)
dmg = next(a for a in release['assets'] if a['name'].endswith('.dmg'))
print({'tag': release['tagName'], 'sha256': dmg['digest'].removeprefix('sha256:')}['$1'])"
}
tag=$(field tag)
sha256=$(field sha256)
version=$(printf '%s' "${tag}" | sed -n 's/^v\([0-9.]*\)-\([0-9]*\)$/\1,\2/p')
[ -n "${version}" ] || { echo "tag ${tag} is not v<version>-<build>" >&2; exit 1; }

sed -i '' \
    -e "s#^  version \".*\"#  version \"${version}\"#" \
    -e "s#^  sha256 \".*\"#  sha256 \"${sha256}\"#" \
    "${cask}"
echo "compagnion ${version} (${sha256}) from ${releases} ${tag}"
