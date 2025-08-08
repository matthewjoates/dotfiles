#!/bin/bash
# Matthew's Bash Configuration

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Load shared profile first (contains common environment setup)
[[ -f ~/.shared_profile ]] && source ~/.shared_profile

# Load aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Bash-specific settings
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

# Bash-specific prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Load custom local configuration if it exists
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

# Show welcome message for interactive bash sessions (only once per session)
if [[ $- == *i* ]] && [[ -z "$BASH_WELCOME_SHOWN" ]]; then
    show_welcome
    export BASH_WELCOME_SHOWN=1
fi

###### FINSIHED ######
