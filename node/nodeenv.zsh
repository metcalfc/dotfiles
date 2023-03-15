
function nodeme () {
  # Check for Homebrew
  if (( $+commands[brew] ))
  then
      brew install node
  fi
}