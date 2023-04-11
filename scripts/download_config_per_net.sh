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

cat <<EOF | tee -a "$USER_BASHRC"
export CARDANO_NODE_SOCKET_PATH_$NET=$NET_CONFIG/db/node.socket
EOF


# TMP: patch for Corway config files
cat <<EOF | tee "$NET_CONFIG/conway-genesis.json"
{
  "genDelegs": {}
}
EOF

sed -i '$ d' "$NET_CONFIG/config.json"
echo ', "ConwayGenesisFile": "conway-genesis.json", "ConwayGenesisHash": "f28f1c1280ea0d32f8cd3143e268650d6c1a8e221522ce4a7d20d62fc09783e1"}' >> "$NET_CONFIG/config.json"
