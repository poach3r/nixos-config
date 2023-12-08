{ pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./neovim.nix
    ./mako.nix
    ./pass.nix
    ./zsh.nix
    ./gtk.nix
    ./librewolf.nix
    ./eww.nix
    ./scripts.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "poacher";
    homeDirectory = "/home/poacher/";
    stateVersion = "23.11";

    packages = with pkgs; [      
      xfce.thunar
      xfce.thunar-archive-plugin
      xarchiver
      vlc
      rofi
    ];
  };
}
