#!/bin/bash

CARDANO_DATA="$HOME/data/cardano"
USER_BASHRC="$HOME/.bashrc"
USER_BIN="$HOME/bin"

git clone https://github.com/input-output-hk/cardano-node
git clone https://github.com/albertodvp/cloud-node-utils.git

mkdir "$CARDANO_DATA" -p
mkdir "$USER_BIN" -p

cat <<EOF | tee -a "$USER_BASHRC"
export CARDANO_DATA=$CARDANO_DATA
export PATH=$USER_BIN:$PATH
EOF

source "$USER_BASHRC"

BUILD_NODE="cd cardano-node \
            && nix build .#cardano-node -o cardano-node-build --accept-flake-config \
            && cp cardano-node-build/bin/cardano-node $USER_BIN"

BUILD_CLI="cd cardano-node \
           && nix build .#cardano-cli -o cardano-cli-build --accept-flake-config \
           && cp cardano-cli-build/bin/cardano-cli $USER_BIN"

tmux start-server  
tmux new-session -d -s node
tmux new-window -t node:1  -n "Node"
tmux send-keys -t node:1 "$BUILD_NODE" C-m

tmux new-window -t node:2  -n "CLI"
tmux send-keys -t node:2 "$BUILD_CLI" C-m

tmux attach-session -t node


