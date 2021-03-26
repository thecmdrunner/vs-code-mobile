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
 
 
bluetext() {
  echo -e "\x1b[1;34m$TEXT\e[0m"
}

# access phone's storage from termux to edit files files stored there from VS Code
cd ~/
echo ''
TEXT=":: VS Code Android"; boldtext
echo ''
echo "Please accept the storage permission if you want to access personal files from VS Code."
sleep 5
termux-setup-storage
echo "Please press ENTER if the setup doesn't proceed after 10 seconds"

# need to update or it cant install anything
echo ''
TEXT=":: Updating Repositories"; greemtext
echo ''
apt update

# installs node and npm
echo ''
TEXT=":: Installing Node.Js, npm and yarn."; greentext
echo ''
apt install -y nodejs yarn
clear
echo ''

# installs code-server globally
echo ''
TEXT=":: Now installing code-server from npm."; greentext
TEXT="This will take time depending on your network speed..."; greentext
echo ''
echo ''
npm install -g code-server
echo ''
TEXT="[✓] Installed code-server."; greentext
echo ''

# ask if the user wants to run it at startup
echo -e ":: If you want, you can start VS Code automatically when termux starts."
echo ''
echo 'Do you want to enable auto-start?'
echo ''
read -p "Please enter your choice [Y/N]: " autostartchoice
echo ''

if [[ $autostartchoice == "y" || $autostartchoice == "ye" || $autostartchoice == "yes" || $autostartchoice == "Y" ]]; then
  echo ""
  echo code-server >> ~/.bashrc
  echo ''
elif [[ $autostartchoice == "n" || $autostartchoice == "no" || $autostartchoice == "N" ]]; then
  echo ''
  TEXT="Okay, you can run VS Code by just typing code-server."; bluetext
  echo ''
  echo ":: After you run code-server, visit http://127.0.0.1:8080 from your browser, and enter the Password:$code_server_pass"
  echo ''
  exit 1
else 
  echo ''
  TEXT="Invalid Option, exiting."; redtext
  echo ''
  TEXT="You can run VS Code by just typing code-server."; bluetext
  echo ":: After you run code-server, visit http://127.0.0.1:8080 from your browser, and enter the Password:$code_server_pass"
  echo ''
  exit 1
fi

echo ''
echo "[✓] Setup Finished."
read -p 'Do you want to start code-server now? [Y/n] : ' userchoice

# define code-server config file with only password processed 
code_server_pass=$(cat ~/.config/code-server/config.yaml | grep password | tr -d password:)

if [[ $userchoice == "y" || $userchoice == "ye" || $userchoice == "yes" || $userchoice == "Y" ]]; then
  echo ""
  TEXT=":: Running Code Server, with Password:$code_server_pass"; bluetext
  echo ''
  sleep 4
  code-server
elif [[ $userchoice == "n" || $userchoice == "no" || $userchoice == "N" ]]; then
  echo ''
  TEXT="Okay, you can run VS Code by just typing code-server."; bluetext
  echo ''
  echo ":: Run code-server & visit http://127.0.0.1:8080 from your browser, and enter the Password:$code_server_pass"
  echo ''
  exit 1
else 
  echo ''
  TEXT="Invalid Option, exiting."; redtext
  echo ''
  TEXT="You can run VS Code by just typing code-server."; bluetext
  echo ":: After you run code-server, visit http://127.0.0.1:8080 from your browser, and enter the Password:$code_server_pass"
  echo ''
  exit 1
fi
