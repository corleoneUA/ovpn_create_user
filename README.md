# Creating users for OpenVPN

## Installation

Use `git clone` for clone this repository.
Uncoment on the `base.conf` line `remote #server-name# 1194` put your "servername or IP", change if you need port.
Create ca-dir `make-cadir` and edit in `make_config.sh` `KEY_DIR` to your's path.

## Usage

Use `./make_config.sh client_name` for creating single client_name.ovpn file.

Use `./make_config.sh client_name lin` for creating individual files. For example for Network Manager.
