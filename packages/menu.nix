{ pkgs, ... }:

pkgs.writeShellScriptBin "menu" ''
  activewindow=$(hyprctl activewindow)

  if [[ $activewindow == "Invalid" ]] then
    choice=$(echo " Run
 Manage
󰈹 Browse
󰎁 Watch
󰝚 Listen
󰙯 Chat
 Screenshot" | rofi -dmenu -normal-window -theme $1)
    if [[ $choice == " Run" ]] then
      alacritty
    elif [[ $choice == " Manage" ]] then
      thunar
    elif [[ $choice == "󰈹 Browse" ]] then
      firefox
    elif [[ $choice == "󰎁 Watch" || $choice == "󰝚 Listen" ]] then
      vlc
    elif [[ $choice == "󰙯 Chat" ]] then
      gtkcord4
    elif [[ $choice == " Screenshot" ]] then
      grim
    fi
  fi
''
