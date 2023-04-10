#!/bin/bash

NET=$1

if ! [[ "$NET" =~ ^(preview|preprod|mainnet)$ ]]; then
    echo "Unknown net: $NET (select one in preview|preprod|mainnet)"
    exit 1
fi

BASE_URL="https://book.world.dev.cardano.org/environments/$NET"
NET_CONFIG="$CARDANO_DATA/$NET"

echo "Creating $NET_CONFIG"
mkdir "$NET_CONFIG" -p

for file_name in config db-sync-config submit-api-config topology byron-genesis shelley-genesis alonzo-genesis
do
    remote_file="$BASE_URL/$file_name.json"
    local_file="$NET_CONFIG/$file_name.json"
    echo "Downloading: $remote_file -> $local_file"
    curl "$remote_file" -o "$local_file"
done    
