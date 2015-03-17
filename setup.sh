#!/bin/bash

function silent( )
{
  # https://github.com/timofurrer/.silent
  $* > /dev/null 2>/dev/null
}

echo -n "Installing dependencies..."
silent sudo apt-get install exuberant-ctags cscope pyflakes pandoc python-pip --yes
silent sudo pip install flake8 jedi
echo -e "\rInstalled dependencies\033[K"

echo -n "Moving configuration files from .vim[rc] to .vim[rc].old..."
silent mv ~/.vim ~/.vim.old
silent mv ~/.vimrc ~/.vimrc.old
echo -e "\rMoved configuration files from .vim[rc] to .vim[rc].old\033[K"

echo -n "Downloading vim project from github..."
silent git clone https://github.com/jogi-k/.vim.git ~/.vim
echo -e "\rDownloaded current revision from github\033[K"

echo -n "Downloading submodules from github..."
silent cd ~/.vim
silent git submodule init
silent git submodule update
echo -e "\rDownloaded submodules from github\033[K"

echo -n "Linking vimrc..."
silent ln -s ~/.vim/vimrc ~/.vimrc
echo -e "\rLinked vimrc\033[K"

echo -n "Installing plugins"
vi -c PluginInstall -c :q! -c :q!
echo -e "\rInstalled plugins\033[K"
echo "Setup done!"
