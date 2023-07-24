#!/usr/bin/env bash

core_packages=(
  'git'           # Version control
  'nano'          # Text editor
  'wget'          # Download files
  'curl'          # Download files
  'stow'          # Needed for config dotfiles
  'coreutils'
  'moreutils'
)

build_packages=(
  'build-essential'
)

cli_packages=(

  # CLI Power Basics
  'tmux'          # Term multiplexer
  'aria2'         # Resuming download util (better wget)
  'bat'           # Output highlighting (better cat)
  # 'broot'         # Interactive directory navigation
  # 'ctags'         # Indexing of file info + headers
  # 'diff-so-fancy' # Readable file compares (better diff)
  'fzf'           # Fuzzy file finder and filtering
  # 'jq'            # JSON parser, output and query files
  # 'procs'         # Advanced process viewer (better ps)
  'tree'          # Directory listings as tree structure
  'xsel'          # Copy paste access to the X clipboard

  # Security Utilities
  'openssl'       # Cryptography and SSL/TLS Toolkit

  # Monitoring, management and stats
  'htop'
  'btop'          # Live system resource monitoring
  'bmon'          # Bandwidth utilization monitor
  # 'ctop'          # Container metrics and monitoring
  # 'gping'         # Interactive ping tool, with graph
)

ubuntu_repos=(
  'main'
  'universe'
  'restricted'
  'multiverse'
)

debian_repos=(
  'main'
  'contrib'
)

# Following packages not found by apt, need to fix:
# aria2, bat, broot, diff-so-fancy, duf, hyperfine,
# just, procs, ripgrep, sd, tealdeer, tokei, trash-cli,
# zoxide, clamav, cryptsetup, gnupg, lynis, btop, gping.


initializeApt() {
  # Check apt-get actually installed
  if ! hash apt 2> /dev/null; then
    echo "apt doesn't seem to be present on your system. Exiting..."
    exit 1
  fi
  sudo apt update
}

initializeAptUpgrade() {
  sudo apt upgrade -y
  sudo apt autoclean -y
}

installAptRepositories() {
  # Enable upstream package repositories
  if ! hash add-apt-repository 2> /dev/null; then
    sudo apt install --reinstall software-properties-common -y
  fi
  # If Ubuntu, add Ubuntu repos
  if lsb_release -a 2>/dev/null | grep -q 'Ubuntu'; then
    for repo in ${ubuntu_repos[@]}; do
      echo -e "Enabling ${repo} repo..."
      sudo add-apt-repository $repo -y
    done
  else
    # Otherwise, add Debian repos
    for repo in ${debian_repos[@]}; do
      echo -e "Enabling ${repo} repo..."
      sudo add-apt-repository $repo -y
    done
  fi
}

installAptCorePackages() {
  sudo apt install ${core_packages[@]} --assume-yes
}

installAptBuildPackages() {
  sudo apt install ${build_packages[@]} --assume-yes
}

installAptCliPackages() {
  sudo apt install ${cli_packages[@]} --assume-yes
}
