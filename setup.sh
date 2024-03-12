#!/usr/bin/zsh

chmod +x commands/*
mv commands/* /usr/local/bin/

mv .zshrc ~
brew bundle install --file Brewfile

if [! -d ~/.config/] then 
  mkdir ~/.config/
fi
if [ -d ~/.config/nvim ] then 
  rm -rf ~/.config/nvim
fi 
mv nvim ~/.config/
