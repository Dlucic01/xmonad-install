#!/bin/bash

cd ~

#############
# Install 1 #
#############
sudo pacman -Syu

sudo pacman -Syy --noconfirm xorg xmonad xmonad-contrib picom nitrogen rofi konsole vlc cmatrix sl curl cmus fceux telegram-desktop neofetch zathura

# Install 1.2 - Create directories

cd ~
mkdir .xmonad

cd .config
mkdir xmobar
mkdir zathura


# Install 1.3 - Fonts

cd xmonad-install 
sudo cp fonts /usr/local/share/

fc-cache


# Install 1.4 - Xmonad & Xmobar

cd ~
cd xmonad-install
cp xmonad.hs ~/.xmonad
cp xmobarrc0 ~/.config/xmobar


# Install 1.5 - vim, rofi, zathura, bash aliases & konsole profile

cd ~/xmonad-install

cp dotvim ~/\.vim
cp vimrc ~/\.vimrc

cp rofi ~/.config/

cp zathurarc ~/.config/zathura/

cp bashrc ~/\.bashrc

cp default.profile ~/.local/share/konsole


# Complete
cd ~
sudo pacman -Syu

echo "#############################"
echo "### Installation Complete ###"
echo "#############################"
