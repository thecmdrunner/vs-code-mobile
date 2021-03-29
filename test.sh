if [[ $AUTHTYPE=='password' ]]; then
  echo 'pass'
elif [[ $AUTHTYPE=='none' ]]; then
  echo 'nopass'
else
  echo 'lol'
fi
