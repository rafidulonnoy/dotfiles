{ config, pkgs, ... }:

{
  home.username = "wd";
  home.homeDirectory = "/home/wd";
  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = [
    pkgs.brave
    pkgs.kanata
  ];
  home.file = {
  };
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
