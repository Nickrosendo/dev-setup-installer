## This project aims to install and configure multiple development tools.

***

### Requirements:
    Debian-like linux distros

*** 

### Getting started:
  That command will run the installation script and source zsh configuration file after installation
  `./dev-setup-installer.sh && source ~/.zshrc`

*** 

### Installed packages:

#### build-essential:
  This package install several other packages that is requirements for some languages, like c++, c, etc.

#### xclip:
  This package enables global clipboard access for some terminal applications like tmux, vim, etc.

#### git:
  This package enable code versioning and managing multiple development projects.
  More info check it out at: [https://git-scm.com/]

#### curl:
  This package enable download data from a url.

#### dotfiles:
  This is a git repository with multiple configurations files. Including neovim, zsh and tmux configurations.
  Link for the repository: [https://github.com/Nickrosendo/dotfiles/]

#### zsh:
  This is a shell similar to bash but with more cool stuffs like better autocompletion and so on.

#### tmux:
  This is a terminal multiplexer, its very useful for spliting a terminal window in multiple directions and internal windows.

#### neovim:
  This is a text editor that has vast configurability, is a fork from the popular vim editor but with new stuffs and easier update process.

#### silversearcher ag:
  This is a tool for searching files on the system file-tree, it's really fast and can be combined with neovim to power large file-trees searches

#### fzf:
  Similar to silversearcher but it enable to search file-tree by the content of a file, it goes really well combine with neovim

#### htop:
  This package enable monitoring the resources of your machine in real time, similar to regular top but with more realtime info about resouces like cpu and memory usage.

#### nvm:
  This package allow manage multiple nodejs versions installed in your machine and enable switch for one version to another with just a command.

#### nodejs:
  This is a javascript runtime that allow to run code in javascript on the server-side.


#### yarn:
  This is a javascript package manager

#### tldr:
  This tool provide a better manual page for most of development utilities.

***

#### Contributing:
  If you like it the project and want to contribute, feel free to open a Pull-request 
