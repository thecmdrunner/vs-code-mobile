#!/usr/bin/env bash

#This script: curl -fsSL https://git.io/JY372 | bash


if [[ -d /data/data/com.termux ]]; then
  env_termux='yes'
fi

boldtext() {
  echo -e "\033[1m$TEXT"
}

SELF_NAME=$(basename $0)

redtext() {
  echo -e "\x1b[1;31m$TEXT\e[0m"
}

greentext() {
  echo -e "\x1b[1;32m$TEXT\e[0m"
}
 
yellowtext() {
  echo -e "\x1b[1;33m$TEXT\e[0m"
}
 
bluetext() {
  echo -e "\x1b[1;34m$TEXT\e[0m"
}


# creates config folder and file
# and interprets the password if file already exists




configfile=~/.config/code-server/config.yaml

config_stuff() {

  if [[ ! -d ~/.config/code-server ]]; then
    mkdir -p ~/.config/code-server
  fi

  if [[ ! -f ~/.config/code-server/config.yaml ]]; then
    touch ~/.config/code-server/config.yaml

    # generates config.yaml in ~/.config/code-server/
    echo 'bind-addr: 127.0.0.1:8080' >> $configfile 
    echo 'auth: none' >> $configfile 
    echo 'password: 012345678901234567890123 # PLEASE CHANGE THIS PASSWORD' >> $configfile 
    echo 'cert: false' >> $configfile 

  elif [[ -f ~/.config/code-server/config.yaml ]]; then
    password_exists='yes'
  
  else
    echo 'ERROR while configuring!'
  fi

}


 # define processed password from config.yaml 
 SERVERPASS=$(cat ~/.config/code-server/config.yaml | grep password | tr -d password:)
 AUTHTYPE='$(cat ~/.config/code-server/config.yaml | grep auth | tr -d 'auth: ')'


### PRE-DEFINED OPERATIONS

# greeting function

hiii() {

  echo ''
  TEXT="\033[1m:: VS Code Mobile"; greentext
  echo ''

}


# exit function

byee() {

  echo ""
  TEXT=":: Exiting, Bye!"; greentext
  echo ""
  exit

}

# Android Setup

android_setup() {

  cd ~/
  echo ''
  TEXT="[✓] BASE SYSTEM: ANDROID"; greentext
  echo ''
  if [[ ! -d ~/storage ]]; then
    echo "Please accept the storage permission if you want to access personal files from VS Code."
    sleep 3
    #echo "Please press ENTER if the setup doesn't proceed after 10 seconds"
    termux-setup-storage
  fi
  echo ''
  TEXT=":: Installing Node.Js, npm and yarn."; greentext
  echo ''
  apt -qy update && apt -yq -o Dpkg::Options::=--force-confnew install git nodejs yarn
  clear
  echo ''

}

# Arch Setup 

arch_setup() {
  
  echo ""
  TEXT="[✓] BASE SYSTEM: ARCH"; greentext
  echo ""
  TEXT=":: Installing Node.Js, npm and yarn."; greentext
  echo ""
  echo ""
  sudo pacman -S --noconfirm git curl nodejs npm yarn 
  clear
  echo ''

}

# Fedora Setup

fedora_setup() {

  echo ""
  TEXT="[✓] BASE SYSTEM: FEDORA"; greentext
  echo ""
  TEXT=":: Installing Node.Js, npm and yarn."; greentext
  echo ""
  echo ""
  echo ""
  sudo dnf -y install git curl nodejs npm yarn  
  clear
  echo ''

}

# Debian Setup

debian_setup() {

  echo ""
  TEXT="[✓] BASE SYSTEM: DEBIAN"; greentext
  echo ""
  TEXT=":: Installing Node.Js, npm and yarn."; greentext
  echo ""
  echo ""
  sudo apt -yq -o Dpkg::Options::=--force-confnew install git nodejs yarn
  clear
  echo ''

}

# Alpine Linux Setup (for iSH on iOS)

alpine_setup() {

  echo ""
  TEXT="[✓] BASE SYSTEM: ALPINE"; greentext
  echo ""
  TEXT=":: Installing Node.Js, npm and yarn."; greentext
  echo ""
  echo ""
  apk add git curl nodejs npm yarn
  clear
  echo ''

}

# Fallback: Unknown Distro detected. Tells the user to install dependencies and exits.

unknown_distro() {

  TEXT="Your System likely isn't Debian/Fedora/Arch, so make sure to install the Node.JS and yarn through your package manager."; yellowtext
  TEXT="After installing, run the following command;"; yellowtext
  echo ''
  TEXT""
  byee;

}

# install dependencies depending on the distro
install_all() {
  
  if [[ $env_termux == 'yes' ]]; then     # Present in Termux
    android_setup

  elif [[ -f /usr/bin/apk ]]; then        # Present in Alpine
    alpine_setup

  elif [[ -f /usr/bin/makepkg ]]; then    # Present in Arch
    arch_setup

  elif [[ -f /usr/bin/rpm ]]; then        # Present in Fedora
   fedora_setup

  elif [[ -f /usr/bin/dpkg ]]; then       # Present in Debian
    debian_setup

  else                                    # Resorts to fallback
    unknown_distro
    exit 1
  fi

}

# installs code-server globally
install_vs() {

  echo ''
  TEXT=":: Installing code-server via npm"; greentext
  TEXT="   This will take time depending on the network speed..."; greentext
  echo ''
  echo ''
  
  if [[ $env_termux='yes' ]]; then
    npm install -g code-server
  else
    sudo npm install -g code-server
  fi

  echo ''
  TEXT="[✓] Installed code-server."; greentext
  echo ''
  echo ''
  echo "[✓] Setup Finished."
  echo ''

}


instruct_user() {

  echo ''
  TEXT='[!] To start, run `code-server`'; yellowtext
  echo ''
  TEXT='[!] Then visit http://127.0.0.1:8080 from your browser'; yellowtext
  echo ''

}

hiii                # greeting
install_all         # installs dependencies
config_stuff        # config file stuff
install_vs          # installs code-server
instruct_user       # basic instructions for the user
byee                # exits

