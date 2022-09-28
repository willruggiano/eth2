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
    sudo dd if="''${last_known_good_file%.*}" of=/dev/sda bs=4096 conv=fsync status=progress
    popd
  '';
}
