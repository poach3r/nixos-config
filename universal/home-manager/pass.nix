{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnupg
    pinentry-curses
  ];

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: 
      [ 
	exts.pass-otp 
	exts.pass-audit
      ]
    );
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
  };
}
