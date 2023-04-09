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
git clone https://github.com/albertodvp/cloud_node_utils.git
cd cloud_node_utils
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
git clone https://github.com/albertodvp/cloud_node_utils.git
cd cloud_node_utils
./scripts/setup_root.sh albertodvp
```
The same private key used for `root` will allow access to the newly created user.

### User setup | on cloud, as non-root
> **_NOTE:_** run the bash script as non-root user generated in the previous step.
In this step, we install some tools with nix.
```bash
./scripts/setup_user.sh
```

## Run (TODO)
### Run the preview testnet node
> **_NOTE:_** please, do check downloaded config manually before running the node.
```bash
./scripts/download_config_per_net.sh preview

```
### Run the mainnet node
TODO

### Use the cli
TODO

## TODO
- [ ] Setup github action to provision and deploy the node
- [ ] Evaluate is nix build in parallel is ok
- [ ] Setup preview node
- [ ] Setup mainnet node
- [ ] Setup command for cardano cli
- [ ] Make pub key path/name customizable
