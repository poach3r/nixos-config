{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    alacritty
    btop
    lutgen
    pfetch
    direnv
    lazygit
    gh
  ];
  
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
	padding = {
	  x = 8;
	  y = 0;
	};
      };
      font = {
	normal = {
	  family = "JetBrains Mono";
	  style = "Medium";
	};
	bold = {
	  family = "JetBrains Mono";
	  style = "Bold";
	};
      };
      colors = {
	primary = {
	  background = "#24273A";
	  foreground = "#CAD3F5";
	  dim_foreground = "#CAD3F5";
	  bright_foreground = "#CAD3F5";
	};
	cursor = {
	  text = "#24273A";
	  cursor = "#F4DBD6";
	};
	selection = {
	  text = "#24273A";
	  background = "#F4DBD6";
	};
	normal = {
	  black = "#494D64";
	  red = "#ED8796";
	  green = "#A6DA95";
	  yellow = "#EED49F";
	  blue = "#8AADF4";
	  magenta = "#F5BDE6";
	  cyan = "#8BD5CA";
	  white = "#B8C0E0";
	};
	bright = {
	  black = "#5B6078";
	  red = "#ED8796";
	  green = "#A6DA95";
	  yellow = "#EED49F";
	  blue = "#8AADF4";
	  magenta = "#F5BDE6";
	  cyan = "#8BD5CA";
	  white = "#A5ADCB";
	};
      };
    };
  };
 
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}
