{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "rofi";
  src = pkgs.fetchgit {
    url = "https://github.com/poach3r/nixos-config";
    sparseCheckout = [
      "packages/rofi/"
    ];
    hash = "";
  };
  installPhase = ''
  mkdir -p $out
  mv ./packages/rofi $out
  '';
}
