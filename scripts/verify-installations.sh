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
        return 0
    else
        log_error "✗ $name not found"
        return 1
    fi
}

# Core development tools verification
verify_development_tools() {
    local shell_name=$1
    
    log_info "🔧 Verifying development tools for $shell_name..."
    
    # Version managers and runtimes
    verify_command "node" "Node.js"
    verify_command "nvm" "Node Version Manager"
    verify_command "python3" "Python"
    verify_command "pyenv" "Python Version Manager"
    verify_command "java" "Java"
    verify_command "mvn" "Maven"
    verify_command "sdk" "SDKMAN!"
    
    # Essential development tools
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
}

# Test bash environment
test_bash_environment() {
    echo "========================================"
    log_info "🐚 Testing BASH Environment"
    echo "========================================"
    
    # Run bash with our configuration and test commands
    bash -c "
        # Export color variables for subshell
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        YELLOW='\033[1;33m'
        BLUE='\033[0;34m'
        NC='\033[0m'
        
        # Define logging functions in subshell
        log_info() {
            echo -e \"\${BLUE}[INFO]\${NC} \$1\"
        }
        
        log_success() {
            echo -e \"\${GREEN}[SUCCESS]\${NC} \$1\"
        }
        
        log_warning() {
            echo -e \"\${YELLOW}[WARNING]\${NC} \$1\"
        }
        
        log_error() {
            echo -e \"\${RED}[ERROR]\${NC} \$1\"
        }
        
        # Source our configurations
        [[ -f ~/.shared_profile ]] && source ~/.shared_profile
        [[ -f ~/.bashrc ]] && source ~/.bashrc
        
        # Define verification functions in subshell
        $(declare -f verify_command)
        $(declare -f verify_development_tools)
        
        # Run verification
        verify_development_tools 'BASH'
    "
}

# Test zsh environment  
test_zsh_environment() {
    echo "========================================"
    log_info "🐚 Testing ZSH Environment"
    echo "========================================"
    
    # Run zsh with our configuration and test commands
    zsh -c "
        # Export color variables for subshell
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        YELLOW='\033[1;33m'
        BLUE='\033[0;34m'
        NC='\033[0m'
        
        # Define logging functions in subshell
        log_info() {
            echo -e \"\${BLUE}[INFO]\${NC} \$1\"
        }
        
        log_success() {
            echo -e \"\${GREEN}[SUCCESS]\${NC} \$1\"
        }
        
        log_warning() {
            echo -e \"\${YELLOW}[WARNING]\${NC} \$1\"
        }
        
        log_error() {
            echo -e \"\${RED}[ERROR]\${NC} \$1\"
        }
        
        # Source our configurations
        [[ -f ~/.shared_profile ]] && source ~/.shared_profile
        [[ -f ~/.zshrc ]] && source ~/.zshrc
        
        # Define verification functions in subshell
        $(declare -f verify_command)
        $(declare -f verify_development_tools)
        
        # Run verification
        verify_development_tools 'ZSH'
    "
}

# Main verification function
main() {
    echo "========================================"
    log_info "🔍 Starting Installation Verification"
    echo "========================================"
    
    # Check for basic configuration files
    log_info "Checking for configuration files..."
    # schellcheck source=/dev/null
    [[ -f "$HOME/.shared_profile" ]] && log_success "✓ Shared profile exists" || log_warning "⚠ Shared profile missing"
    # schellcheck source=/dev/null
    [[ -f "$HOME/.bashrc" ]] && log_success "✓ Bash configuration exists" || log_warning "⚠ Bash configuration missing"
    # schellcheck source=/dev/null
    [[ -f "$HOME/.zshrc" ]] && log_success "✓ Zsh configuration exists" || log_warning "⚠ Zsh configuration missing"
    
    # Check for installation directories
    log_info "Checking for installation directories..."
    # schellcheck source=/dev/null
    [[ -d "$HOME/.nvm" ]] && log_success "✓ NVM directory exists" || log_warning "⚠ NVM directory missing"
    # schellcheck source=/dev/null
    [[ -d "$HOME/.pyenv" ]] && log_success "✓ pyenv directory exists" || log_warning "⚠ pyenv directory missing"
    # schellcheck source=/dev/null
    [[ -d "$HOME/.sdkman" ]] && log_success "✓ SDKMAN directory exists" || log_warning "⚠ SDKMAN directory missing"
    
    # Test both shell environments separately
    test_bash_environment
    test_zsh_environment
    
    echo "========================================"
    log_success "🎉 Verification completed for both shells!"
    echo "========================================"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi