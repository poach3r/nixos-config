{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mako
    libnotify
  ];

  services.mako = {
    enable = true;
    anchor = "top-right";
    backgroundColor = "#24273a";
    borderRadius = 8;
    borderSize = 0;
    textColor = "#cad3f5";
    layer = "overlay";
    font = "JetBrains Mono 12";
    padding = "0";
    defaultTimeout = 2000;
  };
}
