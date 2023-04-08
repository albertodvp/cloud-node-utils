"""A Python Pulumi program"""

import pulumi
import pulumi_hcloud as hcloud

from pathlib import Path

from pulumi_hcloud.get_server import get_server

# Create a new SSH key
key_path = Path.home() / Path(".ssh/id_rsa_hetzner_personal.pub")
default = hcloud.SshKey("default", public_key=(lambda path: open(path).read())(key_path))


node_server = hcloud.Server(
    "node-server",
    ssh_keys=[default.id],
    server_type="cx41",
    image="ubuntu-22.04",
    delete_protection=True,
    rebuild_protection=True,
    public_nets=[hcloud.ServerPublicNetArgs(
        ipv4_enabled=True,
        ipv6_enabled=True,
    )])
