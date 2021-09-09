#!/bin/bash

cd ~

#############
# Install 1 #
#############
sudo pacman -Syu

sudo pacman -Syy --noconfirm xorg xmonad xmonad-contrib picom nitrogen rofi konsole vlc cmatrix sl curl cmus fceux telegram-desktop neofetch zathura cowsay

# Install 1.2 - Create directories

cd ~
mkdir .xmonad

cd .config
mkdir xmobar
mkdir zathura


# Install 1.3 - Fonts

cd ~/xmonad-install 

sudo cp -r fonts /usr/local/share

fc-cache


# Install 1.4 - Xmonad & Xmobar

cd ~
cd xmonad-install
cp xmonad.hs ~/.xmonad
cp xmobarrc0 ~/.config/xmobar


# Install 1.5 - vim, rofi, zathura, bash aliases & konsole profile

cd ~/xmonad-install

cp -r dotvim ~/\.vim
cp -r vimrc ~/\.vimrc

cp -r rofi ~/.config/

cp zathurarc ~/.config/zathura/

cp bashrc ~/\.bashrc

cp default.profile ~/.local/share/konsole


# Complete
cd ~
sudo pacman -Syu

konsole -e curl parrot.live 
cowsay Installation Complete
