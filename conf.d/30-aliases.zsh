#!/usr/bin/env zsh

# --- ALIASES ---

# Ensure lsd is installed before using it as the ls alias
if command -v lsd &> /dev/null; then
    alias ls='lsd'
    alias l='ls -l'
    alias la='ls -a'
    alias lla='ls -la'
    alias lt='ls --tree'
else
    alias l='ls -lah'
    alias la='ls -A'
    alias lla='ls -la'
fi

alias myip='curl icanhazip.com'
alias clear='printf "\033c"'