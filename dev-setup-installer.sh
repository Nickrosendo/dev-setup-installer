#!/usr/bin/bash
#############################################
#	Development environment installer
#
#	Author: Nicolas Rosendo
#
#############################################
# Default Variables
  DEFAULT_NODE_VERSION=10.18.0
  DEFAULT_SHELL="zsh"
#############################################
# update apt package registry
apt-get update


# check if package is already installed
check_package_installed(){
	REQUIRED_PKG=$1
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' "$REQUIRED_PKG"|grep "install ok installed")
	echo Checking for "$REQUIRED_PKG": "$PKG_OK"
	if [ "" = "$PKG_OK" ]; then
		  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
		  apt-get --yes install "$REQUIRED_PKG"
	else
		echo "$REQUIRED_PKG" already installed.
		 return 1 
	fi
}

# get essential tools for debian package compilation
check_package_installed "build-essential"

## get xclip to allow tools like vim or tmux to use global clipboard register
check_package_installed "xclip"

## git installation
check_package_installed "git"

## get curl to allow http-request
check_package_installed "curl"

# get dotfiles repository
cd ~ && git clone https://github.com/Nickrosendo/dotfiles/

if [ "$DEFAULT_SHELL" == "zsh" ]; then
  # get zsh
  check_package_installed "zsh"
  chsh -s "$(which zsh)"
  # get ohmyzsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # setup zsh dotfile aliases
  rm ~/.zshrc && ln -s -f ~/dotfiles/.zshrc ~/.zshrc 
fi

source "$HOME"/.zshrc
! [ -d "$HOME"/.nvm ] && [ -a "$(which curl)" ] && 
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | $DEFAULT_SHELL
    source "$HOME"/.nvm/nvm.sh
    [ -n "$(nvm --version)" ] && $(nvm install "$DEFAULT_NODE_VERSION" && nvm use "$DEFAULT_NODE_VERSION")

# get yarn 
[ -a "$(which node)" ] && ! [ -a "$(which yarn)" ] && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list  &&
    apt-get update apt-get install --no-install-recommends yarn

# get tmux
check_package_installed "tmux"
# setup tmux dotfiles aliases
ln -s -f ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s -f ~/dotfiles/.tmux.conf.local ~/.tmux.conf.local

# get SilverSeearcher
check_package_installed "silversearcher-ag"

# get neovim
check_package_installed "neovim"

# create neovim configuration directory
[ -d ~/.config ] || mkdir -p ~/.config 

# setup neovim dotfiles aliases
ln -sf ~/dotfiles/nvim ~/.config/nvim

#get vim-plug
[ -a "$(which curl)" ] && curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim plugins
[ -a "$(which vim)" ] && vim -c 'PlugInstall --sync' + qa 

# get tldr
[ -a "$(which npm)" ] && npm install -g tldr

# get htop
check_package_installed "htop"

# get docker

# get redis

# get nginx

# get kubectl

# get rust
