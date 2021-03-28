#!/usr/bin/env bash

#This script: curl -fsSL https://git.io/JY372 | bash

myuser=$(whoami)

#if [[ $myuser == u0_a258 ]]; then
#  curl -fsSL https://git.io/JY37R | bash
#  exit
#fi

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
if [[ ! -d ~/.config/code-server ]]; then
  mkdir -p ~/.config/code-server
fi

if [[ ! -f ~/.config/code-server/config.yaml ]]; then
  touch ~/.config/code-server/config.yaml
fi

configfile=~/.config/code-server/config.yaml


### PRE-DEFINED OPERATIONS

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
  echo ""
  TEXT="[✓] Setup Finished!"; greentext

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
  echo ""
  TEXT="[✓] Setup Finished!"; greentext

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
  echo ""
  TEXT="[✓] Setup Finished!"; greentext

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
  echo ""
  TEXT="[✓] Setup Finished!"; greentext

}

# Fallback: Unknown Distro detected. Tells the user to install dependencies and exits.

unknown_distro() {

  TEXT="Your System likely isn't Debian/Fedora/Arch, so make sure to install the Node.JS and yarn through your package manager."; yellowtext
  TEXT="After installing, run the following command;"; yellowtext
  echo ''
  TEXT""
  byee;

}


# generates config.yaml in ~/.config/code-server/
createConfig() {
  echo 'bind-addr: 127.0.0.1:8080' >> $configfile 
  echo 'auth: none' >> $configfile 
  echo 'password: 012345678901234567890123 # PLEASE CHANGE THIS PASSWORD' >> $configfile 
  echo 'cert: false' >> $configfile 
}

# install dependencies depending on the distro
install_all() {

  if [[ $myuser == u0_a258 ]]; then
    android_setup
  elif [[ -f /usr/bin/makepkg ]]; then # Present in Arch
    arch_setup
  elif [[ -f /usr/bin/rpm ]]; then # Present in Fedora
   fedora_setup
  elif [[ -f /usr/bin/dpkg ]]; then # Present in Debian
    debian_setup
  else # Resorts to fallback
    unknown_distro
    exit 1
  fi

}

# installs code-server globally
install-vs() {

  echo ''
  TEXT=":: Now installing code-server from npm,"; greentext
  TEXT="This will take time depending on your network speed..."; greentext
  createConfig
  echo ''
  echo ''
  
  if [[ $myuser==u0_a258 ]]; then
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

# define code-server config file with only password processed 
#code_server_pass=$(cat ~/.config/code-server/config.yaml | grep password | tr -d password:)
































##############################################################
echo ''
read -p '[?] Do you want to start code-server now? [Y/n] : ' userchoice

if [[ $userchoice == "y" || $userchoice == "ye" || $userchoice == "yes" || $userchoice == "Y" ]]; then
  echo ""
  TEXT=":: Running Code Server..."; greentext
  echo ''
  echo ":: Visit http://127.0.0.1:8080 from your browser."
  sleep 2
  code-server

elif [[ $userchoice == "n" || $userchoice == "no" || $userchoice == "N" ]]; then
  echo ''
  TEXT="Okay, you can run VS Code by just typing code-server"; greentext
  echo ''
  echo ":: Run code-server & visit http://127.0.0.1:8080 from your browser."
  echo ''
  exit 1

else 
  echo ''
  TEXT="Invalid Option, exiting."; redtext
  echo ''
  TEXT="You can run VS Code by just typing code-server."; greentext
  echo ''
  echo ":: After you run code-server, visit http://127.0.0.1:8080 from your browser."
  echo ''
  exit 1
fi


