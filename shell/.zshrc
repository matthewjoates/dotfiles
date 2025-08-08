#!/bin/zsh
# Matty's Zsh Configuration

# CI-friendly settings (disable problematic features in automated environments)
if [[ -n "$CI" || -n "$NONINTERACTIVE" ]]; then
    export ZSH_DISABLE_COMPFIX=true
    export DISABLE_AUTO_UPDATE=true
    export DISABLE_UPDATE_PROMPT=true
    export DISABLE_CORRECTION=true
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Load Powerlevel10k theme if installed
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Load aliases
[[ -f ~/.aliases ]] && source ~/.aliases


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

