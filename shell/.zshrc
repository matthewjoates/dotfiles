#!/bin/zsh
# Matty's Zsh Configuration

# CI-friendly settings (disable problematic features in automated environments)
if [[ -n "$CI" || -n "$NONINTERACTIVE" ]]; then
    export ZSH_DISABLE_COMPFIX=true
    export DISABLE_AUTO_UPDATE=true
    export DISABLE_UPDATE_PROMPT=true
    export DISABLE_CORRECTION=true
fi

# Theme selection: Set USE_POWERLEVEL10K=true to use Powerlevel10k, or leave unset/false for robbyrussell
# To switch: export USE_POWERLEVEL10K=true (or add to ~/.zshrc.local)
USE_POWERLEVEL10K="${USE_POWERLEVEL10K:-false}"

# Enable Powerlevel10k instant prompt (only if using p10k)
if [[ "$USE_POWERLEVEL10K" == "true" ]]; then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

# Load shared profile first (contains common environment setup)
[[ -f ~/.shared_profile ]] && source ~/.shared_profile

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"

# Set theme based on preference
if [[ "$USE_POWERLEVEL10K" == "true" ]]; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
else
  ZSH_THEME="robbyrussell"
fi

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

# Load Powerlevel10k config (only if using p10k)
if [[ "$USE_POWERLEVEL10K" == "true" ]]; then
  [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
fi

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

###### FINISH ######
