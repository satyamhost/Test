#!/bin/bash

# ======================================================
# TELEGRAM ENTERPRISE REPORTING SYSTEM
# Installation Script v4.0.0
# Official: @None_Usernam3
# Copyright © 2024 TEAM RAX. All Rights Reserved.
# ======================================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# TEAM RAX Brand Colors
RAX_BLUE='\033[38;5;27m'
RAX_RED='\033[38;5;196m'
RAX_YELLOW='\033[38;5;226m'

# Logging functions
log_rax() {
    echo -e "${RAX_BLUE}[TEAM RAX]${NC} $1"
}

log_info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓ SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[⚠ WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[✗ ERROR]${NC} $1"
}

print_rax_banner() {
    clear
    echo -e "${RAX_BLUE}"
    echo "╔══════════════════════════════════════════════════════════════════╗"
    echo "║                                                                  ║"
    echo -e "║    ${RAX_RED}▓█████▄  ▄▄▄       ██▀███   ███▄    █  ${RAX_YELLOW}██████  ▄▄▄      ${RAX_BLUE}║"
    echo -e "║    ${RAX_RED}▒██▀ ██▌▒████▄    ▓██ ▒ ██▒ ██ ▀█   █  ${RAX_YELLOW}██   ▒ ▒████▄    ${RAX_BLUE}║"
    echo -e "║    ${RAX_RED}░██   █▌▒██  ▀█▄  ▓██ ░▄█ ▒▓██  ▀█ ██▒${RAX_YELLOW} ██████▒▒██  ▀█▄  ${RAX_BLUE}║"
    echo -e "║    ${RAX_RED}░▓█▄   ▌░██▄▄▄▄██ ▒██▀▀█▄  ▓██▒  ▐▌██▒${RAX_YELLOW}██   ▒ ░██▄▄▄▄██ ${RAX_BLUE}║"
    echo -e "║    ${RAX_RED}░▒████▓  ▓█   ▓██▒░██▓ ▒██▒▒██░   ▓██░${RAX_YELLOW}██████▒░ ▓█   ▓██▒${RAX_BLUE}║"
    echo -e "║    ${RAX_RED} ▒▒▓  ▒  ▒▒   ▓▒█░░ ▒▓ ░▒▓░░ ▒░   ▒ ▒ ${RAX_YELLOW}▒ ▒▓▒ ▒ ░ ▒▒   ▓▒█░${RAX_BLUE}║"
    echo -e "║    ${RAX_RED} ░ ▒  ▒   ▒   ▒▒ ░  ░▒ ░ ▒░░ ░░   ░ ▒░${RAX_YELLOW}░ ░▒  ░ ░  ▒   ▒▒ ░${RAX_BLUE}║"
    echo -e "║    ${RAX_RED} ░ ░  ░   ░   ▒     ░░   ░    ░   ░ ░ ${RAX_YELLOW}░  ░  ░    ░   ▒   ${RAX_BLUE}║"
    echo -e "║    ${RAX_RED}   ░          ░  ░   ░              ░ ${RAX_YELLOW}      ░        ░  ░${RAX_BLUE}║"
    echo -e "║    ${RAX_RED} ░                                    ${RAX_YELLOW}                   ${RAX_BLUE}║"
    echo "║                                                                  ║"
    echo "╠══════════════════════════════════════════════════════════════════╣"
    echo "║                                                                  ║"
    echo -e "║    ${BOLD}TELEGRAM ENTERPRISE REPORTING SYSTEM v4.0.0${NC}${RAX_BLUE}                   ║"
    echo -e "║    Developed by: ${RAX_YELLOW}@None_Usernam3${RAX_BLUE}                               ║"
    echo -e "║    Copyright © 2024 ${RAX_RED}TEAM RAX${RAX_BLUE}. All Rights Reserved.               ║"
    echo -e "║    Official Channel: ${RAX_YELLOW}@TEAM_RAX${RAX_BLUE}                                ║"
    echo "║                                                                  ║"
    echo "╚══════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
}

print_disclaimer() {
    echo -e "${YELLOW}╔══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║                     ⚠️  IMPORTANT DISCLAIMER                     ║${NC}"
    echo -e "${YELLOW}╠══════════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${YELLOW}║                                                                  ║${NC}"
    echo -e "${YELLOW}║  This software is provided for EDUCATIONAL and RESEARCH         ║${NC}"
    echo -e "${YELLOW}║  purposes ONLY. Users are solely responsible for their actions.  ║${NC}"
    echo -e "${YELLOW}║                                                                  ║${NC}"
    echo -e "${YELLOW}║  TEAM RAX does not endorse or support any illegal activities.   ║${NC}"
    echo -e "${YELLOW}║  Misuse may result in permanent Telegram account suspension.     ║${NC}"
    echo -e "${YELLOW}║                                                                  ║${NC}"
    echo -e "${YELLOW}╚══════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Check system requirements
check_requirements() {
    log_rax "Checking system requirements..."
    echo ""
    
    # Check Python version
    if command -v python3 &>/dev/null; then
        PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
        log_success "Python $PYTHON_VERSION found"
        
        # Check Python version >= 3.8
        PYTHON_MAJOR=$(python3 -c 'import sys; print(sys.version_info.major)')
        PYTHON_MINOR=$(python3 -c 'import sys; print(sys.version_info.minor)')
        
        if [ $PYTHON_MAJOR -eq 3 ] && [ $PYTHON_MINOR -ge 8 ]; then
            log_success "Python version meets requirements (3.8+)"
        else
            log_error "Python 3.8 or higher required. Found: $PYTHON_VERSION"
            exit 1
        fi
    else
        log_error "Python 3 not found. Please install Python 3.8+"
        echo -e "${CYAN}Visit: https://www.python.org/downloads/${NC}"
        exit 1
    fi
    
    # Check pip
    if command -v pip3 &>/dev/null; then
        log_success "pip3 found"
    else
        log_warning "pip3 not found. Attempting to install..."
        
        # Detect OS and install pip
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$NAME
        else
            OS=$(uname -s)
        fi
        
        case $OS in
            *Ubuntu*|*Debian*|*Linux*)
                sudo apt-get update && sudo apt-get install -y python3-pip
                ;;
            *CentOS*|*Fedora*|*RHEL*)
                sudo yum install -y python3-pip
                ;;
            *Arch*)
                sudo pacman -S python-pip
                ;;
            *Darwin*)  # macOS
                brew install python3
                ;;
            *)
                log_error "Unsupported OS. Please install pip3 manually."
                echo -e "${CYAN}Visit: https://pip.pypa.io/en/stable/installation/${NC}"
                exit 1
                ;;
        esac
        
        if [ $? -eq 0 ]; then
            log_success "pip3 installed successfully"
        else
            log_error "Failed to install pip3"
            exit 1
        fi
    fi
    
    # Check git
    if command -v git &>/dev/null; then
        log_success "Git found"
    else
        log_warning "Git not found. Installing git..."
        sudo apt-get install -y git 2>/dev/null || \
        sudo yum install -y git 2>/dev/null || \
        sudo pacman -S git 2>/dev/null || \
        brew install git 2>/dev/null || {
            log_error "Could not install git. Please install manually."
            exit 1
        }
        log_success "Git installed"
    fi
    
    echo ""
}

# Create virtual environment
create_venv() {
    log_rax "Setting up Python virtual environment..."
    
    if [ -d "venv" ]; then
        log_warning "Virtual environment already exists"
        if [ "$FORCE" = "yes" ]; then
            log_warning "Removing existing virtual environment..."
            rm -rf venv
        else
            echo -e "${CYAN}Do you want to recreate the virtual environment?${NC}"
            read -p "(y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                log_warning "Removing existing virtual environment..."
                rm -rf venv
            else
                log_info "Using existing virtual environment"
                return 0
            fi
        fi
    fi
    
    python3 -m venv venv --prompt="TEAM-RAX"
    
    if [ $? -eq 0 ]; then
        log_success "Virtual environment created successfully"
        echo -e "${CYAN}Virtual Environment Path:${NC} $(pwd)/venv"
    else
        log_error "Failed to create virtual environment"
        exit 1
    fi
    
    echo ""
}

# Install dependencies
install_dependencies() {
    log_rax "Installing system dependencies..."
    
    # Activate virtual environment
    source venv/bin/activate
    
    # Upgrade pip
    log_info "Upgrading pip..."
    pip install --upgrade pip --quiet
    
    # Create requirements.txt if it doesn't exist
    if [ ! -f "requirements.txt" ]; then
        log_info "Creating requirements.txt..."
        cat > requirements.txt << 'EOF'
# TEAM RAX - Telegram Enterprise Reporting System
# Dependencies List v4.0.0

# Core Framework
telethon==1.28.5
rich==13.4.2

# Async Operations
aiofiles==23.2.1
asyncio==3.4.3

# Security & Configuration
python-dotenv==1.0.0
cryptography==41.0.7

# Data Processing
pandas==2.1.1
numpy==1.24.3

# Utilities
colorama==0.4.6
progressbar2==4.2.0
pyfiglet==0.8.post1

# Date/Time
python-dateutil==2.8.2
pytz==2023.3

# Logging
loguru==0.7.2

# Optional (for advanced features)
requests==2.31.0
beautifulsoup4==4.12.2
lxml==4.9.3
EOF
        log_success "requirements.txt created"
    fi
    
    # Install requirements
    log_info "Installing Python packages..."
    echo -e "${CYAN}This may take a few minutes...${NC}"
    echo ""
    
    pip install -r requirements.txt
    
    if [ $? -eq 0 ]; then
        log_success "All dependencies installed successfully"
        
        # Display installed versions
        echo ""
        log_info "Installed Package Versions:"
        pip list | grep -E "telethon|rich|aiofiles|python-dotenv"
    else
        log_error "Failed to install dependencies"
        
        # Try alternative installation method
        log_warning "Attempting alternative installation method..."
        pip install telethon==1.28.5 rich==13.4.2 aiofiles==23.2.1 python-dotenv==1.0.0
        
        if [ $? -ne 0 ]; then
            log_error "Alternative installation also failed"
            exit 1
        fi
    fi
    
    echo ""
}

# Create configuration files
create_config_files() {
    log_rax "Creating configuration files..."
    
    # Create .env template
    if [ ! -f ".env" ]; then
        cat > .env << 'EOF'
# ======================================================
# TEAM RAX - Telegram Enterprise Reporting System
# Environment Configuration
# ======================================================

# Telegram API Credentials
# Get these from: https://my.telegram.org
TELEGRAM_API_ID=your_api_id_here
TELEGRAM_API_HASH=your_api_hash_here

# Required Channel (MUST JOIN)
REQUIRED_CHANNEL=https://t.me/TEAM_RAX

# Security Settings
SECURITY_LEVEL=ENHANCED
ENABLE_AUDIT_LOGS=true
ENCRYPT_SESSION=true

# Rate Limiting
MAX_REPORTS_PER_HOUR=50
MAX_REPORTS_PER_DAY=200
SAFETY_DELAY_SECONDS=2.5

# System Settings
ENABLE_AUTO_BACKUP=true
BACKUP_INTERVAL_MINUTES=30
LOG_LEVEL=INFO

# Notification Settings (Optional)
ENABLE_NOTIFICATIONS=false
NOTIFY_ON_CRITICAL=true

# ======================================================
# DO NOT SHARE THIS FILE WITH YOUR CREDENTIALS!
# ======================================================
EOF
        log_success ".env template created"
        echo -e "${YELLOW}⚠  Please edit .env file and add your API credentials${NC}"
    else
        log_info ".env file already exists"
    fi
    
    # Create .gitignore
    if [ ! -f ".gitignore" ]; then
        cat > .gitignore << 'EOF'
# TEAM RAX - Git Ignore File

# Session files
*.session
*.session-journal
*.session-*

# Configuration files with secrets
.env
.env.local
.env.*.local
config.json
secrets.json

# Virtual Environment
venv/
env/
ENV/
virtualenv/

# Python cache
__pycache__/
*.py[cod]
*$py.class
*.so
.Python

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Logs and data
logs/
*.log
*.json
exports/
session_backups/
*.db
*.sqlite3

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# System files
.DS_Store
Thumbs.db

# Backup files
*.bak
*.backup
EOF
        log_success ".gitignore file created"
    fi
    
    # Create directories
    mkdir -p exports session_backups logs
    
    # Create README.md
    if [ ! -f "README.md" ]; then
        cat > README.md << 'EOF'
# TELEGRAM ENTERPRISE REPORTING SYSTEM v4.0.0

<div align="center">

![TEAM RAX Logo](https://img.shields.io/badge/TEAM-RAX-red)
![Python](https://img.shields.io/badge/Python-3.8%2B-blue)
![Telethon](https://img.shields.io/badge/Telethon-1.28-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

**Advanced Telegram Content Moderation Platform**

</div>

## 📋 Overview

Enterprise-grade reporting system for Telegram with advanced features, security controls, and comprehensive analytics.

## ⚠️ DISCLAIMER

> **IMPORTANT**: This software is for **EDUCATIONAL AND RESEARCH PURPOSES ONLY**.
> 
> - Users are solely responsible for their actions
> - Misuse may result in permanent Telegram account suspension
> - TEAM RAX does not endorse illegal activities
> - Use responsibly and within Telegram's Terms of Service

## ✨ Features

- 🛡️ **Enterprise Security** - Multi-layered security protocols
- 📊 **Advanced Analytics** - Comprehensive statistics and reporting
- ⚡ **Priority System** - Emergency to Low priority handling
- 🔒 **Audit Trail** - Complete operation logging
- 📈 **Performance Metrics** - Real-time monitoring and analytics
- 🔄 **Auto Recovery** - Flood wait protection and retry mechanisms

## 🚀 Installation

### Quick Install (Linux/macOS)
```bash
curl -sSL https://raw.githubusercontent.com/TEAM-RAX/telegram-enterprise/main/install.sh | bash