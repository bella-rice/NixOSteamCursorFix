{ config, pkgs, ... }:

{
  programs.steam.package = pkgs.steam.override {
    extraProfile = ''
      export XCURSOR_PATH="$HOME/.local/share/Steam/cursor_themes''${XCURSOR_PATH:+:$XCURSOR_PATH}"
    '';
  };
  
  systemd.user.services.steam-cursor-fix = {
    description = "Fix Steam cursor themes on NixOS.";

    wantedBy = [ "default.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "steam-cursors-fix" ''
        set -euo pipefail
        shopt -s nullglob

        steam_path="$HOME/.local/share/Steam"

        if [ -d "$steam_path" ]; then
          mkdir -p "$steam_path/cursor_themes"

          for d in /run/current-system/sw/share/icons/*; do
              [ -d "$d/cursors" ] || continue
              [ -d "$steam_path/cursor_themes/$(basename "$d")" ] && continue
              cp -a "$d" "$steam_path/cursor_themes/"
          done
        fi
      ''}";
    };
  };
}
