opon() {
  if [[ -z $OP_SESSION_metcalfc ]]; then
    eval $(op signin metcalfc)
  fi
}

opoff() {
  op signout
  unset OP_SESSION_metcalfc
}

