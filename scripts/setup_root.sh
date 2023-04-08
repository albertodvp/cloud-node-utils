#!/bin/bash

USERNAME=$1
USER_HOME="/home/$USERNAME"
apt install tmux htop -y  || exit 1

sh <(curl -L https://nixos.org/nix/install) --daemon --yes  || exit 1

cat <<EOF | sudo tee /etc/nix/nix.conf
experimental-features = nix-command flakes
allow-import-from-derivation = true
substituters = https://cache.nixos.org https://cache.iog.io
trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
EOF

adduser "$USERNAME" --disabled-password --gecos GECOS
cp -r "$HOME/.ssh" "$USER_HOME/.ssh"
cp -r "scripts" "$USER_HOME/scripts"
chown -R "$USERNAME":"$USERNAME" "$USER_HOME"

# bash CARDNAO_DATA, cardano-cli, cardano-node
