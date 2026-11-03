# FloatNote Lite

A small floating notepad for macOS. You don't need an account, a key or the internet to use it.

## Install
1. Download `FloatNote-Lite.dmg` from the Releases page and open it.
2. Drag **FloatNote Lite** into Applications.
3. The app isn't signed by Apple, so the first time you open it, **right-click it and choose Open**, then click **Open** again.
   If macOS still blocks it, go to System Settings > Privacy & Security and click **Open Anyway**, or run:
   `xattr -dr com.apple.quarantine "/Applications/FloatNote Lite.app"`
4. When macOS asks, allow Accessibility (System Settings > Privacy & Security > Accessibility). The Right Option shortcut needs it.

## Use
- **Right Option** (tap): show or hide the note.
- **⌘N** new note, **⌘O** all notes, **⌘,** Settings, **⌘/** the shortcut cheat sheet.
- **fn F**: fullscreen writing. **fn P**: paragraph mode. **fn O**: the headings navigator.
- **⌃⌥S** in any app: add the selected text to your note.
- Your notes are plain `.txt` files in `~/Documents/FloatNote Lite`.

The first time you open it, a tutorial note walks you through everything.

## Build from source
You need Apple's command line tools (`xcode-select --install`). Then run:

    bash build.sh
    open "build/FloatNote Lite.app"

Bundled fonts are under the SIL Open Font License or Apache 2.0. Each font folder has its licence file.
