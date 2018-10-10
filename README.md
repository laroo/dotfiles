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
  git clone https://github.com/laroo/dotfiles.git ~/dotfiles
  ```
5. Install [XQuartz](https://xquartz.macosforge.org/landing/)
6. Run the Ansible playbook for Mac

  ```bash
  ./launch
  ```

### Ubuntu

```bash
sudo apt update && sudo apt install -y software-properties-common git curl wget python3 python3-distutils
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1
curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py 
sudo pip install virtualenvwrapper ansible
git clone https://github.com/laroo/dotfiles.git ~/dotfiles
cd ~/dotfiles/playbooks
./launch
```

## Testing

Got macOS running in VirtualBox to test my dotfiles scripting thanks to [Jeff](https://github.com/geerlingguy/mac-dev-playbook)
