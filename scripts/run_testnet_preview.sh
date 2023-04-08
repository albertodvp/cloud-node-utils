#!/bin/bash

$HOME/cardano-node/cardano-node-build/bin/cardano-node run \
             --topology "$CARDANO_CONFIG_PREVIEW/topology.json" \
             --database-path "$CARDANO_DATA" \
             --socket-path "$CARDANO_CONFIG_PREVIEW/node.socket" \
             --host-addr 0.0.0.0 \
             --port 3001 \
             --config "$CARDANO_CONFIG_PREVIEW/config.json"
