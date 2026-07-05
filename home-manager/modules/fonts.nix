{ pkgs, ... }: { 

  # 1. Instalar as fontes no perfil do usuário
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    inter
    nerd-fonts.jetbrains-mono
    adwaita-fonts
  ];

  # 2. Configurar o Fontconfig no Home Manager
  fonts.fontconfig = {
    enable = true; # Ativa a gestão de fontes para o usuário
    defaultFonts = {
      sansSerif = [ "Inter" ];
      monospace = [ "JetBrainsMono Nerd Font Propo" ];
    };
  };
}
