"""A Python Pulumi program"""

import pulumi
import pulumi_hcloud as hcloud

from pathlib import Path

# Create a new SSH key
key_path = Path.home() / Path(".ssh/id_rsa_hetzner_personal.pub")
default = hcloud.SshKey("default", public_key=(lambda path: open(path).read())(key_path))



server_test_hcloud_index_server_server = hcloud.Server(
    "node",
    ssh_keys=[default.id],
    server_type="cx41",
    image="ubuntu-22.04",    
    public_nets=[hcloud.ServerPublicNetArgs(
        ipv4_enabled=True,
        ipv6_enabled=True,
    )])

