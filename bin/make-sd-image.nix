{
  writeShellApplication,
  coreutils,
  wget,
  zstd,
  ...
}:
writeShellApplication {
  name = "make-sd-image";
  runtimeInputs = [coreutils wget zstd];
  text = ''
    pushd sd-images
    last_known_good="$(cat .last-known-good)"
    last_known_good_file="''${last_known_good##*/}"
    [ -f "$last_known_good_file" ] || wget "$last_known_good"
    unzstd -d "''${last_known_good##*/}"
    nix-shell -p rpi-imager --run 'sudo -E rpi-imager'
    popd
  '';
}
