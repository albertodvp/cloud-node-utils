#!/bin/bash

NET=$1

for file in config db-sync-config submit-api-config topology byron-genesis shelley-genesis alonzo-genesis
do
    curl -O -J "https://book.world.dev.cardano.org/environments/$NET/$file.json" -o "$CARDANO_CONFIG_PREVIEW/$file.json"
done    
