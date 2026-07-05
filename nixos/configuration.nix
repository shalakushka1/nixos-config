{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/bundle.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.pathsToLink = [
    "/lib/ladspa"
    "/share/nautilus-python/extensions"
  ];

  environment.sessionVariables = {
    LADSPA_PATH = "/run/current-system/sw/lib/ladspa";
  };

  time.timeZone = "America/Fortaleza";

  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
    LC_MESSAGES = "pt_BR.UTF-8";
  };

  services.xserver.xkb.layout = "br";

  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "alacritty.desktop" ];
  };

  programs.dconf.enable = true;

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "alacritty";
  };

  console.keyMap = "br-abnt2";

  environment.systemPackages = with pkgs; [
    git
    nautilus
    nautilus-python
    alacritty
    ladspaPlugins
    apple-cursor
    xdg-user-dirs
    xwayland-satellite
    adwaita-icon-theme
  ];

  environment.etc."xdg/user-dirs.defaults".text = ''
    DESKTOP=Área de Trabalho
    DOWNLOAD=Downloads
    TEMPLATES=Modelos
    PUBLICSHARE=Público
    DOCUMENTS=Documentos
    MUSIC=Músicas
    PICTURES=Imagens
    VIDEOS=Vídeos
  '';

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  system.stateVersion = "26.05";
}
