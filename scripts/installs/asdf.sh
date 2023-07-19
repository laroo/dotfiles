#!/usr/bin/env bash

_installAsdfPackage() {
  # $1 = binary name
  # $2 = asdf package name
  # $3 = package version (default = 'latest')
  echo "package: $2"
  if ! [ -x "$(command -v $1)" ]; then
    asdf plugin add "$2" 
    asdf install "$2" $3 && asdf global "$2" $3;
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

}
