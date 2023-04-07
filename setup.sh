#!/bin/bash

apt install tmux htop -y

adduser albertodvp --disabled-password --gecos GECOS
cp -r /root/.ssh /home/albertodvp/.ssh
chown -R albertodvp:albertodvp /home/albertodvp/.ssh/


sh <(curl -L https://nixos.org/nix/install) --daemon --yes
cat <<EOF | sudo tee /etc/nix/nix.conf
experimental-features = nix-command flakes
allow-import-from-derivation = true
substituters = https://cache.nixos.org https://cache.iog.io
trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
EOF


su - albertodvp
git clone https://github.com/input-output-hk/cardano-node
cd cardano-node

tmux start-server  
tmux new-session -d -s node
tmux new-window -t node:1  -n "Node"
tmux send-keys -t node:1 "nix build .#cardano-node -o cardano-node-build --accept-flake-config" C-m
tmux new-window -t node:2  -n "CLI"
tmux send-keys -t node:2 "nix build .#cardano-cli -o cardano-cli-build --accept-flake-config" C-m

tmux attach-session -t node:1
