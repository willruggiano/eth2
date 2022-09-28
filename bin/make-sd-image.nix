{
  writeShellApplication,
  rpi-imager,
  wget,
  zstd,
  ...
}:
writeShellApplication {
  name = "make-sd-image";
  runtimeInputs = [rpi-imager wget zstd];
  text = ''
    pushd sd-images
    last_known_good="$(cat .last-known-good)"
    wget "https://hydra.nixos.org/build/192408211/download/1/''${last_known_good}.img.zst"
    unzstd -d "''${last_known_good}.img.zst"
    popd

    sudo -E rpi-imager
  '';
}
