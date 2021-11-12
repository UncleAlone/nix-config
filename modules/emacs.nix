{ config, lib, pkgs, ...}:

with lib;

let

  cfg = config.services.xserver.windowManager.myExwm;
  loadScript = pkgs.writeText "emacs-exwm-load" ''
    ${cfg.loadScript}
    ${optionalString cfg.enableDefaultConfig ''
      (require 'exwm-config)
      (exwm-config-default)
    ''}
  '';

  myEmacs = pkgs.emacsWithPackagesFromUsePackage {
    config = ../demacs-nixos.org;
    package = pkgs.emacsGcc;
    alwaysEnsure = true;
    alwaysTangle = true;

    extraEmacsPackages = epkgs: [
      epkgs.exwm
    ];
  };

in {

 # programs.emacs = {
 #   enable = true;
 #   package = myEmacs;
 # };

  options = {
    services.xserver.windowManager.myExwm = {
      enable = mkEnableOption "exwm";
      loadScript = mkOption {
        default = "(require 'exwm)";
        type = types.lines;
        example = ''
          (require 'exwm)
          (exwm-enable)
        '';
        description = ''
          Emacs lisp code to be run after loading the user's init
          file. If enableDefaultConfig is true, this will be run
          before loading the default config.
        '';
      };
      enableDefaultConfig = mkOption {
        default = true;
        type = lib.types.bool;
        description = "Enable an uncustomised exwm configuration.";
      };
      extraPackages = mkOption {
        type = types.functionTo (types.listOf types.package);
        default = epkgs: [];
        defaultText = literalExpression "epkgs: []";
        example = literalExpression ''
          epkgs: [
            epkgs.emms
            epkgs.magit
            epkgs.proofgeneral
          ]
        '';
        description = ''
          Extra packages available to Emacs. The value must be a
          function which receives the attrset defined in
          <varname>emacs.pkgs</varname> as the sole argument.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver.windowManager.session = singleton {
      name = "emacsWM";
      start = ''
        ${myEmacs}/bin/emacs -l ${loadScript}
      '';
    };
    environment.systemPackages = [ myEmacs ];
  };

}
