#!/bin/bash

# Docker Test Runner for Dotfiles
# This script automates the testing of dotfiles in a clean container

echo "🧪 Starting dotfiles test..."

# Stop the current container
echo "📦 Stopping existing containers..."
docker-compose -f docker-compose.test.yml down

# Rebuild and start fresh container 
echo "🔨 Building and starting fresh container..."
docker-compose -f docker-compose.test.yml build
docker-compose -f docker-compose.test.yml up -d dotfiles-test

# Enter and test
echo "🚀 Running dotfiles installation test..."
docker exec -it dotfiles-test bash -c "
    echo '🎯 Testing dotfiles installation...'
    ./scripts/install-dev-tools.sh
    
    echo ''
    echo '✅ Installation complete! Verifying installations...'
    
    # Verify installations
    command -v git && echo '✅ Git installed'
    command -v node && echo '✅ Node.js installed'
    command -v python3 && echo '✅ Python installed'
    command -v java && echo '✅ Java installed'
    command -v docker && echo '✅ Docker installed'
    command -v code && echo '✅ Visual Studio Code installed'
    command -v kubectl && echo '✅ Kubernetes CLI installed'
    command -v psql && echo '✅ PostgreSQL CLI installed'
    command -v docker-compose && echo '✅ Docker Compose installed'
    command -v jq && echo '✅ jq installed'
    command -v tree && echo '✅ tree installed'
    command -v nvm && echo '✅ Node Version Manager installed'
    command -v pyenv && echo '✅ Python Version Manager installed'
    command -v sdk && echo '✅ SDKMAN! installed'
    command -v brew && echo '✅ Homebrew installed'
    command -v zsh && echo '✅ Zsh shell installed'
    command -v vim && echo '✅ Vim installed'
    command -v neovim && echo '✅ Neovim installed'
    command -v aws && echo '✅ AWS CLI installed'
    command -v aws-sam-cli && echo '✅ AWS SAM CLI installed'
    command -v terraform && echo '✅ Terraform installed'
    command -v jq && echo '✅ jq installed'
    command -v 1password && echo '✅ 1Password CLI installed'
    command -v gh && echo '✅ GitHub CLI installed'

    source "/home/testuser/.sdkman/bin/sdkman-init.sh"
    echo ''
    echo '🎉 All tests completed!'
"

echo "🧹 Cleaning up..."
docker-compose -f docker-compose.test.yml down

echo "✨ Test completed!"