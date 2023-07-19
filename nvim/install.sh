#!/bin/bash

# Check for Homebrew
if test ! $(which brew)
then
    brew install neovim
fi

if [ ! -d "${HOME}/.config/nvim" ]; then
    ln -s "${DOTFILES}/nvim/" "${HOME}/.config/nvim"
fi

exit 0