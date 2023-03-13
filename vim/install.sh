#!/bin/bash

# Check for Homebrew
if test ! $(which brew)
then
    brew install vim nvim
fi

if [ ! -d "${HOME}/.config/nvim" ]; then
    mkdir -p "${HOME}/.config/nvim"
fi

if [ ! -f "${HOME}/.config/nvim/init.vim" ]; then
    cat << EOF > "${HOME}/.config/nvim/init.vim"
" Set up vim
set runtimepath+=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOF
fi

if [ ! -f ${HOME}/.vim/autoload/plug.vim ]; then
    curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if command -v pip3 &> /dev/null
then
    python3 -m pip install --upgrade pip
    python3 -m pip install --user --upgrade neovim
fi