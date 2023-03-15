# init according to man page
if (( $+commands[pyenv] ))
then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init -)"
fi

function pythonme () {
  # Check for Homebrew
  if (( $+commands[brew] ))
  then
      brew install pyenv pyenv-virtualenv python
  fi
}