#!/bin/bash

apt install tmux htop -y

adduser albertodvp --disabled-password --gecos GECOS
cp -r /root/.ssh /home/albertodvp/.ssh
cp setup_user.sh /home/albertodvp/
chown -R albertodvp:albertodvp /home/albertodvp/


sh <(curl -L https://nixos.org/nix/install) --daemon --yes
cat <<EOF | sudo tee /etc/nix/nix.conf
experimental-features = nix-command flakes
allow-import-from-derivation = true
substituters = https://cache.nixos.org https://cache.iog.io
trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
EOF

su -c /home/albertodvp/setup_user.sh albertodvp
