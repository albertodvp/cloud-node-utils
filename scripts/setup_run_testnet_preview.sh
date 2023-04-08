#!/bin/bash
mkdir $HOME/config/preview -p
cd $HOME/config/preview || exit 1

curl -O -J https://book.world.dev.cardano.org/environments/preview/config.json
curl -O -J https://book.world.dev.cardano.org/environments/preview/db-sync-config.json
curl -O -J https://book.world.dev.cardano.org/environments/preview/submit-api-config.json
curl -O -J https://book.world.dev.cardano.org/environments/preview/topology.json
curl -O -J https://book.world.dev.cardano.org/environments/preview/byron-genesis.json
curl -O -J https://book.world.dev.cardano.org/environments/preview/shelley-genesis.json
curl -O -J https://book.world.dev.cardano.org/environments/preview/alonzo-genesis.json


cardano-node run \
             --topology $HOME/config/preview/topology.json \
             --database-path path/to/db \
             --socket-path path/to/db/node.socket \
             --host-addr x.x.x.x \
             --port 3001 \
             --config $HOME/config/preview/config.json
