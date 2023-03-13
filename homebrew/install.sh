#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure essential bundles are installed on Linux and Mac
brew bundle --file=/dev/stdin <<EOF
brew "awscli"
brew "git"
brew "nvim"
brew "coreutils"
brew "direnv"
brew "fzf"
brew "git"
brew "gh"
brew "go"
brew "goreleaser"
brew "gpg2"
brew "hugo"
brew "jq"
brew "neovim"
brew "pinentry"
brew "powerline-go"
brew "pre-commit"
brew "pyenv"
brew "pyenv-virtualenv"
brew "python"
brew "ruby-build"
brew "rbenv"
brew "rbenv-gemset"
brew "shellcheck"
brew "ssh-copy-id"
brew "tmux"
brew "wget"
brew "zip"
brew "zsh"
brew "zsh-completions"
brew "zsh-syntax-highlighting"
EOF

exit 0
