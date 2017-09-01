# My Dotfiles

Shamelessly copied from [Alex Palcuie's repos](https://github.com/palcu/dotfiles) and altered to my needs...

## Setup

### macOS

1. Install XCode tools using `xcode-select --install`
2. Install [Brew](http://brew.sh/)

  ```bash
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  ```

3. Install Ansible using Brew `brew install ansible`
4. As a convention `~/dotfiles` should be this repo

  ```bash
  git clone https://github.com/palcu/dotfiles.git ~/dotfiles
  ```
5. Install [XQuartz](https://xquartz.macosforge.org/landing/)
6. Run the Ansible playbook for Mac

  ```bash
  ./launch
  ```

### Ubuntu

```bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible software-properties-common git
git clone https://github.com/palcu/dotfiles.git ~/dotfiles
cd ~/dotfiles/playbooks
./launch
```

## Testing

Got macOS running in VirtualBox to test my dotfiles scripting thanks to [Jeff](https://github.com/geerlingguy/mac-dev-playbook)
