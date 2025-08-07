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
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
