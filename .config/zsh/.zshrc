#

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%F{#2E992E}%n%F{#FFFFFF}@%F{#ADFF2F}%M%B %F{#00FA9A}%~
%F{#7CFC00}$%{$reset_color%}%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/.aliasrc" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/shell/.aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/.exportrc" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/shell/.exportrc"

. "$HOME"/.local/share/cargo/env

# This is to load necessary stuff from installed programs
for i in /home/linuxbrew/.linuxbrew/etc/profile.d/*
do
    [ -f "$i" ] && . "$i"
done

zmodload zsh/zprof

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

eval "$(dircolors "$XDG_CONFIG_HOME"/shell/.dircolors)"

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Case insensitive
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Plugin:
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load powerlevel10k theme
#zinit ice depth"1" # git clone depth
#zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
#[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

#zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zdharma-continuum/history-search-multi-word
#zinit light zdharma-continuum/zui
#zinit light zdharma-continuum/zbrowse

lsgame() {
    printf "%s\n" "$(find /usr/games -type f | sed 's/\/usr\/games\///g' | tr '\n' ' ')"
}

renbook() {
    find "$HOME"/Documents/Ebook -type f \( -iname "*z-lib*" -o -iname "*libgen*" -o -iname "*pdfcoffee*" \) | while read -r i; do mv -v "$i" "$(echo $i | sed 's/ (z-lib\.org)//g; s/ - libgen\.li//g; s/ - libgen\.lc//g; s/ - libgen\.\.pdf//g; s/pdfcoffee\.com_//g; s/-pdf-free//g')"; done
}

rennote() {
    find "$HOME"/Documents/Note -type f -iname "*pdfcoffee*" | while read -r i; do mv -v "$i" "$(echo $i | sed 's/pdfcoffee\.com_//g; s/-pdf-free//g')"; done
}

rga-fzf() { # rga-fzf foo, require rga
    RG_PREFIX="rga --files-with-matches"
    local file
    file="$(
        FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
        fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
        --phony -q "$1" \
        --bind "change:reload:$RG_PREFIX {q}" \
        --preview-window="70%:wrap"
    )" &&
    echo "opening $file" &&
    xdg-open "$file"
}

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zload_conda() {
    export CONDARC="$XDG_CONFIG_HOME"/conda/condarc
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/ron/.local/share/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/ron/.local/share/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/home/ron/.local/share/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/ron/.local/share/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    conda activate
}

zload_fnm() {
    export PATH="$PATH:$XDG_DATA_HOME/fnm"
    eval "`fnm env`"
}

zload_rbenv() {
    export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
    export PATH="$PATH:$RBENV_ROOT/bin"
    eval "$(rbenv init - zsh)"
}

uall() {
    sudo apt update && sudo apt upgrade -y && sudo apt clean
    zinit update --all
    nvim +PlugUpgrade +PlugUpdate +qall
    nix-channel --update && nix-env --delete-generations old && nix-collect-garbage
    rustup self update
    gup update
    conda update --all && conda clean -a
    brew upgrade
    pnpm -g up
    #sudo snap refresh
    #sudo flatpak update
}
