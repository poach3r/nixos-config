{ pkgs, lib, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    libreoffice
  ];
}
