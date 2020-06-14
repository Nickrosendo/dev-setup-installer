#!/usr/bin/bash
#############################################
#	Development environment installer
#
#	Author: Nicolas Rosendo
#
############################################
# update apt package registry
#apt-get update


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
		return 1
	else
		return 0
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

echo "Installing Node Version Manager(nvm)"

nvm_check = check_program_installed "nvm"
if [ $(check_program_installed "nvm") < 1 ]; then

	if [ curl > 0 ]; then
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
	else 
		echo Curl not installed	
	fi
else
	echo Nvm already installed
fi
