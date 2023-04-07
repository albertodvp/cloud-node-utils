#!/bin/bash

apt install tmux htop -y

adduser albertodvp --disabled-login
mkdir /home/albertodvp
cp -r /root/.ssh /home/albertodvp/.ssh
chown -R albertodvp:albertodvp /home/albertodvp


mkdir /etc/nix/
cat <<EOF | sudo tee /etc/nix/nix.conf
experimental-features = nix-command flakes
allow-import-from-derivation = true
substituters = https://cache.nixos.org https://cache.iog.io
trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
EOF


su - albertodvp

bash <(curl -L https://nixos.org/nix/install) --no-daemon

git clone https://github.com/input-output-hk/cardano-node
cd cardano-node

# Create a new session named "node"
tmux new-session -d -s node

# Open a new window and run "command1" in it
tmux new-window -t node:1 -n "Node" "nix build .#cardano-node -o cardano-node-build"

# Open another new window and run "command2" in it
tmux new-window -t node:2 -n "Cli" "nix build .#cardano-cli -o cardano-cli-build"

# Attach to the "node" session
tmux attach-session -t node
