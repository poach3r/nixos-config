{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "wallpapers";
  src = pkgs.fetchgit {
    url = "https://github.com/Gingeh/wallpapers";
    sparseCheckout = [
      "landscapes/"
    ];
    hash = "sha256-7Odz2khtWFXI60vHGP/3A5BmvazPO3yvQbML+IHRgSQ=";
  };
  installPhase = ''
  mkdir -p $out
  mv * $out
  '';
}
