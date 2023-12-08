{ pkgs, ... }:

pkgs.writeShellScriptBin "backup" ''
  theme=$1
  location=$(cat ~/.config/backups/backupLocations.txt | rofi -dmenu -matching fuzzy -normal-window -theme $theme -p "Backup Location")
  dir="$location/$(date +%m.%d.%Y)"
  mkdir $dir
  while read -r line
  do
    ${pkgs.libnotify}/bin/notify-send "Copying $line"
    cp -r $line $dir
  done < ~/.config/backups/backupSources.txt
  ${pkgs.libnotify}/bin/notify-send "Compressing $dir"
  tar czvf "$dir-archive.tar" $dir
  rm -rf $dir
  ${pkgs.libnotify}/bin/notify-send "Finished Compressing $dir"
''
