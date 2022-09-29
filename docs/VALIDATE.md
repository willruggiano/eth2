## Import an existing wallet

1. Make a backup of your wallet using [prysm.sh][backup]
2. `scp` the zip archive to the target host
    - `nix-shell -p unzip --run "unzip /path/to/backup.zip -d $KEYS_DIR"` the archive, where `$KEYS_DIR` can be anywhere
3. `sudo validator accounts import --wallet-dir /var/lib/private/ethereum/mainnet/validator/prysm-wallet-v2 --wallet-password-file /run/agenix/wallet-password --keys-dir $KEYS_DIR --accept-terms-of-use`
4. Remove the backup archive and keystores: `nix-shell -p coreutils --run "shred -u /path/to/backup.zip && shred -u $KEYS_DIR/*.json"`

[backup]: https://docs.prylabs.network/docs/wallet/nondeterministic#backup-validator-accounts
