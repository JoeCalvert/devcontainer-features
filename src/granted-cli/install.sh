#!/usr/bin/env bash
set -e

source ./library_scripts.sh

# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-extra/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations,
# and if missing - will download a temporary copy that automatically get deleted at the end
# of the script
ensure_nanolayer nanolayer_location "v0.5.6"

case $(uname -sm) in
"Darwin x86_64") target="darwin_x86_64" ;;
"Darwin arm64") target="darwin_arm64" ;;
"Linux aarch64") target="linux_arm64" ;;
"Linux i386") target="linux_i386" ;;
*) target="linux_x86_64" ;;
esac

semver_regex="(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*)?(?:\+[0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*)?"

asset_regex="^granted_$semver_regex\_$target.tar.gz"

$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers-extra/features/gh-release:1.0.25" \
    --option repo='fwdcloudsec/granted' --option libName='granted' --option binaryNames='granted,assumego,assume,assume.fish' --option assetRegex="$asset_regex" --option version="$VERSION"

echo 'Done!'

