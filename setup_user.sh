#!/bin/bash

git clone https://github.com/input-output-hk/cardano-node 
cd cardano-node || exit 1

tmux start-server  
tmux new-session -d -s node
tmux new-window -t node:1  -n "Node"
tmux send-keys -t node:1 "nix build .#cardano-node -o cardano-node-build --accept-flake-config" C-m
tmux new-window -t node:2  -n "CLI"
tmux send-keys -t node:2 "nix build .#cardano-cli -o cardano-cli-build --accept-flake-config" C-m
