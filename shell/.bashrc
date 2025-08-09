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

# Color variables for logging and prompt
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Colored logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}
log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}
log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}
log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Optional: colored prompt
PS1='\[\033[0;34m\]\u@\h\[\033[0m\]:\[\033[0;32m\]\w\[\033[0m\]\$ '

# Custom LS_COLORS for file types (Linux)
export LS_COLORS="di=34:ln=36:so=35:pi=33:ex=32:bd=34;46:cd=34;43:su=37;41:sg=30;43:tw=30;42:ow=34;42"

# Example: add custom color for *.sh and *.java files
export LS_COLORS="$LS_COLORS:*.sh=01;32:*.bash=01;32:*.zsh=01;32:*.py=01;36:*.js=01;33:*.ts=01;33:*.java=01;35:*.c=01;34:*.cpp=01;34:*.go=01;36:*.rb=01;31:*.php=01;35:*.rs=01;31:*.swift=01;35:*.kt=01;35"


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



###### FINISH ######