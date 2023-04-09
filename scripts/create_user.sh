#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, provide username"
fi

USERNAME=$1
USER_HOME="/home/$USERNAME"
adduser "$USERNAME" --disabled-password --gecos GECOS
cp -r "$HOME/.ssh" "$USER_HOME/.ssh"
cp "scripts/setup_user.sh" "$USER_HOME/"
chown -R "$USERNAME":"$USERNAME" "$USER_HOME"
