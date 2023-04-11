# Cloud node utils
This is some IaC and scripts to setup a personal cardano node on hetzner using pulumi.
The steps must be successully executed in order.

## Requirements
- [poetry](https://python-poetry.org) installed
- a public key stored on a given local [path](./__main__.py#L11) that will be loaded on the server.
- a token generated from the Hetzner [console](https://console.hetzner.cloud/) (`HETZNER_TOKEN`)

## Setup 
### Provisioning | on local pc
```bash
git clone https://github.com/albertodvp/cloud-node-utils.git
cd cloud-node-utils
poetry install
poetry run pulumi stack init node
poetry run pulumi config set hcloud:token HETZNER_TOKEN --secret
poetry run pulumi up -f
```

**Suggestion**: after you got your ipv4 assigned you may want to add these lines in your `~/.ssh/config` file.
```plain
Host node
    HostName ASSIGNED_IP
    User USERNAME
    IdentityFile ~/.ssh/id_rsa_hetzner_personal

Host node-root
    HostName ASSIGNED_IP
    User root
    IdentityFile ~/.ssh/id_rsa_hetzner_personal
```
With these, you will be able to connect to the server easily (e.g. `ssh node-root` to access as root).

### Root setup | on cloud, as root
In this step, we install and setup nix. We also create a user (in the example `albertodvp`)
```bash
git clone https://github.com/albertodvp/cloud-node-utils.git
./cloud-node-utils/scripts/setup_root.sh
./cloud-node-utils/scripts/create_root.sh albertodvp
```
The same private key used for `root` will allow access to the newly created users.

### User setup | on cloud, as non-root
> **_NOTE:_** run the bash script as non-root user generated in the previous step.
In this step, we install some tools with nix.
```bash
./cloud-node-utils/scripts/setup_user.sh
```

## Run (TODO)
### Setup the config files
> **_NOTE:_** please, do check downloaded config manually before running the node.
```bash
./cloud-node-utils/scripts/download_config_per_net.sh preview
./cloud-node-utils/scripts/download_config_per_net.sh mainnet
```
### Run the node
> **_NOTE:_** The port number is arbitrary
```bash
./cloud-node-utils/scripts/run_node.sh mainnet 3001
./cloud-node-utils/scripts/run_node.sh preview 3002
```

### Run the node
> **_NOTE:_** The port number is arbitrary
```bash
./cloud-node-utils/scripts/run_node.sh mainnet 3001
./cloud-node-utils/scripts/run_node.sh preview 3002
```
### Query the net 
> **_NOTE:_** The environment variables used to set the CARDANO_NODE_SOCKET_PATH
#### Mainnet
```bash
CARDANO_NODE_SOCKET_PATH=$CARDANO_NODE_SOCKET_PATH_mainnet cardano-cli query tip --mainnet
```
#### Preview
```bash
CARDANO_NODE_SOCKET_PATH=$CARDANO_NODE_SOCKET_PATH_preview cardano-cli query tip --testnet-magic 2
```

## TODO
- [ ] Setup github action to provision and deploy the node
- [ ] Evaluate is nix build in parallel is ok
- [ ] Make pub key path/name customizable
