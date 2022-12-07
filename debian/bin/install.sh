#!/usr/bin/env bash

BIN_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
DEB_DIR="$(dirname "$BIN_DIR")"

SYSTEMD_DIR=/usr/lib/systemd/system

echo "Installing systemd files from $DEB_DIR/systemd -> $SYSTEMD_DIR"
install -m644 "$DEB_DIR"/systemd/*.service "$SYSTEMD_DIR"

echo "Reloading the systemctl daemon"
systemctl daemon-reload
