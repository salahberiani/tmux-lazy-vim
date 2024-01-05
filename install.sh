#!/bin/bash
set -e

# Variables
NEOVIM_VERSION="0.9.5"
TMUX_PLUGIN_MANAGER="https://github.com/tmux-plugins/tpm"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
RIPE_VERSION="13.0.0"

# Check if tmux is installed
if command -v tmux &>/dev/null; then
	echo "tmux is already installed."
else
	# Install tmux
	echo "tmux is not installed. Installing..."
	sudo apt-get update
	sudo apt-get install tmux -y
	echo "tmux has been successfully installed."
fi

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	echo "Cloning tmux plugin manager..."
	git clone "$TMUX_PLUGIN_MANAGER" "$HOME/.tmux/plugins/tpm"
fi

# Check and copy tmux configuration
TMUX_CONF_PATH="$HOME/.tmux.conf"
if [ ! -e "$TMUX_CONF_PATH" ]; then
	cp .tmux.conf "$TMUX_CONF_PATH"
	echo "tmux configuration copied to $TMUX_CONF_PATH"
else
	echo "tmux configuration already exists at $TMUX_CONF_PATH"
fi

# Install Neovim
if command -v nvim &>/dev/null; then
	echo "Neovim is already installed."
else
	echo "Installing Neovim..."
	curl -LO https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim.appimage
	chmod u+x nvim.appimage
	./nvim.appimage --appimage-extract
	sudo mv squashfs-root / && sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
	echo "Neovim has been successfully installed."
fi

# Install lazygit
if command -v lazygit &>/dev/null; then
	echo "lazygit is already installed."
else
	echo "Installing lazygit..."
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
	echo "lazygit has been successfully installed."
fi

# Install ripgrep
if command -v rg &>/dev/null; then
	echo "ripgrep is already installed."
else
	echo "Installing ripgrep..."
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${RIPE_VERSION}/ripgrep_${RIPE_VERSION}_amd64.deb
	sudo dpkg -i ripgrep_${RIPE_VERSION}_amd64.deb
	echo "ripgrep has been successfully installed."
fi

# Install fd
if command -v fd &>/dev/null; then
	echo "fd is already installed."
else
	echo "Installing fd..."
	sudo apt-get install fd-find -y
	echo "fd has been successfully installed."
fi

# Download and install Nerd Font
echo "Downloading and installing Nerd Font..."
NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip"
wget "$NERD_FONT_URL"
sudo apt install unzip -y
unzip DroidSansMono.zip -d "$HOME/.fonts"
sudo apt install fontconfig -y
fc-cache -fv
echo "Nerd Font has been installed."

# Install lazyvim
echo "Setting up lazyvim..."
mv "$HOME/.config/nvim{,.bak}" || true
mv "$HOME/.local/share/nvim{,.bak}" || true
mv "$HOME/.local/state/nvim{,.bak}" || true
mv "$HOME/.cache/nvim{,.bak}" || true

cp -r ./nvim/ "$HOME/.config/nvim"
rm -rf "$HOME/.config/nvim/.git"
echo "lazyvim has been set up."

echo "Done."
