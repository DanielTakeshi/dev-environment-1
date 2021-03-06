#!/bin/bash

set -e
cp -a vim ${HOME}/.vim
if (( $EUID != 0 )); then
    echo "WARNING: Not installing vim as you didn't run this as root."
else
    add-apt-repository ppa:jonathonf/vim
    apt update
    apt install vim
fi

if [[ ! -d ${HOME}/.vim/bundle/Vundle.vim ]]; then
    # Install Vundle and vim plugins
    git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
fi

eval ./update_vimrc.sh

chown -R ${USER}:${USER} ${HOME}/.vim

# Install YouCompleteMe
python ${HOME}/.vim/bundle/YouCompleteMe/install.py --clang-completer --quiet
