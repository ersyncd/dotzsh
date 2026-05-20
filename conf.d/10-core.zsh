#!/usr/bin/env zsh

# --- CORE SETTINGS & COMPLETIONS ---

# Autoload completions
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Shell Options
setopt appendhistory
setopt INTERACTIVE_COMMENTS

# History Configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000