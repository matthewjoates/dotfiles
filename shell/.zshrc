#!/bin/zsh
# Matty's Zsh Configuration

# Load shared profile first (contains common environment setup)
[[ -f ~/.shared_profile ]] && source ~/.shared_profile

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh My Zsh plugins
plugins=(
    git
    brew
    macos
    node
    npm
    python
    docker
    kubectl
    terraform
    aws
    vscode
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Load Oh My Zsh if it exists
[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

# Load aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Environment Variables - Now loaded from shared profile
# export EDITOR='code'
# export VISUAL='code'

# Homebrew - Now loaded from shared profile
# if [[ -f "/opt/homebrew/bin/brew" ]]; then
#     eval "$(/opt/homebrew/bin/brew shellenv)"
# fi

# Node.js - Now loaded from shared profile
# export NVM_DIR="$HOME/.nvm"
# [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
# [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# Python - Now loaded from shared profile
# if command -v pyenv 1>/dev/null 2>&1; then
#     eval "$(pyenv init -)"
# fi

# PATH - Now loaded from shared profile
# export PATH="$HOME/.local/bin:$PATH"

# Functions and aliases - Now loaded from shared profile
# mkcd() {
#     mkdir -p "$1" && cd "$1"
# }

# Git shortcuts - Now loaded from shared profile
# gst() { git status; }
# gco() { git checkout "$@"; }
# gpl() { git pull; }
# gps() { git push; }

# Quick navigation - Now loaded from shared profile
# alias ..='cd ..'
# alias ...='cd ../..'
# alias ....='cd ../../..'

# Zsh-specific settings
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# Case-insensitive completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Load custom local configuration if it exists
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Show welcome message for interactive zsh sessions (only once per session)
if [[ $- == *i* ]] && [[ -z "$ZSH_WELCOME_SHOWN" ]]; then
    show_welcome
    export ZSH_WELCOME_SHOWN=1
fi

