#!/bin/bash

# Check for Homebrew
if test "$(which brew)"; then
  brew install neovim \
    ripgrep \
    fd \
    stylua \
    prettier \
    shfmt \
    yamlfmt \
    hadolint \
    checkmake \
    shellcheck
fi

if [ ! -L "${HOME}/.config/nvim" ]; then
  ln -s "${DOTFILES}/nvim/" "${HOME}/.config/nvim"
fi

if [ ! -L "${HOME}/.config/stylua.toml" ]; then
  ln -s "${DOTFILES}/nvim/stylua.toml" "${HOME}/.config/"
fi

exit 0
