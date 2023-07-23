#!/usr/bin/env bash

_installAsdfPackage() {
  # $1 = binary name
  # $2 = asdf package name
  # $3 = package version (default = 'latest')
  local binary=$1
  local package=$2
  local version=$3
  echo "ASDF package: '${binary}==${version}' from '${package}'"
  if ! [ -x "$(command -v $binary)" ]; then
    if ! echo $(asdf plugin list) | grep -q "${package}" ; then
      echo "Adding plugin ${package}"
      asdf plugin add "${package}"
    fi
    local latest_version=$(asdf latest "${package}")
    echo "(latest version: ${latest_version})"
    #asdf install "${package}" "${version}"
    #asdf global "${package}" "${version}";
  fi
}

installAsdf() {
  # Clone repository
  echo "Cloning asdf repository...";

  if [ ! -d "$HOME/.asdf" ] ; then
    git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf;
    #echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
    #echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
  fi

  # Install useful plugins (at least for me :D)
  echo "Installing asdf plugins...";
  source $HOME/.asdf/asdf.sh;

  stow -v 1 --dir="${STOW_DIR}" --target="${HOME}" -S --adopt asdf

  # asdf plugin list all

  _installAsdfPackage ht httpie-go latest
  _installAsdfPackage go golang latest
  _installAsdfPackage aws awscli latest
  _installAsdfPackage node nodejs latest
  _installAsdfPackage jq jq latest
  _installAsdfPackage redis-cli redis-cli latest
  _installAsdfPackage k9s k9s latest
  _installAsdfPackage helm helm latest
  _installAsdfPackage saml2aws saml2aws latest
  _installAsdfPackage kubectl kubectl 1.23.14
  _installAsdfPackage kubectx kubectx latest

  asdf current
}
