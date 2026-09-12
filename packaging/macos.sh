#!/bin/sh
set -euo pipefail
[[ "$(uname -s)" == Darwin ]] || { echo "The macOS app bundle must be built on macOS." >&2; exit 1; }
cd "$(dirname "${BASH_SOURCE[0]}")/.."
cargo b -r
app=target/release/Wallpaper.app
rm -rf "$app"
mkdir -p "$app/Contents/MacOS"
cp packaging/macos/Info.plist "$app/Contents/Info.plist"
install -m 755 target/release/wallpaper "$app/Contents/MacOS/wallpaper"
codesign --force --sign - "$app"
echo "Created $PWD/$app"
