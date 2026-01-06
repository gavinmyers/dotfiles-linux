#!/bin/bash
set -e

# Detect the directory where this script is located
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

check_tool() {
    local tool_name="$1"
    local check_cmd="$2"
    local version_flag="${3:---version}"

    if command -v "$tool_name" >/dev/null 2>&1; then
        version_output=$($tool_name $version_flag 2>&1 | head -n 1)
        echo "  [OK] $tool_name: Installed ($version_output)"
    else
        echo "  [MISSING] $tool_name: Not installed"
    fi
}

echo "Running setup from: $PROJECT_DIR"

echo "--------------------------------------------------"
echo "System Status Check:"
check_tool "node" "node" "--version"
check_tool "npm" "npm" "--version"
check_tool "python3" "python3" "--version"
check_tool "pip3" "pip3" "--version"
check_tool "java" "java" "-version"
check_tool "gradle" "gradle" "--version"

if [ -z "$JAVA_HOME" ]; then
     echo "  [WARNING] JAVA_HOME: Not set"
else
     echo "  [OK] JAVA_HOME: $JAVA_HOME"
fi
echo "--------------------------------------------------"

echo "This script will perform the following actions:"
echo "1. Install system packages: zsh, vim, tmux"
echo "2. Install Oh-My-Zsh (if not already installed)"
echo "3. Install custom theme 'gavin.zsh-theme'"
echo "4. Create symlinks in $HOME for dotfiles found in $PROJECT_DIR"
echo "   (Existing files will be backed up with a .bak extension)"
echo "--------------------------------------------------"

read -p "Do you want to proceed? (y/n) " -n 1 -r
echo    # Move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Setup cancelled."
    exit 1
fi

# 1. Install Packages
echo "Installing packages..."
sudo apt-get update
sudo apt-get install -y zsh vim tmux default-jdk gradle

# 2. Oh-My-Zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh-My-Zsh is already installed. Skipping..."
else
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 3. Theme
echo "Installing custom theme..."
cp "$PROJECT_DIR/gavin.zsh-theme" "$HOME/.oh-my-zsh/themes/"

# 4. Symlinks
echo "Creating symlinks..."
for file in "$PROJECT_DIR"/.[!.]*; do
    filename=$(basename "$file")
    
    # Ignored files/directories
    if [[ "$filename" == ".git" || "$filename" == ".gitignore" || "$filename" == "*.swp" ]]; then
        continue
    fi

    target="$HOME/$filename"

    # Backup existing files if they are not already our symlink
    if [ -e "$target" ] || [ -L "$target" ]; then
        # Check if it's already a symlink pointing to the right place
        if [ -L "$target" ] && [ "$(readlink -f "$target")" == "$file" ]; then
            echo "  $filename: Already linked."
            continue
        fi
        
        echo "  Backing up existing $filename to $filename.bak"
        mv "$target" "${target}.bak"
    fi

    echo "  Linking $filename -> $target"
    ln -s "$file" "$target"
done

echo "--------------------------------------------------"
echo "Setup complete! Please restart your shell or launch tmux."