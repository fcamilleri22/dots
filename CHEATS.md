# Frankdots Cheatsheet
## Desktop Environment Controls
**win+mouse:** Left click to move a floating window, right click to resize one.

**win+Arrows:** Change active window

**win+Space:** Toggle between selecting floating windows and tiled windows

**win+Shift+Space:** Toggle selected window tiling/floating

**win+Shift+Arrows:** Move tiled window

**win+1-8:** Switch workspace

**win+Shift+1-8:** Move active window to workspace

**win+q:** Toggle window split on selected window (where the next window will open, should you open another)

**win+f:** Toggle fullscreen

**win+Enter:** Open a Terminal

**win+Shift+Enter:** Open Firefox

**win+F1:** Open a File Manager (`pcmanfm`)

**win+F2:** Open a minimal text editor (`mousepad`)

**win+D:** Open the Rofi Program Launcher (pretty much our "start" menu)

**win+H:** Brings up this cheatsheet.

**win+Shift+S:** Make window sticky.

**win+a:** Focus next parent window. If already at top, focus all windows on workspace. Useful for clearing a whole workspace with win+Shift+q.

**win+s:** Change to stacking layout.

**win+w:** Change to tabbed layout.

**win+e:** Toggle split (default) layout.

**win+Shift+-:** Add selected window to scratchpad. Scratchpad windows can be quickly brought up to the top of any workspace you're on, and quickly hidden. Useful for references on small screens, or for having a quick terminal always handy.

**win+-:** Show scratchpad/cycle through scratchpad windows.


**win+r:** Engage window resize mode. Arrow keys to change window size of selected window, **Esc** to go back to normal operation.

**PrintScr:** Take a screenshot

## How do I update these configs with newer versions?
1. Pull the latest master.
2. If it is a new version, run ~/Scripts/updateDots.sh, which should bring everything up to speed.

## What's Handling What, Where
**Top Bar:**
`polybar` | dots/polybar/.config/polybar/config

**Window Manager, Desktop Hotkeys, Userland Autostart:** `i3` | dots/i3/.i3/config

**Notifications:** `dunst` | dots/wal/templates/colors-dunst

**Launcher:** `rofi` | dots/wal/templates/colors-rofi

**Terminal:** `urxvt` | dots/shell/.Xresources

**Shell:** `zsh` | dots/shell/[.zshrc, .profile]

**Monitors/Kernels/GPU Drivers:** Invoke `mhwd-tui` in a terminal.

**Atom Theme:** dots/atom/.atom, colors handled in dots/wal/.config/wal/templates

## Changing interface color themes/wallpapers

#### Note: if a program you're using does not theme properly, create an issue. Some programs, namely those that use GTK3, need to be restarted before theme changes take effect.

All wallpapering is handled by `nitrogen.` By default, the wallpaper changes every 10 minutes to any random image in the folder `~/Pictures/Wallpapers`, which is created during the install script. To change this behavior, edit `~/Scripts/rotateWallpapers.sh`


`retheme-by-theme [THEMENAME]` changes interface colors according to the themes that come packaged with `pywal`. Invoking this without an argument will return all possible themes. My personal favorites are `base16-gruvbox-hard`, `sexy-neon` (the default), `base16-outrun`, and `base16-black-metal-venom`.


`retheme-by-image{0-4} [IMAGELOCATION]` changes interface colors according to the dominant color palette of an input image. `retheme-by-image0` uses the default `wal` backend to determine this palette, and the other invocations use different backends, which yield different palettes. **Changing the theme according to a wallpaper slideshow is NOT recommended because the generated themes are not always comfortably readable, and because many applications require a restart for theme changes to fully take effect.**

#### For best results, stick to using/editing these wrappers, located at `~/Scripts/ and ~/Scripts/PATHed/` instead of invoking `wal` directly. This not only keeps cli arguments simple, but also maintains a seperation of concerns between `wal` and `nitrogen` so they do not both try to control your wallpaper.
