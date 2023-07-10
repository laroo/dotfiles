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

installAptPackages() {
  sudo apt-get update
  sudo apt-get install --yes \
    build-essential \
    nano \
    stow \

}

installShell() {
  # Install zsh and required software
  echo "Installing zsh";
  if ! [ -x "$(command -v zsh)" ]; then
    sudo apt-get install --yes zsh

    # Change the shell to zsh
    echo "Changing the shell of this user to use zsh...";
    # Only add if it doesn't exist
    grep -qxF $(which zsh) /etc/shells || echo $(which zsh) | sudo tee -a /etc/shells
    # sudo chsh -s $(which zsh) $CURRENT_USER
    sudo usermod -s $(which zsh) $CURRENT_USER

    # Install Oh My Zsh!
    echo "Installing Oh My Zsh...";
    curl -L http://install.ohmyz.sh | sh
    echo "Installing ZSH syntax highlighting...";
    rm -rf ~/.zsh-custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-custom/plugins/zsh-syntax-highlighting

    # Install powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh-custom/themes/powerlevel10k

    # Overwrite existing file
    stow --adopt zsh
    git restore .
  fi

  echo "Reload shell to get zsh"
  # $(which zsh) -l

}

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
    echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
    echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
  fi

  source ~/.bashrc

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

installPyenv() {
  if [ ! -d "$HOME/.asdf" ] ; then
    sudo apt-get install --yes \
      build-essential \
      libssl-dev \
      zlib1g-dev \
      libbz2-dev \
      libreadline-dev \
      libsqlite3-dev curl \
      libncursesw5-dev \
      xz-utils \
      tk-dev \
      libxml2-dev \
      libxmlsec1-dev \
      libffi-dev \
      liblzma-dev \

    git clone https://github.com/pyenv/pyenv.git ~/.pyenv

    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc

    # Doesn't work with bash
    # echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
    # echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
    # echo 'eval "$(pyenv init -)"' >> ~/.profile

    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc

  fi

  source ~/.bashrc
}

doIt() {
  installAptPackages
  installShell;
  installAsdf;
  installPyenv;
}

if [ "$EUID" -eq 0 ]
  then echo "Do not run as root! Will use sudo"
  exit 1
fi

if [ "${1-}" == "--force" -o "${1-}" == "-f" ]; then
  doIt;
else
  read -p "I'm about to change the configuration files placed in your home directory. Do you want to continue? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;

echo "[done]"
