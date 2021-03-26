#!/usr/bin/env bash

#This script: curl -fsSL https://git.io/JYLt6 | bash


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


echo ''
cd ~/
touch ~/quick-vm.log
if [[ -f ~/quick-vm.log ]]
then
  echo "Logs for Quick-VM Project are written here. Link: https://github.com/gamerhat18/quick-vm" >> ~/quick-vm.log
  if [[ $EUID -ne 0 ]]; then
    echo " Not running this script as root. " >>  ~/quick-vm.log
  fi
else
  TEXT="Filesystem is READ-ONLY. Errors may not be logged."; redtext
  TEXT="YOU MAY CONTINUE, BUT MIGHT ENCOUNTER ERRORS."; redtext
fi
echo ''


### PRE-DEFINED OPERATIONS

# exit function

byee() {

  echo ""
  TEXT=":: Exiting, Bye!"; greentext
  echo ""
  exit

}

# Arch Setup 

arch_setup() {
  
  echo ""
  TEXT="[✓] BASE SYSTEM: ARCH"; greentext
  echo ""
  TEXT=":: Installing Node.Js, npm and yarn."; greentext
  echo ""
  echo ""
  sudo pacman -S --noconfirm git curl nodejs yarn 
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
  sudo dnf -y install git curl nodejs yarn  
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
  sudo apt install -y git curl nodejs yarn  
  echo ""
  TEXT="[✓] Setup Finished!"; greentext

}

# Fallback: Unknown Distro detected. Tells the user to install dependencies himself and checks if the system uses systemd init, then exits.

unknown_distro() {

  TEXT="Your System possibly isn't Debian/Fedora/Arch, so make sure to install the Node.JS and yarn through your package manager."; bluetext
  echo ""
  TEXT""
  byee;

}

configfile=~/.config/code-server/config.yaml

# generates config.yaml in ~/.config/code-server/
createConfig() {
  echo 'bind-addr: 127.0.0.1:8080' >> configfile 
  echo 'auth: none' >> configfile 
  echo 'password: 012345678901234567890123 # PLEASE CHANGE THIS PASSWORD' >> configfile 
  echo 'cert: false' >> configfile 
}


# installs code-server globally
echo ''
TEXT=":: Now installing code-server from npm,"; greentext
TEXT="This will take time depending on your network speed..."; greentext
createConfig
echo ''
echo ''
npm install -g code-server
echo ''
TEXT="[✓] Installed code-server."; greentext
echo ''

# ask if the user wants to run it at startup
echo -e ":: If you want, you can start VS Code automatically when termux starts."
echo ''
TEXT='[?] Do you want to enable auto-start?'; yellowtext
echo ''
read -p "Please enter your choice [Y/N]: " autostartchoice
echo ''

# define code-server config file with only password processed 
#code_server_pass=$(cat ~/.config/code-server/config.yaml | grep password | tr -d password:)

# Asks the user about auto-start

if [[ $autostartchoice == "y" || $autostartchoice == "ye" || $autostartchoice == "yes" || $autostartchoice == "Y" ]]; then
  echo ""
  echo code-server >> ~/.bashrc
  echo ''
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

echo ''
echo "[✓] Setup Finished."
echo ''

# Asks the user whether to start code-server or exit
read -p '[?] Do you want to start code-server now? [Y/n] : ' userchoice

if [[ $userchoice == "y" || $userchoice == "ye" || $userchoice == "yes" || $userchoice == "Y" ]]; then
  echo ""
  TEXT=":: Running Code Server..."; greentext
  echo ''
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


