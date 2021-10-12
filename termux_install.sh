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
pkg install wget -y
pkg install git -y
pkg install zsh -y
pkg install neovim -y
pkg install htop -y
pkg install python -y
pkg install yarn -y
pkg install nodejs -y
pkg install bc -y
pkg install lsd -y
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

# MOTD
cd /data/data/com.termux/files/usr/etc && rm -rf motd
wget -c 'https://github.com/ffraanks/termux_install/raw/master/motd'
cd $HOME && clear && printf "Instalação finalizada!\n"
}
create_directory
package_install
configuration
