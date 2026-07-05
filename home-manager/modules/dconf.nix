{ pkgs, ... }: {
  dconf.enable = true;
 
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":";
    };
  };
}
