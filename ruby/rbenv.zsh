# init according to man page
if (( $+commands[rbenv] ))
then
  eval "$(rbenv init -)"
fi

function rubyme () {
  # Check for Homebrew
  if (( $+commands[brew] ))
  then
      brew install ruby-build rbenv rbenv-gemset
  fi
}