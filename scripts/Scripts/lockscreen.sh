#!/bin/sh
##Solve for font sizes as proportional to vertical resolution
VRES=$(xdpyinfo | grep dimensions | cut -d " " -f 7 | cut -d "x" -f 1)
TITLESIZE=$((VRES/40))
SUBSIZE=$((VRES/60))
BARWIDTH=$((VRES/20))

INDICATOR_AMPLITUDE=$((VRES/6))
INDICATOR_LAMBDA=$((VRES/500))
INDICATOR_PERIOD=$((VRES/30))
INDICATOR_DELTA=$BARWIDTH

##Get a random wallpaper to use as a lock screen
##Blur takes too long and aint ever blurry enough.
WALLPAPERDIR=$HOME/Pictures/Wallpapers
WALLPAPER=$WALLPAPERDIR/"$(ls $WALLPAPERDIR | shuf | head -n 1)"

##Get enough dominant colors from wallpaper for indicators
BG_COLORS=$(colorz "$WALLPAPER" -n 2 --no-preview)

BG_COLOR="$(echo $BG_COLORS | cut -d " " -f 2)"80
VER_COLOR="$(echo $BG_COLORS | cut -d " " -f 4)"80
TEXT_COLOR='#FFFFFFFF'
WRONG_COLOR='#FF0000C0'

/usr/bin/i3lock                 \
    -i "$WALLPAPER"             \
    --screen 1                  \
    --force-clock               \
    --indicator                 \
    --refresh-rate=0.04         \
\
    --ringvercolor=$VER_COLOR       \
    --veriftext=" "                 \
    --ringwrongcolor=$WRONG_COLOR   \
    --wrongtext=" "                 \
\
    --bar-indicator                         \
    --indpos="w*0.05:h*0.8"                 \
    --bar-width=$INDICATOR_LAMBDA           \
    --bar-direction=2                       \
    --bar-max-height=$INDICATOR_AMPLITUDE   \
    --bar-base-width=$BARWIDTH              \
    --bar-step=$INDICATOR_DELTA             \
    --bar-periodic-step=$INDICATOR_PERIOD   \
    --bar-color=$BG_COLOR                   \
    --keyhlcolor=$BG_COLOR                  \
    --bshlcolor=$BG_COLOR                   \
    --bar-position="iy"                     \
\
    --timecolor=$TEXT_COLOR                 \
    --timepos="ix:iy+$TITLESIZE"            \
    --timestr="%I:%M %p  -  %A, %B %d, %Y"  \
    --timesize=$TITLESIZE                   \
    --time-font=ubuntu                      \
    --time-align=1                          \
\
    --datecolor=$TEXT_COLOR                 \
    --datepos="ix:ty+$SUBSIZE"              \
    --datestr="Enter password to unlock..." \
    --date-font=ubuntu                      \
    --datesize=$SUBSIZE                     \
    --date-align=1                          \
\
