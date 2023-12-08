{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "rofi";
  src = pkgs.fetchgit {
    url = "https://github.com/poach3r/nixos-config";
    sparseCheckout = [
      "packages/rofi/"
    ];
    hash = "sha256-VYOHQjmNK1NA76OIyNQtlqbiw+K+g2FAqbMwQpN1VVI=";
  };
  installPhase = ''
  mkdir -p $out
  mv ./packages/rofi/* $out
  '';
}
