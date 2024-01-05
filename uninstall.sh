#!/bin/bash
set -e

# Revert tmux
echo "Reverting tmux..."
sudo apt-get remove --purge tmux -y
rm -rf "$HOME/.tmux/plugins/tpm"
rm -f "$HOME/.tmux.conf"
echo "tmux reverted."

# Revert Neovim
echo "Reverting Neovim..."
sudo rm -f /usr/bin/nvim
rm -rf "$HOME/.config/nvim"
echo "Neovim reverted."

# Revert lazygit
echo "Reverting lazygit..."
sudo rm -f /usr/local/bin/lazygit
echo "lazygit reverted."

# Revert ripgrep
echo "Reverting ripgrep..."
sudo apt-get remove --purge ripgrep -y
echo "ripgrep reverted."

# Revert fd
echo "Reverting fd..."
sudo apt-get remove --purge fd-find -y
echo "fd reverted."

# Revert Nerd Font
echo "Reverting Nerd Font..."
rm -rf "$HOME/.fonts/DroidSansMono.zip"
sudo fc-cache -fv
echo "Nerd Font reverted."

echo "Reversion complete."
