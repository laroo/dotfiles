#!/usr/bin/env bash

installShell() {
  # Install zsh and required software
  echo "Installing zsh";
  if ! [ -x "$(command -v zsh)" ]; then
      # Overwrite existing file
    stow --dir="${STOW_DIR}" --target="${HOME}" -S --adopt zsh

    sudo apt-get install --yes zsh

    # Install Oh My Zsh!
    echo "Installing Oh My Zsh...";
    curl -L http://install.ohmyz.sh | sh
    echo "Installing ZSH syntax highlighting...";
    rm -rf ~/.zsh-custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-custom/plugins/zsh-syntax-highlighting

    # Install powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh-custom/themes/powerlevel10k

    # Change the shell to zsh
    echo "Changing the shell of this user to use zsh...";
    # Only add if it doesn't exist
    grep -qxF $(which zsh) /etc/shells || echo $(which zsh) | sudo tee -a /etc/shells
    # sudo chsh -s $(which zsh) $CURRENT_USER
    sudo usermod -s $(which zsh) $CURRENT_USER

  fi

  # echo "Reload shell to get zsh"
  # $(which zsh) -l

}

echo "[done]"
