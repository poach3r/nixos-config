{ pkgs, lib, ... }:

let 
  backup = pkgs.writeShellScriptBin "backup" ''
    theme=$1
    location=$(cat ~/.config/backups/backupLocations.txt | rofi -dmenu -matching fuzzy -theme $theme -p "Backup Location")
    dir="$location/$(date +%m.%d.%Y)"
    mkdir $dir
    while read -r line
    do
      ${pkgs.libnotify}/bin/notify-send "Copying $line"
      cp -r $line $dir
    done < ~/.config/backups/backupSources.txt
    ${pkgs.libnotify}/bin/notify-send "Compressing $dir"
    tar czvf "$dir-archive.tar" $dir
    rm -rf $dir
    ${pkgs.libnotify}/bin/notify-send "Finished Compressing $dir"
  '';
in {
  imports = [
    ./alacritty.nix
    ./neovim.nix
    ./mako.nix
    ./pass.nix
    ./zsh.nix
    ./gtk.nix
    ./librewolf.nix
    ./eww.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "poacher";
    homeDirectory = "/home/poacher/";
    stateVersion = "23.11";

    packages = with pkgs; [      
      rofi
      xfce.thunar
      xfce.thunar-archive-plugin
      xarchiver
      vlc
      backup
    ];
  };
}
