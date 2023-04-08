This is some IaC and scripts to setup a personal cardano node on hetzner using pulumi.
The steps must be successully executed in order.

# Requirements
- poetry intalled
- a public on a given [path](./__main__.py#L11) that will be loaded on the server
- a token generated from the Hetzner console

# Setup
## Provisioning
```bash
git clone https://github.com/albertodvp/node_cloud_utils.git
poetry install
poetry run pulumi config set hcloud:token HETZNER_TOKEN --secret
poetry run pulumi up
```

## Root setup
**Note**: run the bash script as root.
In this step, we install and setup nix. We also create a user (in the example `albertodvp`)
```bash
git clone https://github.com/albertodvp/node_cloud_utils.git
cd node_cloud_utils
./scripts/setup_root.sh albertodvp
```
The same private key used for `root` will allow access to the newly created user.

## User setup
**Note**: run the bash script as non-root user generated in the previous step.
In this step, we install some tools with nix.
```bash
./setup_user.sh
```

# Run (TBD)
## Run the preview testnet node
**Note**: please, do check downloaded config manually before running the node.
```bash
./setup-run-testnet-preview.sh
```

## Run the mainnet node
TODO

## Use the cli
TODO

# TODO
- [ ] Setup github action to provision and deploy the node
- [ ] Evaluate is nix build in parallel is ok
- [ ] Setup preview node
- [ ] Setup mainnet node
- [ ] Setup command for cardano cli
