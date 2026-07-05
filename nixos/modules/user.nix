  { pkgs, ... }: {

  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    
    users."breno" = {
    isNormalUser = true;
    description = "Breno Farias";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
 };
}
