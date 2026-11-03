#!/bin/bash
# Builds "build/FloatNote Lite.app" from FloatNote.swift. Run it from this folder:  bash build.sh
# Needs Apple's command line tools (xcode-select --install). Installs nothing.
set -euo pipefail
cd "$(dirname "$0")"

NAME="FloatNote Lite"
ID="local.floatnote.lite"
VERSION="1.0"
APP="build/$NAME.app"

command -v swiftc >/dev/null 2>&1 || { echo "Run: xcode-select --install, then run this again."; exit 1; }

echo "Building ${NAME} ${VERSION}..."
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
swiftc -O -swift-version 5 FloatNote.swift -o "$APP/Contents/MacOS/FloatNote"

# Bundled fonts (SIL OFL / Apache, each folder has its licence file).
[ -d fonts ] && cp -R fonts "$APP/Contents/Resources/Fonts"

cat > "$APP/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleName</key><string>$NAME</string>
  <key>CFBundleDisplayName</key><string>$NAME</string>
  <key>CFBundleIdentifier</key><string>$ID</string>
  <key>CFBundleExecutable</key><string>FloatNote</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleShortVersionString</key><string>$VERSION</string>
  <key>CFBundleVersion</key><string>1</string>
  <key>LSMinimumSystemVersion</key><string>13.0</string>
  <key>LSUIElement</key><true/>
</dict>
</plist>
PLIST

# App icon from the 1024 px PNG.
if [ -f floatnote-icon-1024.png ]; then
  ICONSET="$(mktemp -d)/FloatNote.iconset"; mkdir -p "$ICONSET"
  for s in 16 32 128 256 512; do
    sips -z $s $s floatnote-icon-1024.png --out "$ICONSET/icon_${s}x${s}.png" >/dev/null
    sips -z $((s*2)) $((s*2)) floatnote-icon-1024.png --out "$ICONSET/icon_${s}x${s}@2x.png" >/dev/null
  done
  iconutil -c icns "$ICONSET" -o "$APP/Contents/Resources/FloatNote.icns"
  /usr/libexec/PlistBuddy -c "Add :CFBundleIconFile string FloatNote" "$APP/Contents/Info.plist" >/dev/null
fi

# Ad-hoc signature (no certificate needed).
codesign --force --deep --sign - -i "$ID" "$APP"
echo "Done: $APP"
