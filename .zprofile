#!/bin/zsh

[ -f "$HOME/.config/shell/.exportrc" ] && . "$HOME/.config/shell/.exportrc"
[ -f "$HOME/.config/shell/.aliasrc" ] && . "$HOME/.config/shell/.aliasrc"

unsetopt PROMPT_SP

# Start X
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && [ "$(tty)" = "/dev/tty1" ]
then
	exec startx
fi
