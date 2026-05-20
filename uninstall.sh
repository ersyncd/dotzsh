#!/usr/bin/env zsh

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${RED}=== Warning: You are about to remove the Modular Zsh configuration ===${NC}"
read -p "Are you sure you want to continue? (y/N): " confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo -e "Cancelled by user."
    exit 0
fi

# 1. Remove module folders in the runtime target
echo -e "Removing configuration folders in $HOME..."
rm -rf "$HOME/.zsh"

# 2. Handle main .zshrc file
if [ -f "$HOME/.zshrc" ]; then
    if grep -q "MAIN ZSH CONFIGURATION" "$HOME/.zshrc"; then
        echo -e "Removing modular ~/.zshrc..."
        rm "$HOME/.zshrc"
        
        # 3. Restore backup if present
        if [ -f "$HOME/.zshrc.bak" ]; then
            echo -e "${GREEN}Restoring backup ~/.zshrc.bak to ~/.zshrc${NC}"
            mv "$HOME/.zshrc.bak" "$HOME/.zshrc"
        fi
    else
        echo -e "${YELLOW}~/.zshrc currently in use is not managed by this installer. Leaving it intact.${NC}"
    fi
fi

echo -e "${GREEN}=== Uninstallation complete! ===${NC}"