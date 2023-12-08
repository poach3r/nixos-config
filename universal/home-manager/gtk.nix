{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnome.gnome-themes-extra
  ];

  home.sessionVariables.GTK_THEME = "Catppuccin-Macchiato-Compact-Mauve-Dark";

  gtk = {
    enable = true;
    font.name = "JetBrains Mono";
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
    theme = {
      name = "Catppuccin-Macchiato-Compact-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "compact";
        variant = "macchiato";
      };
    };
  };
}
