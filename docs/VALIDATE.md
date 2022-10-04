## Import an existing wallet

1. Make a backup of your wallet using [prysm.sh][backup]
2. `scp` the zip archive to the target host
   - `nix-shell -p unzip --run "unzip /path/to/backup.zip -d $KEYS_DIR"` the archive, where `$KEYS_DIR` can be anywhere
3. `sudo validator accounts import --wallet-dir /var/lib/private/ethereum/mainnet/validator/prysm-wallet-v2 --wallet-password-file /run/agenix/wallet-password --keys-dir $KEYS_DIR --accept-terms-of-use`
4. Remove the backup archive and keystores: `nix-shell -p coreutils --run "shred -u /path/to/backup.zip && shred -u $KEYS_DIR/*.json"`
5. After the execution and consensus clients finish syncing, enable the validator by changing `services.ethereum.consensus.prysm.validator.enable` to `true` in [ethereum.nix](../ethereum.nix)
   - Check the sync status of geth using the builtin javascript console: `geth-admin attach`, `eth.syncing -> false`
   - Check the sync status of prysm using ethdo: `ethdo --connection localhost:3500 node info` -> Syncing: false

[backup]: https://docs.prylabs.network/docs/wallet/nondeterministic#backup-validator-accounts
