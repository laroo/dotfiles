#!/usr/bin/env bash

# Remote origin to use for installations
flatpak_origin='flathub'

# List of desktop apps to be installed (specified by app ID)
flatpak_apps=(

  # Communication
  'us.zoom.Zoom'              # Video call
  'com.discordapp.Discord'    # Team messaging and voice
  'org.signal.Signal'         # Private messenger, mobile
  'com.slack.Slack'           # Work and team messaging

  # Media
  'com.spotify.Client'        # Music streaming
  'org.videolan.VLC'          # Media player

  # Creativity
  'com.jgraph.drawio.desktop' # UML + Diagram tool
  'com.uploadedlobster.peek'  # Screen recorder
  'nl.hjdskes.gcolor3'        # Color picker
  'org.audacityteam.Audacity' # Sound editor
  'org.flameshot.Flameshot'   # Screenshot tool
  'org.gimp.GIMP'             # Picture editor
  'org.inkscape.Inkscape'     # Vector editor
  
  # Software development
  'com.visualstudio.code'     # Extendable IDE
  'com.getpostman.Postman'    # API development
  'org.wxhexeditor.wxHexEditor'  # Hex editor
  'org.gnome.meld'               # Diff
  'io.dbeaver.DBeaverCommunity'  # DB viewer
  'com.jetbrains.PyCharm-Professional'  # Python IDE

  # Browsers and internet
  'org.mozilla.firefox'       # Firefox web browser (primary)
  'com.github.Eloston.UngoogledChromium' # Chromium-based borwser (secondary)

  # Office
  'org.libreoffice.LibreOffice' # Office suite
  'md.obsidian.Obsidian'        # Markdown editor
  'org.geany.Geany'     # Text editor
  
  # Personal
  'com.nordpass.NordPass'     # Password manager
)

# Helper function to install Flatpak (if not present) for users current distro
function install_flatpak () {
  # Arch, Manjaro
  if hash "pacman" 2> /dev/null; then
    echo -e "Installing Flatpak via Pacman"
    sudo pacman -S flatpak
  # Debian, Ubuntu, PopOS, Raspian
  elif hash "apt" 2> /dev/null; then
    echo -e "Installing Flatpak via apt get"
    sudo apt install flatpak
  # Alpine
  elif hash "apk" 2> /dev/null; then
    echo -e "Installing Flatpak via apk add"
    sudo apk add flatpak
  # Red Hat, CentOS
  elif hash "yum" 2> /dev/null; then
    echo -e "Installing Flatpak via Yum"
    sudo yum install flatpak
  fi
}

# Checks if a given app ($1) is already installed, otherwise installs it
function install_app () {
  app=$1

  # Process app ID, and grep for it in system
  app_name=$(echo $app | rev | cut -d "." -f1 | rev)
  is_in_flatpak=$(echo $(flatpak list --columns=ref | grep $app))
  is_in_pacman=$(echo $(pacman -Qk $(echo $app_name | tr 'A-Z' 'a-z') 2> /dev/null ))
  is_in_apt=$(echo $(dpkg -s $(echo $app_name | tr 'A-Z' 'a-z') 2> /dev/null ))

  # Check app not already installed via Flatpak
  if [ -n "$is_in_flatpak" ]; then
    echo -e "[Skipping] ${app_name} is already installed."
  # Check app not installed via Pacman (Arch Linux)
  elif [[ "${is_in_pacman}" == *"total files"* ]]; then
    echo -e "[Skipping] ${app_name} is already installed via Pacman."
  # Check app not installed via apt get (Debian)
  elif [[ "${is_in_apt}" == *"install ok installed"* ]]; then
    echo -e "[Skipping] ${app_name} is already installed via apt-get."
  else
    # Install app using Flatpak
    echo -e "[Installing] Downloading ${app_name} (from ${flatpak_origin})."
    flatpak install -y --noninteractive $flatpak_origin $app
  fi
}

installFlatpak() {

  # Check that Flatpak is present, install if not
  if ! hash flatpak 2> /dev/null; then
    echo -e "Flatpak isn't yet installed on your system$"
    install_flatpak
  fi

  # Add FlatHub as upstream repo, if not already present
  echo -e "Adding Flathub repo"
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

  # Update currently installed apps
  echo -e "Updating installed apps"
  flatpak update --assumeyes --noninteractive

  # Install each app listed above (if not already installed)
  echo -e "Installing apps defined in manifest"
  for app in ${flatpak_apps[@]}; do
    install_app $app
  done

}
