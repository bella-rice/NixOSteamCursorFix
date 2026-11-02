This Nix resolves the issue where Steam cannot locate cursor themes on NixOS (https://wiki.nixos.org/wiki/Steam#Tiny_mouse_cursor).

The fix mirrors the cursor themes from '/run/current-system/sw/share/icons' (the NixOS installation directory for cursor themes) to a location that Steam can reach. This approach avoids hardcoding the package path of the theme cursor.

This Nix is a work in progress in very early stages. Roadmap:
- Limit the search to the currently used cursor theme
- Avoid cloning symlinks that Steam can already access
- Add support for custom themes directories
- General code improvements
