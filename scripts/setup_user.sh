#!/bin/bash

CARDANO_DATA="$HOME/data/cardano/db"
USER_BASHRC="$HOME/.bashrc"

git clone https://github.com/input-output-hk/cardano-node
git clone https://github.com/albertodvp/cloud-node-utils.git

mkdir "$CARDANO_DATA" -p

cp "cloud-node-utils/config/.bashrc" "$USER_BASHRC"
export CARDANO_DATA
source "$USER_BASHRC"

BUILD_NODE="nix build cardano-node#cardano-node -o cardano-node-build --accept-flake-config"
BUILD_CLI="nix build cardano-node#cardano-cli -o cardano-cli-build --accept-flake-config"

tmux start-server  
tmux new-session -d -s node
tmux new-window -t node:1  -n "Node"
tmux send-keys -t node:1 "$BUILD_NODE" C-m

tmux new-window -t node:2  -n "CLI"
tmux send-keys -t node:2 "$BUILD_CLI" C-m

tmux attach-session -t node


