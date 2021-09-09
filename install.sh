#!/bin/bash

cd ~

#############
# Install 1 #
#############

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
mv xmonad.hs ~/.xmonad
mv xmobarrc0 ~/.config/xmobar


# Install 1.5 - vim, rofi, zathura, bash aliases & konsole profile

cd ~/xmonad-install

mv dotvim ~/\.vim
mv vimrc ~/\.vimrc

mv rofi ~/.config/

mv zathurarc ~/.config/zathura/

mv bashrc ~/\.bashrc

mv default.profile ~/.local/share/konsole

# Complete

echo "#############################"
echo "### Installation Complete ###"
echo "#############################"
