# 🚀 Matty's Dotfiles

[![Test Dotfiles Setup](https://github.com/matthewjoates/dev-environment-config/actions/workflows/test.yml/badge.svg)](https://github.com/matthewjoates/dev-environment-config/actions/workflows/test.yml)

```
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡠⠤⠤⠤⠤⠤⠤⠤⠤⠤⢄⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⠤⠔⠚⣉⡤⠖⠒⠒⠒⠊⠉⠛⠲⣄⠀⠠⢄⡀⠉⠢⣄⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠴⠒⣋⣉⣁⣀⠤⠒⠋⠁⣠⠔⠒⠉⠁⠀⠀⠀⠀⠈⠦⠀⠀⠈⠳⣄⠈⢣⡀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠤⠖⠉⣠⠖⠉⠁⡀⠀⠀⠀⠀⠀⡨⠆⠀⢀⡤⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣀⣌⢧⠀⠱⡀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣀⠤⠔⠚⢉⣀⣠⣴⣏⠉⠓⠲⣄⡈⠱⠆⠀⡀⠈⠀⠀⠰⠋⣴⣿⣿⣿⣷⣴⡄⣾⠰⡀⠈⢶⣿⣿⣷⠀⡷⠀⠀⠀⠀
⠀⠀⠀⠀⢀⡞⢁⣤⠖⠋⠙⠛⠿⣿⣯⣄⠐⠶⠒⢤⢠⡄⢰⡇⠀⠀⠀⢀⡏⠛⠿⠿⠿⠿⠿⣿⡏⠀⠙⢄⠈⢿⣿⣿⠀⣷⠀⠀⠀⠀
⠀⠀⠀⠀⠸⡗⠘⠿⣶⣄⢀⡀⣠⠤⠈⠀⠙⠿⠧⠘⠋⢡⡿⠀⠀⠀⠀⠈⠁⠀⠀⢀⣐⣥⠜⠋⢀⠀⠀⠀⠀⠀⠙⠿⡀⠘⠢⣄⠀⠀
⠀⠀⠀⠀⠀⠉⠒⢤⣀⠉⠙⠿⣿⡇⠀⠀⠀⠴⠒⠁⠀⣼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠒⠁⠀⠀⠀⠀⠀⢀⣠⣬⡶⣄⠈⠱⡄
⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠲⢤⡀⠉⢓⡦⠀⣤⡲⡄⠈⠁⠀⠀⠀⠀⠀⠀⡠⠊⠁⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⣿⣿⣿⣿⣾⣷⠀⢱
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠞⠀⡴⠋⠀⠀⠋⠁⠀⠁⠀⠀⠀⠀⠀⠀⠀⠃⠀⢸⣯⡀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⡟⠀⡼
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠎⠀⡰⠁⠀⠀⠀⠀⠁⠀⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⢦⡀⠀⠀⠀⠀⠀⠀⢀⣹⣿⣿⣿⠟⢁⡼⠁
⠀⠀⠀⠀⠀⠀⠀⠀⡠⠋⠀⡐⠁⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠶⣤⣤⣠⣤⣴⣿⣿⣿⣿⠃⢠⠛⠁⠀
⠀⠀⠀⠀⠀⠀⣠⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠉⠛⠻⠋⢸⠀⢹⠀⠀⠀
⠀⠀⠀⠀⠀⡰⠃⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⡃⡆⠎⣰⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⢸⠀⠀⠀
⠀⠀⠀⠀⢰⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⣇⢰⠈⡜⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠂⢸⡆⠀⠀
⠀⠀⠀⢠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠚⠠⡾⠄⠘⡄⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⡄⠀⠀⠀⡷⠀⣼⠀⠀⠀
⠀⠀⢀⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠲⠰⢳⣾⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢆⠀⠈⢆⠀⡏⠀⡏⠀⠀⠀
⠀⢠⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⢠⠁⢀⡃⠀⠀⠀
⠀⡿⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠁⢸⠇⠀⠀⠀
⠀⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣞⠀⡸⠀⠀⠀⠀
⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⡗⠀⡟⠀⠀⠀⠀
⠀⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠆⠀⡇⠀⠀⠀⠀
⡼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡃⠀⡇⠀⠀⠀⠀
⣇⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡔⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⡃⠀⡇⠀⠀⠀⠀
⡞⠁⠀⠀⠀⠀⠀⠀⢠⠂⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡞⠀⣰⠀⠀⠀⣀⠀⡆⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⢐⡓⠀⡇⠀⠀⠀⠀
⣇⠀⣀⣀⣀⣀⣀⣀⣃⣰⣃⣐⣋⣀⣀⣀⣀⣀⣀⣀⣀⣀⣈⣑⣃⣈⣀⣀⣀⣋⣀⣹⣋⣧⣣⣀⣀⣀⣀⣀⣀⣀⣀⣗⠀⡿⠀⠀⠀⠀
⠘⠦⠄⠀⠀⠀⠤⠤⠤⠤⠤⠠⠤⠀⠄⠄⠀⠀⠀⠀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠄⠠⠄⠀⠤⠤⠤⠄⠠⠼⠁⠀⠀⠀⠀
```
Welcome to my personal dotfiles repository! This contains my shell configurations, development tools setup, and automation scripts for quickly setting up a new development environment.


## 📋 What's Included

### Shell Configuration
- **Zsh**: Modern shell configuration with Oh My Zsh, useful plugins, and custom functions
- **Bash**: Fallback bash configuration with similar features
- **Aliases**: Comprehensive set of shortcuts for Git, Docker, Kubernetes, and daily tasks

### Git Configuration
- **Global Git Config**: Sensible defaults, useful aliases, and VS Code integration
- **Global Gitignore**: Comprehensive ignore patterns for common files and directories

### Development Tools
- **Automated Installation**: Scripts to install essential development tools
- **VS Code Settings**: Optimized editor configuration and extension recommendations
- **Package Managers**: Setup for Homebrew (macOS), NVM (Node.js), and pyenv (Python)

### Scripts
- **Main Setup Script**: One-command setup for new machines
- **Development Tools Installer**: Automated installation of common dev tools

## 🚀 Quick Start

### New Machine Setup

1. **Clone this repository:**
   ```bash
   git clone https://github.com/matthewjoates/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the setup script:**
   ```bash
   ./setup.sh
   ```

3. **Restart your terminal or source the configuration:**
   ```bash
   source ~/.zshrc
   ```

### Manual Installation

If you prefer to install components individually:

```bash
# Make scripts executable
chmod +x setup.sh scripts/install-dev-tools.sh scripts/verify-installations.sh

# Install development tools only
./scripts/install-dev-tools.sh

# Verify installations
./scripts/verify-installations.sh

# Setup shell configuration only
ln -sf ~/dotfiles/shell/.zshrc ~/.zshrc
ln -sf ~/dotfiles/shell/.aliases ~/.aliases

# Setup git configuration only
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git/.gitignore_global ~/.gitignore_global
```

## 📁 Repository Structure

```
dotfiles/
├── setup.sh                    # Main setup script
├── README.md                   # This file
├── .github/
│   └── copilot-instructions.md # GitHub Copilot instructions
├── shell/                      # Shell configuration files
│   ├── .zshrc                  # Zsh configuration
│   ├── .bashrc                 # Bash configuration
│   └── .aliases                # Common aliases
├── git/                        # Git configuration
│   ├── .gitconfig              # Global git configuration
│   └── .gitignore_global       # Global gitignore patterns
├── scripts/                    # Setup and utility scripts
│   ├── install-dev-tools.sh    # Development tools installer
│   ├── verify-installations.sh # Installation verification script
│   └── add-aliases.sh          # Alias management script
├── config/                     # Application configurations
│   └── vscode-settings.json    # VS Code settings
├── docker-compose.test.yml     # Docker testing configuration
├── Dockerfile                  # Testing container definition
└── run-docker.sh              # Automated testing script
```

## 🛠 What Gets Installed

### Package Managers
- **Homebrew** (macOS) - Package manager for macOS
- **NVM** - Node.js version manager
- **pyenv** - Python version manager
- **SDKMAN!** - Java version manager

### Development Tools
- **Git** - Version control
- **VS Code** - Primary code editor
- **Node.js** (via NVM) - JavaScript runtime
- **Python 3** (via pyenv) - Python interpreter
- **Java** (via SDKMAN!) - Java development kit
- **Maven** - Java build tool
- **Docker** - Containerization platform
- **PostgreSQL** - Database server

### Command Line Tools
- **Oh My Zsh** - Enhanced Zsh experience with plugins
- **fzf** - Fuzzy finder
- **ripgrep** - Fast text search
- **tree** - Directory visualization
- **jq** - JSON processor
- **htop** - System monitor
- **kubectl** - Kubernetes CLI
- **terraform** - Infrastructure as code
- **AWS CLI** - Amazon Web Services tools
- **GitHub CLI** - Git repository management

### VS Code Extensions
- **Java Extension Pack** - Complete Java development support
- **Python Support** - Python language features and debugging
- **TypeScript/JavaScript** - Modern web development
- **Docker & Kubernetes** - Container development tools
- **Git Integration** - Enhanced Git workflows
- **Remote Development** - SSH and container development
- **Code Formatting** - Prettier, ESLint integration
- **Terraform & AWS** - Infrastructure and cloud development

## 🔧 Customization

### Personal Information
Before running the setup, update these files with your personal information:

1. **Git Configuration** (`git/.gitconfig`):
   ```bash
   # Update these lines with your info
   name = Your Name
   email = your.email@example.com
   ```

### Local Overrides
Create local configuration files for machine-specific settings:

- `~/.zshrc.local` - Local Zsh configuration
- `~/.bashrc.local` - Local Bash configuration
- `~/.gitconfig.local` - Local Git configuration

These files will be automatically sourced if they exist and won't be tracked by Git.

## 📝 Available Aliases

### Git Shortcuts
- `gs` - git status
- `ga` - git add
- `gc` - git commit
- `gco` - git checkout
- `gpl` - git pull
- `gps` - git push

### Navigation
- `ll` - detailed file listing
- `..` - go up one directory
- `...` - go up two directories

### Development
- `code .` - open current directory in VS Code
- `serve` - start a simple HTTP server
- `py` - python3 shortcut

### PostgreSQL
- `pg-start` - start PostgreSQL service
- `pg-stop` - stop PostgreSQL service
- `psql-connect` - connect to PostgreSQL

### Java/Maven
- `java-list` - list available Java versions
- `java-use` - switch Java version
- `mvn` - Maven build tool

### Docker & Kubernetes
- `d` - docker
- `dc` - docker-compose
- `k` - kubectl

[See the full list in `shell/.aliases`](shell/.aliases)

## 🔄 Updating

To update your dotfiles:

```bash
cd ~/dotfiles
git pull origin main
./setup.sh  # Re-run setup if needed
```

## 🧪 Testing

The repository includes automated testing via GitHub Actions and Docker containers.

### GitHub Actions
- **Ubuntu Testing** - Tests installation on Linux
- **macOS Testing** - Tests scripts on macOS  
- **Shell Config Testing** - Validates syntax of shell configurations
- **Script Linting** - Runs ShellCheck on all shell scripts

### Local Testing with Docker

Test your dotfiles setup locally using Docker:

```bash
# Run automated test
./run-docker.sh

# Or manually:
# Build and run test container
docker-compose -f docker-compose.test.yml up -d dotfiles-test

# Run installation
docker exec -it dotfiles-test bash -c "./scripts/install-dev-tools.sh"

# Run verification
docker exec -it dotfiles-test bash -c "./scripts/verify-installations.sh"

# Exit container and clean up
docker-compose -f docker-compose.test.yml down
```

### Manual Testing

```bash
# Test script syntax
bash -n setup.sh
bash -n scripts/install-dev-tools.sh

# Test shell configurations
zsh -n shell/.zshrc
bash -n shell/.bashrc
```


## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---
