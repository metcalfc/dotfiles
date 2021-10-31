export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

if type "powerline-go" > /dev/null; then

  function powerline_precmd() {
      if [[ -z $PRESENT ]]; then

      eval "$(powerline-go -eval -modules "host,venv,cwd,perms,jobs,root" -modules-right "git,${KUBE_POWER}docker-context${AWS_POWER}" -error $? -shell zsh)"
      else
      eval "$(powerline-go -eval -modules "cwd" -modules-right "docker-context" -error $? -shell zsh)"
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

else
  echo "Install powerline-go"
fi

alias kubeon='export KUBE_POWER=kube,'
alias kubeoff='unset KUBE_POWER'
alias awson='export AWS_POWER=,aws'
alias awsoff='unset AWS_POWER'
alias present='export PRESENT=$(pwd)'
alias unpresent='unset PRESENT'
