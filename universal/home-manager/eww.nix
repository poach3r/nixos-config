{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
    eww-wayland
    pamixer
    playerctl
    acpi
    jq
    curl
  ];

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = "${../../packages/eww}";
  };
}
