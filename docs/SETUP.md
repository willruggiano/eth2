1. `scp` the ssh_host_ed25519_key.pub from the Pi to your local machine
   - Add the host key to the system keys in [secrets.nix](../secrets.nix).
2. `cd secrets && agenix -r` to rekey the host secrets
3. Uncomment L8 in [default.nix](../default.nix)
4. Upstream the changes. On the Pi, `git pull -r` to get the latest upstream.
5. `sudo nixos-rebuild switch`
6. Once the execution and consensus clients have fully synced, proceed with [VALIDATE.md](./VALIDATE.md)
   - Check the sync status of geth using the builtin javascript console: `geth-admin attach`, `eth.syncing -> false`
   - Check the sync status of prysm using ethdo: `ethdo --connection localhost:3500 node info` -> Syncing: false
