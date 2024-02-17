#!/bin/bash
set -e

# remove install dir
sudo rm -rf "$HOME/install-tmux-neovim"

# Revert tmux
echo "Reverting tmux..."
rm -rf "$HOME/.tmux/plugins/tpm"
rm -f "$HOME/.tmux.conf"
echo "tmux reverted."

# Revert Neovim
echo "Reverting Neovim..."
rm -rf "$HOME/.config/nvim"
sudo rm -rf /opt/nvim
sudo apt remove neovim -y
echo "Neovim reverted."

echo "Reversion complete."
