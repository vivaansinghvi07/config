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

mv ./github_dark.lua ~/.local/share/nvim/lazy/base46/lua/base46/themes/github_dark.lua
