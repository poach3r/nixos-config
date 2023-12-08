{ inputs, pkgs, ... }:

{
  programs.ags = {
    enable = true;
    
    # null or path, leave as null if you don't want hm to manage the config
    configDir = ../../packages/ags;

    # packages to add to gjs's runtime
    extraPackages = [ pkgs.libsoup_3 ];
  };
}
