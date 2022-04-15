#!/data/data/com.termux/files/usr/bin/bash

# paste name
clear
printf "Digia um nome para a sua pasta (EVITE ESPAÇOS)\n\n"
read PASTE_NAME

# directory create
create_directory(){
clear
mkdir -p $HOME/.local/bin
mkdir $HOME/.projects
mkdir $HOME/.config
mkdir $HOME/.config/nvim
mkdir $HOME/Scripts
mkdir $HOME/$PASTE_NAME
mkdir $HOME/$PASTE_NAME/Python
mkdir $HOME/$PASTE_NAME/Shell_Scripts
}

# installation package
package_install(){
clear
pkg install git -y
pkg install zsh -y
pkg install neovim -y
pkg install htop -y
pkg install cmatrix -y
pkg install python -y
pkg install yarn -y
pkg install nodejs -y
pkg install bc -y
pkg install lsd -y
pkg install openssh -y
}

# Script ssh
ssh_script(){
rm -rf ssh-passwd.sh ssh-connect.sh && clear
wget -c "https://github.com/ffraanks/termux_install/raw/master/ssh-connect.sh"
wget -c "https://github.com/ffraanks/termux_install/raw/master/ssh-passwd.sh"
clear && printf "Deseja configurar seu ssh? [y/n]\n"
read SSH_CONFIG

if [ $SSH_CONFIG == 'Y' ] || [ $SSH_CONFIG == 'y' ] || [ $SSH_CONFIG == 'Yes' ] || [ $SSH_CONFIG == 'yes' ] || [ $SSH_CONFIG == 'YES' ] ; then
  chmod +x ssh-passwd.sh && chmod +x ssh-connect.sh && ./ssh-passwd.sh && configuration

  elif [ $SSH_CONFIG == 'n' ] || [ $SSH_CONFIG == 'N' ] || [ $SSH_CONFIG == 'No' ] || [ $SSH_CONFIG == 'NO' ] || [ $SSH_CONFIG == 'no' ] ; then
    configuration

else
  printf "Opção inexistente...\n\n" && read -p 'PRESSIONE ENTER E TENTE NOVAMENTE...' && ssh_script
fi
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

cd $HOME/.projects
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
#echo 'source ~/.projects/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# MOTD
cd /data/data/com.termux/files/usr/etc && rm -rf motd
wget -c 'https://github.com/ffraanks/termux_install/raw/master/motd'
cd $HOME && rm -rf termux_install.sh ssh-passwd.sh
cd $HOME && clear && printf "Instalação finalizada!\n && read -p 'PRESSIONE ENTER PARA SAIR...'"
}
create_directory
package_install
ssh_script
configuration
