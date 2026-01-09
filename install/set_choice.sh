#!/bin/bash

INSTALL_OPTS=("Home" "Work-WS" "Bio-WS")
DEFAULT_INSTALL_OPT="Home"

INSTALL_OPT=$(gum choose \
  --height 14 \
  --header "Select installation type" \
  --selected "$DEFAULT_INSTALL_OPT" \
  "${INSTALL_OPTS[@]}"
)

export INSTALL_OPT
