#!/usr/bin/env zsh

# --- THEMES & PROMPT VISUAL ---

# Starship (Prompt 1 ❱)
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# Fastfetch (Only show on interactive login / not in a subshell)
if [[ -z "$VTE_VERSION" ]] && command -v fastfetch &> /dev/null; then
    if [ -f "$HOME/.config/fastfetch/config-compact.jsonc" ]; then
        fastfetch -c ~/.config/fastfetch/config-compact.jsonc
    else
        fastfetch
    fi
fi