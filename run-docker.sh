#!/bin/bash

# Docker Test Runner for Dotfiles
# This script automates the testing of dotfiles in a clean container

set -e  # Exit on error

# Check if Docker is running
echo "🔍 Checking Docker status..."
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    echo "   On macOS: Open Docker Desktop"
    echo "   On Linux: sudo systemctl start docker"
    exit 1
fi
echo "✅ Docker is running"


# Stop the current container
echo "📦 Stopping existing containers..."
docker-compose -f docker-compose.test.yml down

# Rebuild and start fresh container 
echo "🔨 Building and starting fresh container..."
docker-compose -f docker-compose.test.yml build
docker-compose -f docker-compose.test.yml up -d dotfiles-test

# Enter and test
echo "🚀 Running dotfiles setup test..."

echo "🎯 Step 1: Running complete setup (includes tools + configs)..."
docker exec -it dotfiles-test bash -c "echo 'y' | ./setup.sh" || echo "⚠️  Setup script exited with non-zero status"

echo ""
echo "🔍 Step 2: Running verification..."
docker exec -it dotfiles-test bash -c "./scripts/verify-installations.sh"

echo ""
echo "🎉 Step 3: All tests completed!"
docker exec -it dotfiles-test bash -c "echo 'Installation and verification finished successfully!'"

# echo "🧹 Cleaning up..."
# docker-compose -f docker-compose.test.yml down

echo "✨ Test completed!"