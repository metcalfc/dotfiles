export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8


if test $(which starship)
then
  eval "$(starship init zsh)"
fi
