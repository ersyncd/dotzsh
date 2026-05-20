#!/usr/bin/env zsh

# --- KEYBINDINGS ---

bindkey "^[[H" beginning-of-line       # Standard
bindkey "^[[F" end-of-line             # Standard
bindkey "^[[1;5C" forward-word         # Ctrl + Right Arrow
bindkey "^[[1;5D" backward-word        # Ctrl + Left Arrow
bindkey '^H' backward-kill-word        # Ctrl + Backspace
bindkey -s '^[[13;2u' '^V^J'