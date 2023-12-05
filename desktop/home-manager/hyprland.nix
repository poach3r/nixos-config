{ inputs, pkgs, ... }:

let
wallpapers = pkgs.stdenv.mkDerivation {
    name = "wallpapers";
    src = pkgs.fetchgit {
      url = "https://github.com/Gingeh/wallpapers";
      sparseCheckout = [
	"landscapes/"
      ];
      hash = "sha256-7Odz2khtWFXI60vHGP/3A5BmvazPO3yvQbML+IHRgSQ=";
    };
    installPhase = ''
    mkdir -p $out
    mv * $out
    '';
  };

  rofi = pkgs.stdenv.mkDerivation {
    name = "rofi";
    src = pkgs.fetchgit {
      url = "https://github.com/catppuccin/rofi";
      sparseCheckout = [
	"basic/.local/"
      ];
      hash = "sha256-VoBVygZSSiqqtdO1WzCzA6lfE2Nl2yCFCpLjTo0QhxY=";
    };
    installPhase = ''
    mkdir -p $out
    mv ./basic/.local/share/rofi/themes/* $out
    '';
  };
in {
  home.packages = with pkgs; [
    wbg
    brightnessctl
    wl-clipboard
    grim
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''
    monitor=DP-1, 1920x1080@144, 0x0, 1

    # Autostart
    exec systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec = eww open bar
    exec = wbg ${wallpapers}/landscapes/evening-sky.png

    # Input config
    input {
      kb_layout = us
      follow_mouse = 1
      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      follow_mouse = 1
      touchpad {
	natural_scroll = false
      }
    }

     general {
       gaps_in = 4
       gaps_out = 8
       border_size = 0
       # col.active_border=0xfff2f4f8
       # col.inactive_border=0xffdde1e6
       layout = dwindle
     }

     xwayland {
       force_zero_scaling = true;
     }

     decoration {
       rounding = 8
       drop_shadow = true
     }

     animations {
       enabled = yes
       bezier = ease,0.4,0.02,0.21,1
       animation = windows, 1, 3.5, ease, popin
       animation = windowsOut, 1, 3.5, ease, popin
       animation = border, 1, 6, default
       animation = windows, 1, 3, ease, popin
       animation = workspaces, 1, 3.5, ease
     }

     dwindle {
       pseudotile = yes
       preserve_split = yes
     }

     master {
       new_is_master = yes
     }

     gestures {
       workspace_swipe = false
     }

     misc {
       vfr = true
     }
    
     $mainMod = ALT
     bind = $mainMod, F, fullscreen
     bind = $mainMod, RETURN, exec, alacritty
     bind = $mainMod, Q, killactive,
     bind = $mainMod, SPACE, togglefloating,
     bind = $mainMod, P, exec, hyprpicker -a
     bind = ,PRINT, exec, grim ~/Pictures/$(date +'%s_grim.png')
     bind = $mainMod, D, exec, rofi -no-config -no-lazy-grab -show drun -modi drun -theme ${rofi}/catppuccin-macchiato.rasi
     bind = $mainMod, B, exec, createConfig; backup ${rofi}/catppuccin-macchiato.rasi
     bind = ,XF86AudioMicMute,exec,pamixer --default-source -t
     bind = ,XF86MonBrightnessDown,exec,brightnessctl set 4%-
     bind = ,XF86MonBrightnessUp,exec,brightnessctl set 4%+
     bind = ,XF86AudioMute,exec,pamixer -t
     bind = ,XF86AudioLowerVolume,exec,pamixer -d 5
     bind = ,XF86AudioRaiseVolume,exec,pamixer -i 5
     bind = $mainMod,Tab,cyclenext,
     bind = $mainMod,Tab,bringactivetotop,
     bind = $mainMod, left, movefocus, l
     bind = $mainMod, right, movefocus, r
     bind = $mainMod, up, movefocus, u
     bind = $mainMod, down, movefocus, d
     bind = $mainMod, 1, workspace, 1
     bind = $mainMod, 2, workspace, 2
     bind = $mainMod, 3, workspace, 3
     bind = $mainMod, 4, workspace, 4
     bind = $mainMod, 5, workspace, 5
     bind = $mainMod, 6, workspace, 6
     bind = $mainMod, 7, workspace, 7
     bind = $mainMod, 8, workspace, 8
     bind = $mainMod, 9, workspace, 9
     bind = $mainMod, 0, workspace, 10
     bind = $mainMod SHIFT, 1, movetoworkspace, 1
     bind = $mainMod SHIFT, 2, movetoworkspace, 2
     bind = $mainMod SHIFT, 3, movetoworkspace, 3
     bind = $mainMod SHIFT, 4, movetoworkspace, 4
     bind = $mainMod SHIFT, 5, movetoworkspace, 5
     bind = $mainMod SHIFT, 6, movetoworkspace, 6
     bind = $mainMod SHIFT, 7, movetoworkspace, 7
     bind = $mainMod SHIFT, 8, movetoworkspace, 8
     bind = $mainMod SHIFT, 9, movetoworkspace, 9
     bind = $mainMod SHIFT, 0, movetoworkspace, 10
     bind = $mainMod, mouse_down, workspace, e+1
     bind = $mainMod, mouse_up, workspace, e-1
     bindm = $mainMod, mouse:272, movewindow
     bindm = $mainMod, mouse:273, resizewindow
     '';
   };
 }
