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
# apt-get update


# check if package is already installed
check_package_installed(){
	REQUIRED_PKG=$1
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
	echo Checking for $REQUIRED_PKG: $PKG_OK
	if [ "" = "$PKG_OK" ]; then
		  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
		  sudo apt-get --yes install $REQUIRED_PKG
	else
		echo $REQUIRED_PKG already installed.
		 return 1 
	fi
}

# check if program is installed 
check_program_installed(){
	program=$1
	if [ $(which $program) > 0 ]; then
		return "Installed"
	else
		return "Not Installed"
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
$(cd ~ && git clone https://github.com/Nickrosendo/dotfiles/)

if [ "$DEFAULT_SHELL" == "zsh" ]; then
  # get zsh
  check_package_installed "zsh"
  chsh -s $(which zsh)
  # get ohmyzsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # setup zsh dotfile aliases
  $(rm ~/.zshrc) && $(ln -s -f ~/dotfiles/.zshrc ~/.zshrc )
fi

echo "Installing Node Version Manager(nvm)"

if [ "$(check_program_installed "nvm")" == "Not Installed" ]; then

	if [ curl > 0 ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | $(DEFAULT_SHELL)
    $(nvm install 10.18.0) && $(nvm use 10.18.0)
    
	else 
		echo Curl not installed	
	fi
else
	echo Nvm already installed
fi

# get yarn 
if [ "$(check_program_installed "nvm")" == "Installed"]; then
  # set yarn ppa on apt repository
  $(curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list) 
  apt-get update apt-get install --no-install-recommends yarn
fi

# get tmux
check_package_installed "tmux"
# setup tmux dotfiles aliases
$(ln -s -f ~/dotfiles/.tmux.conf ~/.tmux.conf)
$(ln -s -f ~/dotfiles/.tmux.conf.local ~/.tmux.conf.local)

# get SilverSeearcher
check_package_installed "silversearcher-ag"

# get neovim
check_package_installed "neovim"
# create neovim configuration directory
if [ -d ~/.config < 1 ]; then
  $(mkdir ~/.config) && $(mkdir ~/.config/nvim)
  # setup neovim dotfiles aliases
  $(ln -s -f ~/dotfiles/.vimrc ~/.config/nvim/init.vim)
fi

# get tldr
if [ "$(check_program_installed "npm")" == "Not Installed" ]; then
  $(npm install -g tldr)
fi

