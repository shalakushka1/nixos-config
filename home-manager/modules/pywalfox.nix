{ pkgs, lib, ...}: {
  home.activation = {
    installPywalfox = lib.hm.dag.entryAfter ["writeBoundary"] ''
      echo "Registrando o pywalfox-native no Firefox..."
      $DRY_RUN_CMD ${pkgs.pywalfox-native}/bin/pywalfox install || true
    '';
  };
}
