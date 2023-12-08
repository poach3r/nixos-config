{ inputs, config, pkgs, ... }:

{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      efiSupport = true;
      enable = true;
      device = "/dev/sda";
    };
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    gamemode
    steam
  ];
  
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  programs = {
    gamemode.enable = true;
    steam.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  
  system.stateVersion = "23.05";
} 
