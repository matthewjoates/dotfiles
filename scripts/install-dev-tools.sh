#!/bin/bash

# Development Tools Installation Script
# This script installs common development tools and environments

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Check if we're on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    PLATFORM="linux"
else
    log_warning "Unknown platform: $OSTYPE"
    PLATFORM="unknown"
fi

# Install Oh My Zsh
install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        
        # Install useful plugins
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        
        log_success "Oh My Zsh installed with plugins"
    else
        log_info "Oh My Zsh already installed"
    fi
}

# Install Node.js via NVM
install_node() {
    if [[ ! -d "$HOME/.nvm" ]]; then
        log_info "Installing NVM and Node.js..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        
        # Source nvm
        export NVM_DIR="$HOME/.nvm"
        [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
        
        # Install latest LTS Node.js
        nvm install --lts
        nvm use --lts
        nvm alias default node
        
        log_success "NVM and Node.js installed"
    else
        log_info "NVM already installed"
    fi
}

# Install Python via pyenv
install_python() {
    if ! command -v pyenv &> /dev/null; then
        log_info "Installing pyenv and Python..."
        
        if [[ "$PLATFORM" == "macos" ]]; then
            brew install pyenv
        elif [[ "$PLATFORM" == "linux" ]]; then
            curl https://pyenv.run | bash
        fi
        
        # Add pyenv to shell
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
        echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
        echo 'eval "$(pyenv init -)"' >> ~/.bashrc
        
        # Source pyenv
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        
        # Install latest Python
        PYTHON_VERSION=$(pyenv install --list | grep -E '^\s*[0-9]+\.[0-9]+\.[0-9]+$' | tail -1 | tr -d ' ')
        pyenv install $PYTHON_VERSION
        pyenv global $PYTHON_VERSION
        
        log_success "pyenv and Python $PYTHON_VERSION installed"
    else
        log_info "pyenv already installed"
    fi
}

# Install Docker
install_docker() {
    if ! command -v docker &> /dev/null; then
        log_info "Installing Docker..."
        
        if [[ "$PLATFORM" == "macos" ]]; then
            brew install --cask docker
            log_info "Docker installed. Please launch Docker Desktop manually."
        elif [[ "$PLATFORM" == "linux" ]]; then
            # Install Docker on Linux
            curl -fsSL https://get.docker.com -o get-docker.sh
            sh get-docker.sh
            sudo usermod -aG docker $USER
            rm get-docker.sh
            log_info "Docker installed. Please log out and back in for group changes to take effect."
        fi
        
        log_success "Docker installation completed"
    else
        log_info "Docker already installed"
    fi
}

# Install common development tools
install_dev_tools() {
    log_info "Installing development tools..."
    
    if [[ "$PLATFORM" == "macos" ]]; then
        # macOS tools via Homebrew
        brew install \
            git \
            curl \
            wget \
            tree \
            jq \
            htop \
            tmux \
            fzf \
            ripgrep \
            bat \
            fd \
            exa \
            tldr \
            gh \
            terraform \
            kubectl \
            helm \
            awscli \
            gcloud
            
        # Cask applications
        brew install --cask \
            visual-studio-code \
            iterm2 \
            postman \
            docker \
            figma \
            slack \
            zoom \
            notion \
            1password
            
    elif [[ "$PLATFORM" == "linux" ]]; then
        # Linux tools via apt
        sudo apt-get update
        sudo apt-get install -y \
            git \
            curl \
            wget \
            tree \
            jq \
            htop \
            tmux \
            fzf \
            ripgrep \
            bat \
            fd-find \
            build-essential \
            software-properties-common \
            apt-transport-https \
            ca-certificates \
            gnupg \
            lsb-release
            
        # Install VS Code
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
        sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
        sudo apt-get update
        sudo apt-get install -y code
    fi
    
    log_success "Development tools installed"
}

# Install VS Code extensions
install_vscode_extensions() {
    if command -v code &> /dev/null; then
        log_info "Installing VS Code extensions..."
        
        # Essential extensions
        code --install-extension ms-vscode.vscode-typescript-next
        code --install-extension ms-python.python
        code --install-extension ms-vscode.cpptools
        code --install-extension ms-vscode.cmake-tools
        code --install-extension ms-vscode.vscode-json
        code --install-extension bradlc.vscode-tailwindcss
        code --install-extension esbenp.prettier-vscode
        code --install-extension ms-vscode.vscode-eslint
        code --install-extension GitLab.gitlab-workflow
        code --install-extension ms-vscode-remote.remote-ssh
        code --install-extension ms-vscode-remote.remote-containers
        code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
        code --install-extension hashicorp.terraform
        code --install-extension ms-vscode.powershell
        code --install-extension redhat.vscode-yaml
        code --install-extension ms-vscode.vscode-docker
        
        log_success "VS Code extensions installed"
    else
        log_warning "VS Code not found, skipping extension installation"
    fi
}

# Main function
main() {
    log_info "=== Development Tools Installation Started ==="
    
    install_oh_my_zsh
    install_node
    install_python
    install_docker
    install_dev_tools
    install_vscode_extensions
    
    log_success "=== Development Tools Installation Complete ==="
    log_info "Please restart your terminal to ensure all changes take effect"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
