#!/usr/bin/env bash


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
echo ''
TEXT=":: VS Code Android"; boldtext
echo ''
echo "Please accept the storage permission if you want to access personal files from VS Code."
sleep 5
termux-setup-storage
echo "Please press ENTER if the setup doesn't proceed after 10 seconds"

# need to update or it cant install anything
echo ''
TEXT=":: Updating Repositories"; bluetext
echo ''
apt update

# installs node and npm
echo ''
TEXT=":: Installing Node.Js, npm and yarn."; bluetext
echo ''
apt install -y nodejs yarn
clear
echo ''

# installs code-server globally
echo ''
TEXT=":: Now installing code-server from npm, this will take a while depending on your network speed..."; greentext
sleep 4
echo ''
echo ''
npm install -g code-server
echo ''
TEXT="[✓] Installed code-server."; bluetext

# ask if the user wants to run it NOW
TEXT=":: If you want, you can start VS Code in your browser right now."; greentext
echo ''
read -p "Do you want to run code-server now?" userchoice
echo ''

code_server_pass=$(cat config.yaml | grep password | tr -d password:)

if [[ $userchoice == "y" || $userchoice == "ye" || $userchoice == "yes" ]]; then
  echo ""
  TEXT=":: Running Code Server, with Password:$code_server_pass"; bluetext
  echo ''
  sleep 4
  code-server
elif [[ $userchoice == "n" || $userchoice == "no" ]]; then
  echo ''
  TEXT="Okay, you can run VS Code by just typing code-server."; bluetext
  echo ''
  echo ":: After you run code-server, visit http://127.0.0.1:8080 from your browser, and enter the Password:$code_server_pass"
  echo ''
  exit 1
else 
  echo ''
  echo "Invalid Option, exiting."
  TEXT="You can run VS Code by just typing code-server."; bluetext
  echo ":: After you run code-server, visit http://127.0.0.1:8080 from your browser, and enter the Password:$code_server_pass"
  echo ''
  exit 1
fi
