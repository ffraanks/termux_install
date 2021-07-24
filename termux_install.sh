#!/bin/env bash

# directory create
create_directory(){
clear
mkdir -p $HOME/.local/bin
mkdir $HOME/.projects
mkdir $HOME/.config
mkdir $HOME/.config/nvim
mkdir $HOME/Scripts
mkdir $HOME/Franks
mkdir $HOME/Franks/Python
mkdir $HOME/Franks/Shell_Scripts
}

# installation package
package_install(){
clear
pkg install wget
pkg install git
pkg install zsh
pkg install neovim
pkg install htop
pkg install python
pkg install yarn
pkg install nodejs
pkg install bc
pkg install cat
pkg install lsd
}

# config
configuration(){

# NEOVIM
cd $HOME/.config/nvim && wget -c "https://github.com/ffraanks/dotfiles/raw/master/.config/nvim/init.vim"
clear && sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cp -r $HOME/.local/share/nvim/site/autoload $HOME/.config/nvim

# ZSH
clear
chsh -s zsh
cd $HOME/.projects
git clone https://github.com/mafredri/zsh-async.git
cd $HOME && touch .zhistory
cd $HOME && wget -c 'https://github.com/ffraanks/termux_install/raw/master/.zshrc'
cd $HOME && wget -c 'https://github.com/ffraanks/termux_install/raw/master/.aliases'
}
create_directory
package_install
configuration
