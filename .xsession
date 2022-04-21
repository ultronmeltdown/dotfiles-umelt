#!/bin/sh

[ -f "$HOME"/.config/shell/.aliasrc ] && . "$HOME"/.config/shell/.aliasrc
[ -f "$HOME"/.config/shell/.exportrc ] && . "$HOME"/.config/shell/.exportrc

xrdb -merge "${XDG_CONFIG_HOME:-$HOME/.config}/X11/.Xresources" &
pgrep clipmenud || clipmenud &
while true
do
    xset r rate 300 50
    sleep 60
done &
xset s 3600 3600 &
xss-lock slock +resetsaver &
pgrep sxhkd || sxhkd &
light -I &

exec herbstluftwm
