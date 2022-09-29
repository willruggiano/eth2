## Import an existing wallet

1. Make a backup of your wallet using [prysm.sh][backup]
2. `scp` the zip archive to the target host
    - `unzip -d $KEYS_DIR` the archive, where `$KEYS_DIR` can be anywhere
3. `validator-accounts-import $KEYS_DIR`

[backup]: https://docs.prylabs.network/docs/wallet/nondeterministic#backup-validator-accounts
