#!/bin/bash


NET=$1
PORT=$2

if ! [[ "$NET" =~ ^(preview|preprod|mainnet)$ ]]; then
    echo "Usage: run_node.sh NET PORT"
    exit 1
fi

CONFIG_FILE_DIR="$CARDANO_DATA/$NET"
NET_DATA="$CONFIG_FILE_DIR/db"

mkdir "$NET_DATA" -p

cardano-node run \
             --topology "$CONFIG_FILE_DIR/topology.json" \
             --database-path "$NET_DATA" \
             --socket-path "$NET_DATA/node.socket" \
             --host-addr 0.0.0.0 \
             --port "$PORT" \
             --config "$CONFIG_FILE_DIR/config.json"
