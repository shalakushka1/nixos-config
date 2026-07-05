{ config, ... }: {
 gtk = {
  enable = true;
  
  gtk3.bookmarks = [
    "file://${config.home.homeDirectory}/Documentos"
    "file://${config.home.homeDirectory}/Músicas"
    "file://${config.home.homeDirectory}/Imagens"
    "file://${config.home.homeDirectory}/Vídeos"
    "file://${config.home.homeDirectory}/Downloads"
  ];
 };
}
