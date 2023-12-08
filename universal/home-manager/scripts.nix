{ pkgs, ... }:

let
  backup = pkgs.callPackage ../../packages/backup.nix { inherit pkgs; };
in {
  home.packages = with pkgs; [
    backup
  ];
}
