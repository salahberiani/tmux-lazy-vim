#!/bin/bash
set -e

# Revert tmux
echo "Reverting tmux..."
rm -rf "$HOME/.tmux/plugins/tpm"
rm -f "$HOME/.tmux.conf"
echo "tmux reverted."

# Revert Neovim
echo "Reverting Neovim..."
rm -rf "$HOME/.config/nvim"
echo "Neovim reverted."

echo "Reversion complete."
