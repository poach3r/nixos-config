{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zsh
    pure-prompt
  ];
  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    initExtra = ''
    autoload -U promptinit; promptinit
    prompt pure
    '';
    plugins = [
      {
	name = "enhancd";
	file = "init.sh";
	src = pkgs.fetchFromGitHub {
	  owner = "b4b4r07";
	  repo = "enhancd";
	  rev = "v2.2.1";
	  sha256 = "0iqa9j09fwm6nj5rpip87x3hnvbbz9w9ajgm6wkrd5fls8fn8i5g";
	};
      }
      {
	name = "zsh-syntax-highlighting";
	src = pkgs.fetchFromGitHub {
	  owner = "zsh-users";
	  repo = "zsh-syntax-highlighting";
	  rev = "143b25eb98aa3227af63bd7f04413e1b3e7888ec";
	  sha256 = "sha256-TKGCck51qQ50dQGntKaeSk8waK3BlwUjueg4MImTH8k=";
	};
      }
    ];
  };
}
