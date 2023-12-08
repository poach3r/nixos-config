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
