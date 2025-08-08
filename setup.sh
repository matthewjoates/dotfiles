#!/bin/bash

# Dotfiles Setup Script
# Run this script on a new machine to set up your development environment

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
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

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log_info "Starting dotfiles setup from: $DOTFILES_DIR"

# Function to backup existing files
backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        local backup
        backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        log_info "Backing up $file to $backup"
        cp "$file" "$backup"
    fi
}

# Function to create symlinks
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create target directory if it doesn't exist
    local target_dir
    target_dir="$(dirname "$target")"
    mkdir -p "$target_dir"
    
    # Backup existing file if it exists
    backup_file "$target"
    
    # Remove existing file/symlink
    rm -f "$target"
    
    # Create symlink
    ln -sf "$source" "$target"
    log_success "Created symlink: $target -> $source"
}

# Install Homebrew on macOS (removed - handled by install-dev-tools.sh)

# Install essential packages (removed - handled by install-dev-tools.sh)

# Setup shell configuration
setup_shell() {
    log_info "Setting up shell configuration..."
    
    # Setup shared profile first (contains common environment setup)
    if [[ -f "$DOTFILES_DIR/shell/.shared_profile" ]]; then
        create_symlink "$DOTFILES_DIR/shell/.shared_profile" "$HOME/.shared_profile"
    fi
    
    # Setup zsh configuration
    if [[ -f "$DOTFILES_DIR/shell/.zshrc" ]]; then
        create_symlink "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"
    fi
    
    # Setup zsh p10k configuration
    if [[ -f "$DOTFILES_DIR/shell/.p10k.zsh" ]]; then
        create_symlink "$DOTFILES_DIR/shell/.p10k.zsh" "$HOME/.p10k.zsh"
    fi

    # Setup bash configuration
    if [[ -f "$DOTFILES_DIR/shell/.bashrc" ]]; then
        create_symlink "$DOTFILES_DIR/shell/.bashrc" "$HOME/.bashrc"
    fi
    
    # Setup aliases
    if [[ -f "$DOTFILES_DIR/shell/.aliases" ]]; then
        create_symlink "$DOTFILES_DIR/shell/.aliases" "$HOME/.aliases"
    fi
    
    log_success "Shell configuration files linked"
    log_info "Note: Run 'chsh -s \$(which zsh)' manually after zsh is installed to change default shell"
}

# Setup git configuration
setup_git() {
    log_info "Setting up git configuration..."
    
    if [[ -f "$DOTFILES_DIR/git/.gitconfig" ]]; then
        create_symlink "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
    fi
    
    if [[ -f "$DOTFILES_DIR/git/.gitignore_global" ]]; then
        create_symlink "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
    fi
}

# Setup development tools
setup_dev_tools() {
    log_info "Setting up development tools..."
    
    # Run development tools installation script
    if [[ -f "$DOTFILES_DIR/scripts/install-dev-tools.sh" ]]; then
        bash "$DOTFILES_DIR/scripts/install-dev-tools.sh"
    fi
}

# Main setup function
main() {
    log_info "=== Dotfiles Setup Started ==="
    
    # Ask for confirmation
    read -p "This will install packages and modify your shell configuration. Continue? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Setup cancelled by user"
        exit 1
    fi
    
    # Run setup steps (package installation now handled by install-dev-tools.sh)
    setup_shell
    setup_git
    setup_dev_tools
    
    log_success "=== Dotfiles Setup Complete ==="
    log_info "Please restart your terminal or run 'source ~/.zshrc' to apply changes"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
