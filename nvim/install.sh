#!/bin/bash

# Check for Homebrew
if test $(which brew)
then
    brew install neovim ripgrep fd stylua prettier
fi

if [ ! -d "${HOME}/.config/nvim" ]; then
    ln -s "${DOTFILES}/nvim/" "${HOME}/.config/nvim"
fi

if [ ! -f "${HOME}/.config/stylua.toml" ]; then
    ln -s "${DOTFILES}/nvim/stylua.toml" "${HOME}/.config/"
fi

exit 0
