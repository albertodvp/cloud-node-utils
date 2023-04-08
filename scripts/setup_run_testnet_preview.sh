#!/bin/bash
CONFIG="$CARDANO_DATA/config/preview"

mkdir "$CONFIG" -p
cd "$CONFIG" || exit 1

curl -O -J https://book.world.dev.cardano.org/environments/preview/config.json
curl -O -J https://book.world.dev.cardano.org/environments/preview/db-sync-config.json
curl -O -J https://book.world.dev.cardano.org/environments/preview/submit-api-config.json
curl -O -J https://book.world.dev.cardano.org/environments/preview/topology.json
curl -O -J https://book.world.dev.cardano.org/environments/preview/byron-genesis.json
curl -O -J https://book.world.dev.cardano.org/environments/preview/shelley-genesis.json
curl -O -J https://book.world.dev.cardano.org/environments/preview/alonzo-genesis.json


cardano-node run \
             --topology "$CONFIG/topology.json" \
             --database-path "$CARDANO_DATA" \
             --socket-path "$CARDANO_DATA/node.socket" \
             --host-addr 0.0.0.0 \
             --port 3001 \
             --config "$CONFIG/config.json"
