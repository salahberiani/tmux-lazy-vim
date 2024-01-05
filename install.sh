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

# #!/bin/bash
# set -e
#
# # Function to display error messages
# function display_error {
#     echo "Error: $1" >&2
# }
#
# # Function to check and install a package based on the package manager
# function install_package {
#     if command -v "$1" &>/dev/null; then
#         echo "$1 is already installed."
#     else
#         echo "Installing $1..."
#
#         if command -v apt-get &>/dev/null; then
#             sudo apt-get update
#             sudo apt-get install "$1" -y || { display_error "Failed to install $1."; exit 1; }
#         elif command -v dnf &>/dev/null; then
#             sudo dnf install "$1" -y || { display_error "Failed to install $1."; exit 1; }
#         elif command -v zypper &>/dev/null; then
#             sudo zypper install "$1" -y || { display_error "Failed to install $1."; exit 1; }
#         elif command -v pacman &>/dev/null; then
#             sudo pacman -Syu --noconfirm "$1" || { display_error "Failed to install $1."; exit 1; }
#         elif command -v yum &>/dev/null; then
#             sudo yum install -y "$1" || { display_error "Failed to install $1."; exit 1; }
#         else
#             display_error "Unsupported package manager. Please install $1 manually."
#             exit 1
#         fi
#
#         echo "$1 has been successfully installed."
#     fi
# }
#
# # Function to download and install Nerd Font
# function install_nerd_font {
#     echo "Downloading and installing Nerd Font..."
#     NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip"
#     wget "$NERD_FONT_URL" || { display_error "Failed to download Nerd Font."; exit 1; }
#
#     if command -v unzip &>/dev/null; then
#         unzip DroidSansMono.zip -d "$HOME/.fonts" || { display_error "Failed to unzip Nerd Font."; exit 1; }
#     else
#         display_error "Unzip is not installed. Please install unzip manually."
#         exit 1
#     fi
#
#     if command -v fc-cache &>/dev/null; then
#         fc-cache -fv
#     else
#         display_error "fc-cache is not installed. Please install fontconfig manually."
#         exit 1
#     fi
#
#     echo "Nerd Font has been installed."
# }
#
# # Check if tmux is installed
# install_package "tmux"
#
# # Install tmux plugin manager
# if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
#     echo "Cloning tmux plugin manager..."
#     git clone "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"
# fi
#
# # Check and copy tmux configuration
# TMUX_CONF_PATH="$HOME/.tmux.conf"
# if [ ! -e "$TMUX_CONF_PATH" ]; then
#     cp .tmux.conf "$TMUX_CONF_PATH"
#     echo "tmux configuration copied to $TMUX_CONF_PATH"
# else
#     echo "tmux configuration already exists at $TMUX_CONF_PATH"
# fi
#
# # Install Neovim
# install_package "nvim"
#
# # ... (rest of the script remains unchanged)
#
# # Install lazyvim
# echo "Setting up lazyvim..."
# mv "$HOME/.config/nvim{,.bak}" || true
# mv "$HOME/.local/share/nvim{,.bak}" || true
# mv "$HOME/.local/state/nvim{,.bak}" || true
# mv "$HOME/.cache/nvim{,.bak}" || true
#
# cp -r ./nvim/ "$HOME/.config/nvim"
# rm -rf "$HOME/.config/nvim/.git"
# echo "lazyvim has been set up."
#
# echo "Done."
