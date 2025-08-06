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
        echo "✅ $name installed"
    else
        echo "❌ $name not found"
    fi
}

# Main verification function
main() {
    log_info "🔍 Verifying installations..."
    echo ""
    
    # Source shell configurations to pick up environment changes
    [[ -f ~/.bashrc ]] && source ~/.bashrc 2>/dev/null || true
    [[ -f ~/.profile ]] && source ~/.profile 2>/dev/null || true
    
    # Debug: Show what files exist
    log_info "Checking for installation directories..."
    [[ -d "$HOME/.nvm" ]] && echo "✓ NVM directory exists" || echo "✗ NVM directory missing"
    [[ -d "$HOME/.pyenv" ]] && echo "✓ pyenv directory exists" || echo "✗ pyenv directory missing"  
    [[ -d "$HOME/.sdkman" ]] && echo "✓ SDKMAN directory exists" || echo "✗ SDKMAN directory missing"
    echo ""
    
    # Basic tools
    verify_command "git" "Git"
    
    # Node.js (need to source NVM first)
    if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
        export NVM_DIR="$HOME/.nvm"
        # shellcheck source=/dev/null
        source "$HOME/.nvm/nvm.sh"
        verify_command "node" "Node.js"
        verify_command "nvm" "Node Version Manager"
    else
        echo "❌ Node.js not found (NVM script missing)"
        echo "❌ nvm not found"
    fi
    
    # Python (need to source pyenv first)
    verify_command "python3" "Python"
    if [[ -d "$HOME/.pyenv" ]]; then
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)" 2>/dev/null || true
        verify_command "pyenv" "Python Version Manager"
    else
        echo "❌ pyenv not found (directory missing)"
    fi
    

    # Source SDKMAN! if it exists
    if [[ -d "$HOME/.sdkman" && -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
        source "$HOME/.sdkman/bin/sdkman-init.sh"
        echo "✅ Sourced SDKMAN"
        verify_command "java" "Java"
        verify_command "mvn" "Maven"
        verify_command "sdk" "SDKMAN!"
    else
        echo "❌ SDKMAN directory not found or init script missing"
        echo "❌ Java not found"
        echo "❌ Maven not found"
        echo "❌ sdk not found"
    fi
    
    # Development tools
    verify_command "docker" "Docker"
    verify_command "code" "Visual Studio Code"
    verify_command "kubectl" "Kubernetes CLI"
    verify_command "psql" "PostgreSQL CLI"
    verify_command "jq" "jq"
    verify_command "tree" "tree"
    verify_command "zsh" "Zsh shell"
    verify_command "vim" "Vim"
    verify_command "nvim" "Neovim"
    verify_command "aws" "AWS CLI"
    verify_command "sam" "AWS SAM CLI"
    verify_command "terraform" "Terraform"
    verify_command "op" "1Password CLI"
    verify_command "gh" "GitHub CLI"
    

    echo ""
    log_success "🎉 Verification completed!"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi