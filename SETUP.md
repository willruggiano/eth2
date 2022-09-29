1. `scp` the ssh_host_ed25519_key.pub from the Pi to your local machine
    - Add the host key to the system keys in [secrets.nix](./secrets.nix).
2. `cd secrets && agenix -r` to rekey the host secrets
3. Uncomment L8 in [default.nix](./default.nix)
4. Upstream the changes. On the Pi, `git pull -r` to get the latest upstream.
5. `sudo nixos-rebuild switch`
