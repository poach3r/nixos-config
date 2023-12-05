{ inputs, config, pkgs, ... }:

{
  nix = {
    optimise.automatic = true;
    package = pkgs.nixFlakes;
    settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Local
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
    };
  };

  # DBus
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # User
  users.users.poacher = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "poacher";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };

  # Doas
  security = {
    doas.enable = false;
    sudo.enable = true;
    # doas.extraRules = [
      # { users = ["poacher"]; } 
      # { keepEnv = true; }
      # { persist = true; }
    # ];
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    git
    hyprland
    sddm
    libsForQt5.qt5.qtquickcontrols2   
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
    virt-manager
    polkit_gnome
    cryptsetup
  ];
  
  # Systemd 
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };

  # Networking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    jetbrains-mono
    nerdfonts
  ];

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    dconf.enable = true;
    zsh.enable = true;
  };

  # Misc Settings
  virtualisation.libvirtd.enable = true;

  system.stateVersion = "23.05";
} 
