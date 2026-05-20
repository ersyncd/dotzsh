#!/usr/bin/env zsh

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}=== Starting Modular Zsh Configuration Installation ===${NC}"

# 1. Basic dependency check
for cmd in zsh git; do
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${RED}Error: Perintah '$cmd' tidak ditemukan. Silakan install terlebih dahulu.${NC}"
        exit 1
    fi
done

# Get the directory path where this script resides
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
TARGET_DIR="$HOME/.zsh"

# Validation: Ensure the source conf.d folder exists next to this script
if [ ! -d "$SCRIPT_DIR/conf.d" ]; then
    echo -e "${RED}Error: Folder 'conf.d' tidak ditemukan di $SCRIPT_DIR${NC}"
    exit 1
fi

# 2. Create runtime folder structure in $HOME
echo -e "Creating directory structure in $HOME..."
mkdir -p "$TARGET_DIR/conf.d"
mkdir -p "$TARGET_DIR/functions"
mkdir -p "$TARGET_DIR/plugins"

# 3. Automatic plugin installation
echo -e "Checking plugin dependencies..."
if [ ! -d "$TARGET_DIR/plugins/zsh-autosuggestions" ]; then
    echo -e "Downloading zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$TARGET_DIR/plugins/zsh-autosuggestions" --depth=1
fi

if [ ! -d "$TARGET_DIR/plugins/zsh-syntax-highlighting" ]; then
    echo -e "Downloading zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$TARGET_DIR/plugins/zsh-syntax-highlighting" --depth=1
fi

# 4. Backup old .zshrc
if [ -f "$HOME/.zshrc" ] && ! grep -q "MAIN ZSH CONFIGURATION" "$HOME/.zshrc"; then
    echo -e "${YELLOW}Found existing .zshrc. Backing up to ~/.zshrc.bak${NC}"
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

# 5. Install main .zshrc from template
echo -e "Installing main ~/.zshrc from template..."
if [ -f "$SCRIPT_DIR/zshrc-template" ]; then
    cp "$SCRIPT_DIR/zshrc-template" "$HOME/.zshrc"
else
    echo -e "${RED}Error: zshrc-template tidak ditemukan di $SCRIPT_DIR${NC}"
    exit 1
fi

# 6. Synchronize module files (copy only if source != target)
count_conf=0
if [ "$SCRIPT_DIR/conf.d" != "$TARGET_DIR/conf.d" ]; then
    echo -e "Copying module files to ~/.zsh/conf.d/..."
    for file in "$SCRIPT_DIR/conf.d"/*.zsh; do
        if [ -f "$file" ]; then
            cp "$file" "$TARGET_DIR/conf.d/"
            count_conf=$((count_conf + 1))
        fi
    done
else
    echo -e "${YELLOW}Script is running from the target folder. Skipping conf.d copy (files already in place).${NC}"
    # Count existing files for reporting only
    count_conf=$(find "$TARGET_DIR/conf.d" -maxdepth 1 -name "*.zsh" | wc -l)
fi

# 7. Synchronize function files
count_func=0
if [ -d "$SCRIPT_DIR/functions" ]; then
    if [ "$SCRIPT_DIR/functions" != "$TARGET_DIR/functions" ]; then
        echo -e "Copying function files to ~/.zsh/functions/..."
        for file in "$SCRIPT_DIR/functions"/*; do
            if [ -f "$file" ]; then
                cp "$file" "$TARGET_DIR/functions/"
                count_func=$((count_func + 1))
            fi
        done
    else
        echo -e "${YELLOW}Script is running from the target folder. Skipping functions copy.${NC}"
        count_func=$(find "$TARGET_DIR/functions" -maxdepth 1 -type f | wc -l)
    fi
fi

echo -e "${GREEN}✓ Detected/installed $count_conf configuration modules and $count_func custom functions.${NC}"
echo -e "${GREEN}=== Installation complete! Please run 'exec zsh' ===${NC}"