# My Dotfiles

Moved away from Ansible as the installation itself required a lot of dependencies. Currently just use `bash` and `stow`

## Setup

### Ubuntu

- Run setup script

  ```bash
  git clone https://github.com/laroo/dotfiles.git ~/dotfiles
  ```

- Run setup script

  ```bash
  cd ~/dotfiles
  ./setup.sh
  ```

### macOS

(currently not supported anymore)


## Testing

Run in Docker compose

  ```
  docker compose build
  docker compose run dotfiles /bin/bash
  ```

In Docker shell:

  ```
  cd ~/dotfiles
  ./setup.sh --force -t headless
  ```
