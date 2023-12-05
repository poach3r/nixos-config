{ pkgs, ... }:

{
  home.packages = with pkgs; [
    passff-host
    librewolf-wayland
  ];

  home.file.".librewolf/native-messaging-hosts/passff.json".source = "${pkgs.passff-host}/share/passff-host/passff.json";
  
  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
    };
  };
}
