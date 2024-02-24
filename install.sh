#!/bin/bash
set -e

# Variables
NEOVIM_VERSION="0.9.5"
TMUX_PLUGIN_MANAGER="https://github.com/tmux-plugins/tpm"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
RIPE_VERSION="13.0.0"

# Create directory and move into it
INSTALL_DIR="$HOME/install-tmux-neovim"
mkdir -p "$INSTALL_DIR"

sudo apt update
sudo apt upgrade
sudo apt install libfuse2 -y
sudo apt install build-essential -y
sudo apt install xclip -y

# install nodejs
if command -v node &>/dev/null; then
	echo "tmux is already installed."
else
	# Install tmux
	echo "node is not installed. Installing..."
	sudo apt install curl gnupg
	curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
	NODE_MAJOR=18
	echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
	sudo apt update
	sudo apt install nodejs
	sudo npm i -g neovim
	sudo npm i -g tree-sitter-cli
	echo "node has been successfully installed."
fi

# install go
if command -v go &>/dev/null; then
	echo "go is already installed."
else

	echo "go  is not installed. Installing..."
	wget -c https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
	sudo tar -C /usr/local/ -xzf go1.22.0.linux-amd64.tar.gz
	sed -i '$ a\
if [ -d "/usr/local/go/bin" ] ; then\n    PATH="/usr/local/go/bin:$PATH"\nfi
' ~/.profile
	echo "go  has been successfully installed."
fi

# install lua
if command -v lua &>/dev/null; then
	echo "lua is already installed."
else
	# Install lua
	echo "lua is not installed. Installing..."
	sudo apt update
	sudo apt upgrade
	sudo apt install wget apt-transport-https gnupg2
	sudo apt install lua5.3
	echo "lua has been successfully installed."
fi

# install luarocks
if command -v luarocks &>/dev/null; then
	echo "luarocks is already installed."
else
	# Install luarocks
	echo "luarocks is not installed. Installing..."
	sudo apt -y install luarocks
	echo "luarocks has been successfully installed."
fi

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
	cp -r .tmux.conf "$TMUX_CONF_PATH"
	cp -r ./tmux-kanagawa/ "$HOME/.tmux/plugins/"
	echo "tmux configuration copied to $TMUX_CONF_PATH"
else
	echo "tmux configuration already exists at $TMUX_CONF_PATH"
fi

# Check and copy tmux configuration
BASH_CONF_PATH="$HOME/.bashrc"
cp -r .bashrc "$BASH_CONF_PATH"
echo "bash configuration copied to $BASH_CONF_PATH"
# Install Neovim
if command -v nvim &>/dev/null; then
	echo "Neovim is already installed."
else
	echo "Installing Neovim..."
	curl -LO https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim.appimage
	chmod u+x nvim.appimage
	sudo mkdir -p /opt/nvim
	sudo mv nvim.appimage /opt/nvim/nvim
	sed -i '$ a\export PATH="$PATH:/opt/nvim/"' ~/.bashrc
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

# Install lazydocker
if command -v lazydocker &>/dev/null; then
	echo "lazydocker is already installed."
else
	echo "Installing lazydocker..."
	curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
	echo "lazydocker has been successfully installed."
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
source ~/.bashrc
source ~/.profile
nvim
echo "Done."
