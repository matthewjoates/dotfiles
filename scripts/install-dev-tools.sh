#!/bin/bash

# Development Tools Installation Script
# This script installs common development tools and environments

set -e  # Exit on error
# Note: Removed 'set -e' to allow script to continue even if individual tools fail

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

# Check if we're on macOS or Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    PLATFORM="linux"
    # Set non-interactive mode for Debian-based systems (Ubuntu, Debian)
    if command -v apt-get &> /dev/null; then
        export DEBIAN_FRONTEND=noninteractive
        log_info "Detected Debian-based system, setting DEBIAN_FRONTEND=noninteractive"
    fi
else
    log_warning "Unknown platform: $OSTYPE"
    PLATFORM="unknown"
fi

# Install zsh first (required for Oh My Zsh)
install_zsh() {
    if ! command -v zsh &> /dev/null; then
        log_info "Installing zsh..."
        
        if [[ "$PLATFORM" == "macos" ]]; then
            # zsh comes pre-installed on modern macOS, but ensure it's available
            if ! command -v zsh &> /dev/null; then
                brew install zsh
            fi
        elif [[ "$PLATFORM" == "linux" ]]; then
            # Install zsh on Linux systems
            if command -v apt-get &> /dev/null; then
                sudo apt-get update
                sudo apt-get install -y zsh
            elif command -v yum &> /dev/null; then
                sudo yum install -y zsh
            elif command -v brew &> /dev/null; then
                brew install zsh
            else
                log_error "No package manager found to install zsh"
                return 1
            fi
        fi
        
        log_success "zsh installed"
    else
        log_info "zsh already installed"
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        
        # Install powerlevel10k theme
        if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
            log_info "Installing powerlevel10k theme..."
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
        fi
        
        # Install useful plugins (only if they don't exist)
        if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
            log_info "Installing zsh-autosuggestions plugin..."
            git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
        fi
        if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
            log_info "Installing zsh-syntax-highlighting plugin..."
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
        fi
        
        log_success "Oh My Zsh installed with plugins and theme"
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
        # shellcheck source=/dev/null
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
        
        
        # Source pyenv
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        
        # Install stable Python version
        PYTHON_VERSION="3.12.8"  # Use stable LTS version
        log_info "Installing Python ${PYTHON_VERSION}..."
        if pyenv install "$PYTHON_VERSION" 2>/dev/null || true; then
            pyenv global "$PYTHON_VERSION" 2>/dev/null || true
            log_success "Python ${PYTHON_VERSION} installed"
        else
            log_warning "Python installation failed, using system Python"
        fi
        
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
            if sudo usermod -aG docker "$USER" 2>/dev/null; then
                log_info "Added user to docker group"
            fi
            rm get-docker.sh
            log_info "Docker installed. Please log out and back in for group changes to take effect."
        fi
        
        log_success "Docker installation completed"
    else
        log_info "Docker already installed"
    fi
}

# Install Java via SDKMAN!
install_java() {
    log_info "Installing Java via SDKMAN!..."
    
    # Install SDKMAN!
    if [[ ! -d "$HOME/.sdkman" ]]; then
        log_info "Installing SDKMAN!..."
        
        # Download and install SDKMAN with better error handling
        if curl -s "https://get.sdkman.io" | bash; then
            # Wait for installation to complete
            sleep 3
            
            # Ensure required directories exist
            mkdir -p "$HOME/.sdkman/ext"
            mkdir -p "$HOME/.sdkman/tmp"
            
            log_success "SDKMAN! installed"
        else
            log_error "SDKMAN! installation failed"
            return 0  # Return success to not stop the script
        fi
    else
        log_info "SDKMAN! already installed"
        
        # Ensure required directories exist for existing installations
        mkdir -p "$HOME/.sdkman/ext"
        mkdir -p "$HOME/.sdkman/tmp"
    fi
    
    # Source SDKMAN for current session with better error handling
    if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
        # Export SDKMAN_DIR before sourcing
        export SDKMAN_DIR="$HOME/.sdkman"
        
        # shellcheck source=/dev/null
        if source "$HOME/.sdkman/bin/sdkman-init.sh" 2>/dev/null; then
            log_info "SDKMAN initialized successfully"
        else
            log_warning "SDKMAN initialization had warnings, but continuing"
        fi
        
        # Verify sdk command is available
        if ! command -v sdk &> /dev/null; then
            log_warning "SDK command not available after sourcing SDKMAN"
            return 0
        fi
    else
        log_warning "SDKMAN init script not found, skipping Java installation"
        return 0
    fi
    
    # Install Java with better error handling
    if ! command -v java &> /dev/null; then
        log_info "Installing Java..."
        if sdk install java 21.0.5-tem 2>/dev/null; then
            log_success "Java installed"
        else
            log_warning "Java installation failed, but continuing"
        fi
    else
        log_info "Java already installed"
    fi
    
    # Install Maven with better error handling
    if ! command -v mvn &> /dev/null; then
        log_info "Installing Maven..."
        if sdk install maven 2>/dev/null; then
            log_success "Maven installed"
        else
            log_warning "Maven installation failed, but continuing"
        fi
    else
        log_info "Maven already installed"
    fi
}

# Install Homebrew on Linux if not present
install_homebrew_linux() {
    if ! command -v brew &> /dev/null; then
        log_info "Installing Homebrew on Linux..."
        
        # Set non-interactive mode to avoid prompts
        export NONINTERACTIVE=1
        
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for current session
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        
        
        log_success "Homebrew installed on Linux"
    else
        log_info "Homebrew already installed"
        # Ensure brew is in PATH even if already installed
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null || true
    fi
}


# Install common development tools
install_dev_tools() {
    log_info "Installing development tools..."
    
    if [[ "$PLATFORM" == "linux" ]]; then
        # Install Homebrew on Linux first
        install_homebrew_linux
        # Ensure brew is available in current session
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null || true
        
        # Debug: Check if brew is working
        if command -v brew &> /dev/null; then
            log_info "Homebrew is available, version: $(brew --version | head -1)"
        else
            log_error "Homebrew not found in PATH after installation"
            return 1
        fi
    fi
    
    log_info "Installing common tools via Homebrew..."
    # Install tools in smaller batches to avoid timeouts
    
    # Essential CLI tools first
    log_info "Installing essential CLI tools..."
    if brew install git curl wget tree jq htop; then
        log_success "Essential CLI tools installed"
    else
        log_warning "Some essential CLI tools failed to install"
        return 1
    fi
    
    # Development tools
    log_info "Installing development tools..."
    if brew install gh terraform kubectl helm awscli; then
        log_success "Development tools installed" 
    else
        log_warning "Some development tools failed to install"
        return 1
    fi
    
    # Text editors and database tools
    log_info "Installing editors and database tools..."
    if brew install vim neovim postgresql; then
        log_success "Editors, PostgreSQL"
    else
        log_warning "Some editors/databases failed to install"
        return 1
    fi
    
    # Terminal and productivity tools
    log_info "Installing terminal and productivity tools..."
    if brew install tmux fzf ripgrep bat fd eza; then
        log_success "Terminal tools installed"
    else
        log_warning "Some terminal tools failed to install"
        return 1
    fi
    
    # AWS and security tools
    log_info "Installing AWS and security tools..."
    if brew install aws-sam-cli; then
        log_success "AWS and security tools installed"
    else
        log_warning "Some AWS/security tools failed to install"
        return 1
    fi
        
    # Platform-specific installations
    if [[ "$PLATFORM" == "macos" ]]; then
        # macOS-specific tools
        
        # Cask applications (macOS only)
        brew install --cask \
            visual-studio-code \
            ghostty \
            postman \
            docker \
    fi
    
    log_success "Development tools installed"
}

# Install VS Code extensions (macOS only)
install_vscode_extensions() {
    if [[ "$PLATFORM" == "macos" ]] && command -v code &> /dev/null; then
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
    elif [[ "$PLATFORM" == "linux" ]]; then
        log_info "Skipping VS Code extensions on Linux (using vim/nvim instead)"
    else
        log_warning "VS Code not found on macOS, skipping extension installation"
    fi
}

# Setup shell configuration (run after all tools are installed)
setup_shell_config() {
    log_info "Setting up shell configuration..."
    
    # Setup shared profile first (contains common environment setup)
    if [[ -f "/workspace/shell/.shared_profile" ]]; then
        ln -sf "/workspace/shell/.shared_profile" "$HOME/.shared_profile"
        log_success "Shared profile linked"
    fi
    
    # Setup zsh configuration (after Oh My Zsh installation)
    if [[ -f "/workspace/shell/.zshrc" ]]; then
        ln -sf "/workspace/shell/.zshrc" "$HOME/.zshrc"
        log_success "Custom .zshrc linked"
    fi
    
    # Setup bash configuration
    if [[ -f "/workspace/shell/.bashrc" ]]; then
        ln -sf "/workspace/shell/.bashrc" "$HOME/.bashrc"
        log_success "Custom .bashrc linked"
    fi
    
    # Setup aliases
    if [[ -f "/workspace/shell/.aliases" ]]; then
        ln -sf "/workspace/shell/.aliases" "$HOME/.aliases"
        log_success "Aliases linked"
    fi
    
    log_success "Shell configuration setup complete"
}

# Main function
main() {
    log_info "=== Development Tools Installation Started ==="
    
    install_dev_tools || { log_warning "Development tools installation had issues"; true; }
    install_zsh || { log_warning "Zsh installation had issues"; true; }
    install_oh_my_zsh || { log_warning "Oh My Zsh installation had issues"; true; }
    install_node || { log_warning "Node.js installation had issues"; true; }
    install_python || { log_warning "Python installation had issues"; true; }
    install_java || { log_warning "Java installation had issues"; true; }
    install_docker || { log_warning "Docker installation had issues"; true; }
    install_vscode_extensions || { log_warning "VS Code extensions installation had issues"; true; }
    
    # Setup shell configuration after all tools are installed
    setup_shell_config || { log_warning "Shell configuration had issues"; true; }
    
    log_success "=== Development Tools Installation Complete ==="
    log_info "Please restart your terminal to ensure all changes take effect"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
