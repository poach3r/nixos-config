My (hopefully) final NixOS config, now with flakes!

![20231204_15h37m57s_grim](https://github.com/poach3r/nixos-config/assets/58641438/406553c9-d6d4-43d0-b0d3-d2bfdeff17eb)

# File Structure

nixos-config     | The base directory, I put it in my home directory
--universal      | Configs that apply both the desktop and laptop configs
--desktop        | Configs that only apply to the desktop config (ie Steam)
--laptop         | Configs that only apply to the laptop config (ie battery optimization)
--packages       | Various things not configured in home-manager/not in nixpkgs (ie shell scripts)
----nixos        | My NixOS config
----home-manager | My home-manager config

# TODO

* Change home-manager to a NixOS module
* General code cleanup
* A windows-like startmenu activated by pressing super
* Lockscreen

