## Import an existing wallet

1. Make a backup of your wallet using [prysm.sh][backup]
2. `scp` the zip archive to the target host
    - `unzip -d $KEYS_DIR` the archive, where `$KEYS_DIR` can be anywhere
3. `validator accounts import --wallet-dir /var/lib/ethereum/mainnet/consensus/prysm-wallet-v2 --wallet-password-file /run/agenix/wallet-password --keys-dir $KEYS_DIR --accept-terms-of-use`
4. Remove the backup archive and keystores: `nix-shell -p coreutils --run "shred -u /path/to/backup.zip && shred -u $KEYS_DIR/*.json"`

[backup]: https://docs.prylabs.network/docs/wallet/nondeterministic#backup-validator-accounts
