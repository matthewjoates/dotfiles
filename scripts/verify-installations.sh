#!/bin/bash

# Installation Verification Script
# This script verifies that all development tools were installed correctly

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

# Verification function
verify_command() {
    local cmd=$1
    local name=$2
    if command -v "$cmd" >/dev/null 2>&1; then
        log_success "✓ $name installed"
    else
        log_error "✗ $name not found"
    fi
}

# Safe sourcing function with proper error handling
safe_source() {
    local file=$1
    local description=$2
    
    if [[ -f "$file" ]]; then
        log_info "Sourcing $description"
        # Set environment variables to make shell configs CI-friendly
        export CI=true
        export NONINTERACTIVE=true
        
        if source "$file" 2>/dev/null; then
            log_success "✓ Successfully sourced $description"
        else
            log_warning "⚠ Failed to source $description (likely due to missing plugins/themes)"
            log_info "This is normal during setup - configs will work after installation completes"
        fi
    else
        log_warning "⚠ $description not found at $file"
    fi
}

# Main verification function
main() {
    echo "--------------------------------"
    log_info "🔍 Verifying installations..."
    
    # Source configurations with error handling
    safe_source ~/.shared_profile "shared profile"
    safe_source ~/.bashrc "bash configuration" 
    safe_source ~/.zshrc "zsh configuration"
    safe_source ~/.profile "profile configuration"
    
    # Source Homebrew environment on Linux
    if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null || true
        log_info "Homebrew environment sourced"
    fi
    
    # Debug: Show what files exist
    log_info "Checking for installation directories..."
    if [[ -d "$HOME/.nvm" ]]; then
        log_info "✓ NVM directory exists"
    else
        log_warning "✗ NVM directory missing"
    fi
    if [[ -d "$HOME/.pyenv" ]]; then
        log_info "✓ pyenv directory exists"
    else
        log_warning "✗ pyenv directory missing"
    fi
    if [[ -d "$HOME/.sdkman" ]]; then
        log_info "✓ SDKMAN directory exists"
    else
        log_warning "✗ SDKMAN directory missing"
    fi    

    
    # Node.js (need to source NVM first)
    echo "--------------------------------"
    log_info "🔧 Verifying Node.js installations..."
    if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
        export NVM_DIR="$HOME/.nvm"
        # shellcheck source=/dev/null
        source "$HOME/.nvm/nvm.sh"
        verify_command "node" "Node.js"
        verify_command "nvm" "Node Version Manager"
    else
        log_error "✗ Node.js not found (NVM script missing)"
        log_error "✗ nvm not found"
    fi
    
    # Python (need to source pyenv first)
    echo "--------------------------------"
    log_info "🔧 Verifying Python installations..."
    verify_command "python3" "Python"
    if [[ -d "$HOME/.pyenv" ]]; then
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)" 2>/dev/null || true
        verify_command "pyenv" "Python Version Manager"
    else
        log_error "✗ pyenv not found (directory missing)"
    fi
    

    # Source SDKMAN! if it exists
    echo "--------------------------------"
    log_info "🔧 Verifying SDKMAN! installations..."
    if [[ -d "$HOME/.sdkman" && -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
        # shellcheck source=/dev/null
        source "$HOME/.sdkman/bin/sdkman-init.sh"
        log_info "✓ Sourced SDKMAN"
        verify_command "java" "Java"
        verify_command "mvn" "Maven"
        verify_command "sdk" "SDKMAN!"
    else
        log_error "✗ SDKMAN directory not found or init script missing"
        log_error "✗ Java not found"
        log_error "✗ Maven not found"
        log_error "✗ sdk not found"
    fi
    
    # Development tools
    echo "--------------------------------"
    log_info "🔧 Verifying development tools..."
    verify_command "git" "Git"
    verify_command "docker" "Docker"
    verify_command "kubectl" "Kubernetes CLI"
    verify_command "psql" "PostgreSQL CLI"
    verify_command "jq" "jq"
    verify_command "tree" "tree"
    verify_command "zsh" "Zsh shell"
    verify_command "vim" "Vim"
    verify_command "nvim" "Neovim"
    verify_command "aws" "AWS CLI"
    verify_command "terraform" "Terraform"
    verify_command "gh" "GitHub CLI"
    echo "--------------------------------"
    log_success "🎉 Verification completed!"
    echo "--------------------------------"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi




# test 1: bash profile
# test 2: zsh profile
# This shouldn't do any debugging, this should happen in the installation script
# This script is for verifying installations after setup