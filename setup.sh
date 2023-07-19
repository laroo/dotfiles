#!/usr/bin/env bash

function _trap_exit () {
    echo "[exit]"
}
trap _trap_exit EXIT

function _trap_ctrl_c() {
    echo "** Trapped CTRL-C"
    exit -1
}
trap _trap_ctrl_c INT

IFS=$'\n\t'
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SCRIPT_DIR}"

CURRENT_USER=$( whoami )

export STOW_DIR="${SCRIPT_DIR}/config"

source "${SCRIPT_DIR}/scripts/installs/debian-apt.sh"
source "${SCRIPT_DIR}/scripts/installs/shell.sh"
source "${SCRIPT_DIR}/scripts/installs/asdf.sh"
source "${SCRIPT_DIR}/scripts/installs/pyenv.sh"
# source "${SCRIPT_DIR}/scripts/installs/flatpak.sh"


installAptPackages() {
  sudo apt-get update
  sudo apt-get install --yes \
    build-essential \
    nano \
    stow \

}

if [ "$EUID" -eq 0 ]
  then echo "Do not run as root! Will use sudo"
  exit 1
fi

function run() {
  local CMD=$1
  echo "Going to run '${CMD}'"
  if [ $DOTFILES_FORCE == true ]; then
    $CMD;
  else
    read -p "Do you want to continue? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      $CMD;
    fi;
  fi;
}

function help() {
  echo "Setup dotfiles installation"
  echo "USAGE:"
  echo " -t  --type <arg>   Installation type: headless or desktop"
  echo " -f  --force        Don't ask for confirmation"
}

DOTFILES_FORCE=false
DOTFILES_TYPE=

while true; do
  if [ $# -eq 0 ]; then
    # No arguments left
    break
  fi

  case "$1" in

    -f | --force )
      DOTFILES_FORCE=true
      shift
      ;;

    -t | --type )
      if [ $# -ge 2 ] && [ -n "$2" ]; then
        DOTFILES_TYPE="$2"
        shift
      fi
      shift
      ;;

    -- )
      shift;
      break
      ;;

    * )
      break
      ;;
  esac

done

# echo "FORCE: ${DOTFILES_FORCE}"
# echo "INSTALL_TYPE: ${DOTFILES_TYPE}"

case $DOTFILES_TYPE in

  headless )
    echo "Setting up for 'headless'..."

    run initializeApt
    # run installAptRepositories
    run initializeAptUpgrade
    run installAptCorePackages
    run installAptBuildPackages
    run installAptCliPackages

    run installShell
    run installAsdf
    run installPyenv

    # run installFlatpak
    ;;

  desktop )
    echo "Setting up for 'desktop'..."

    run initializeApt
    run installAptRepositories
    run initializeAptUpgrade
    run installAptCorePackages
    run installAptBuildPackages
    run installAptCliPackages

    run installShell
    run installAsdf
    run installPyenv

    run installFlatpak
    ;;

  * )
    echo "Unknown installation type: ${DOTFILES_TYPE}"
    help
    exit 1
    ;;
esac


echo "[done]"
