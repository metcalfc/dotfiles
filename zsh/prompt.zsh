export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

if [ ! -f "$DOTFILES/bin/powerline-go" ]; then
  echo "Installing powerline-go"
  if [ "$(uname)" = "Darwin" ]; then
    curl -sL https://github.com/justjanne/powerline-go/releases/download/v1.22.1/powerline-go-darwin-amd64 \
      -o $DOTFILES/bin/powerline-go
  else
    curl -sL https://github.com/justjanne/powerline-go/releases/download/v1.22.1/powerline-go-linux-amd64 \
      -o $DOTFILES/bin/powerline-go
  fi
  chmod +x $DOTFILES/bin/powerline-go
fi

if type "powerline-go" > /dev/null; then

  function powerline_precmd() {
      if [[ -z $PRESENT ]]; then
        eval "$(powerline-go -eval -modules "host,venv,cwd,perms,jobs,root" -modules-right "git" -error $? -shell zsh -theme gruvbox -hostname-only-if-ssh)"
      else
        eval "$(powerline-go -eval -modules "cwd" -error $? -shell zsh -theme gruvbox)"
      fi
  }

  function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
      if [ "$s" = "powerline_precmd" ]; then
        return
      fi
    done
    precmd_functions+=(powerline_precmd)
  }

  if [ "$TERM" != "linux" ]; then
      install_powerline_precmd
  fi

fi