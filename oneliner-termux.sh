#!/usr/bin/env bash

#This script: curl -fsSL https://git.io/JY37R | bash

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

mkdir .config
mkdir .config/code-server
configfile=~/.config/code-server/config.yaml

# generates config.yaml in ~/.config/code-server/
createConfig() {
  echo 'bind-addr: 127.0.0.1:8080' >> $configfile 
  echo 'auth: none' >> $configfile 
  echo 'password: 012345678901234567890123 # PLEASE CHANGE THIS PASSWORD' >> $configfile 
  echo 'cert: false' >> $configfile 
}


# Script starts execution
echo ''
TEXT="[✓] BASE SYSTEM: ANDROID"; greentext

# access phone's storage from termux to edit files files stored there from VS Code
cd ~/
echo ''
TEXT=":: VS Code Mobile"; boldtext
echo ''

# Enable local storage access in ~/storage

if [[ ! -d ~/storage ]]; then
  echo "Please accept the storage permission if you want to access personal files from VS Code."
  sleep 3
 # echo "Please press ENTER if the setup doesn't proceed after 10 seconds"
  termux-setup-storage
fi

# need to update or it cant install anything
echo ''
TEXT=":: Updating Repositories"; greentext
echo ''
apt -qy update 

# installs node and npm
echo ''
TEXT=":: Installing Node.Js, npm and yarn."; greentext
echo ''
apt -yq -o Dpkg::Options::=--force-confnew install git nodejs yarn
clear
echo ''

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

# define code-server config file with only password processed 
#code_server_pass=$(cat ~/.config/code-server/config.yaml | grep password | tr -d password:)

echo ''
echo "[✓] Setup Finished."
echo ''

# Tells the user how to start code-server
TEXT='[!] To start, run code-server & visit http://127.0.0.1:8080 from your browser.'; yellowtext 

