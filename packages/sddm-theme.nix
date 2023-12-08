{ pkgs, ... }:

pkgs.stdenv.mkDerivation { 
  name = "sddm-theme";
  src = pkgs.fetchgit {
    url = "https://github.com/catppuccin/sddm";
    sparseCheckout = [
      "src/catppuccin-macchiato/"
    ];
    hash = "sha256-IbTLh1kpLpgIdArgL7XQvKT3LWNt8gxo6EiAa75iLd0=";
  };
  installPhase = ''
  mkdir -p $out
  mv ./src/catppuccin-macchiato/* $out
  '';
}
