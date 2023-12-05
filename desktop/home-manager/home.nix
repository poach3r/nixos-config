{ pkgs, lib, ... }:

{
  imports = [
    ./hyprland.nix
  ];
  packages = with pkgs; [      
    filezilla
    rtorrent-curses
  ];
}
