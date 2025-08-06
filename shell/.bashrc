# Matthew's Bash Configuration

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Load aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Environment Variables
export EDITOR='code'
export VISUAL='code'

# Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Node.js (if using nvm)
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# Python (if using pyenv)
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Custom prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# History settings
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth
shopt -s histappend

# Check window size and update LINES and COLUMNS
shopt -s checkwinsize

# Custom functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Git shortcuts
gst() { git status; }
gco() { git checkout "$@"; }
gpl() { git pull; }
gps() { git push; }

# Load custom local configuration if it exists
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

echo "🚀 Welcome back, Matthew!"
