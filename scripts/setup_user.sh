#!/bin/bash

BUILD_NODE="nix build .#cardano-node -o cardano-node-build --accept-flake-config"
BUILD_CLI="nix build .#cardano-cli -o cardano-cli-build --accept-flake-config"
CARDANO_DATA=$HOME/data/cardano/db
CARDANO_CONFIG="$CARDANO_DATA/config/"
git clone https://github.com/input-output-hk/cardano-node 
cd cardano-node || exit 1

mkdir "$CARDANO_DATA" -p
mkdir "$CARDANO_CONFIG" -p

cat <<EOF | tee -a ~/.bashrc
export CARDANO_DATA=$CARDANO_DATA
export CARDANO_CONFIG=$CARDANO_CONFIG
EOF

source "$HOME/.bashrc"

tmux start-server  
tmux new-session -d -s node
tmux new-window -t node:1  -n "Node"
tmux send-keys -t node:1 "$BUILD_NODE" C-m

tmux new-window -t node:2  -n "CLI"
tmux send-keys -t node:2 "$BUILD_CLI" C-m

tmux attach-session -t node


