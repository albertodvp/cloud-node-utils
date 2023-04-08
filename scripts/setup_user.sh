#!/bin/bash

BUILD_NODE="nix build .#cardano-node -o cardano-node-build --accept-flake-config"
BUILD_CLI="nix build .#cardano-cli -o cardano-cli-build --accept-flake-config"
DATA=$HOME/data/cardano/db
git clone https://github.com/input-output-hk/cardano-node 
cd cardano-node || exit 1

mkdir"$DATA" -p
export DATA

tmux start-server  
tmux new-session -d -s node
tmux new-window -t node:1  -n "Node"
tmux send-keys -t node:1 "$BUILD_NODE" C-m

tmux new-window -t node:2  -n "CLI"
tmux send-keys -t node:2 "$BUILD_CLI" C-m

tmux attach-session -t node
