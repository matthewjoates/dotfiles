<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# Dotfiles Repository Instructions

This is a personal dotfiles repository for managing development environment configuration across multiple machines.

## Context
- This repository contains shell configurations, git settings, and automation scripts
- Target platforms: macOS and Linux
- Primary shell: Zsh with Oh My Zsh
- Primary editor: VS Code

## Coding Standards
- Use bash for shell scripts with proper error handling (`set -e`)
- Include colored logging functions for better user experience
- Make scripts executable and include shebangs
- Use absolute paths where possible to avoid navigation issues
- Include backup functionality when modifying existing files

## File Organization
- `shell/` - Shell configuration files (.zshrc, .bashrc, .aliases)
- `git/` - Git configuration files (.gitconfig, .gitignore_global)
- `scripts/` - Installation and setup scripts
- `config/` - Application-specific configuration files
- `setup.sh` - Main setup script that orchestrates everything

## Key Patterns
- Use symlinks to connect dotfiles to their target locations
- Backup existing files before overwriting
- Support both macOS (Homebrew) and Linux (apt) package managers
- Include conditional logic for platform-specific operations
- Provide both automated and manual installation options

## Best Practices
- Always test scripts on clean environments
- Include comprehensive error handling and logging
- Make installation idempotent (safe to run multiple times)
- Document all aliases and functions clearly
- Keep sensitive information (like email addresses) easily configurable
