{ config, pkgs, ... }:

{
  imports = [./emacs.nix];
  services.xserver.windowManager.myExwm = {
    enable = true;
  };
}
