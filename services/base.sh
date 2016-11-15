#!/bin/bash

# echo in deferent colors
function k_log {
  STATUS=$1
  MSG=$2

  if [ ! -t 0 ]; then
    INPUT=$(cat)
  else
    INPUT=""
  fi

  case "$STATUS" in
    warning) COLOR_CODE='93'; ;;
    success) COLOR_CODE='92'; ;;
    error)   COLOR_CODE='91'; ;;
    info)    COLOR_CODE='94'; ;;
    *)       COLOR_CODE='39'; MSG=$1 ;;
  esac

  RESET="\e[0m";
  COLOR="\e[0;${COLOR_CODE}m";

  if [[ "$OSTYPE" == "darwin"* ]]; then
    RESET="\x1B[0m";
    COLOR="\x1B[0;${COLOR_CODE}m";
  fi

  echo -e ${COLOR}${MSG}${INPUT}${RESET}
}

# echo the debug messages
function k_debug {
    if [ -z ${VERBOSE+x} ]; then
       return;
    fi

    k_log info "Debug: $1";
}

# break the app and dump the errors
function k_die {
    k_log error "Error: $1" 1>&2;

    exit 1;
}

function k_export {
  export $1

  k_debug "[export] $1"
}
