{ config, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "dez";
  # home.homeDirectory = "/home/dez";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "21.11";

  home.enableNixpkgsReleaseCheck = false;   

  home.packages = with pkgs; [
    exa
    direnv
    jump

    kitty
    alacritty

    nodejs
    nodePackages.npm
    
    rnix-lsp
    clang-tools
    ccls

    sbcl
    racket
    ghc
    rustc
    
    wmctrl
    glib

    python38Full
    # for eaf
    python38Packages.pyqt5
    python38Packages.pyqtwebengine
    python38Packages.sip
    python38Packages.qrcode
    python38Packages.epc
    python38Packages.retry

    # eaf-filemanager
    python38Packages.lxml

    # eaf-system-monitor
    python38Packages.psutil

    # other
    python38Packages.pip
    python38Packages.qtawesome
    python38Packages.percol

    nyxt
  ];

  programs.git = {
    enable = true;
    userName  = "UncleAlone";
    userEmail = "desmond.pc.w@gmail.com";
    delta = {
      enable = true;
      options = {
        features = "decorations";

        interactive = {
          keep-plus-minus-markers = false;
        };

        decorations = {
          commit-decoration-style = "blue ol";
          commit-style = "raw";
          file-style = "omit";
          hunk-header-decoration-style = "blue box";
          hunk-header-file-style = "red";
          hunk-header-line-number-style = "#067a00";
          hunk-header-style = "file line-number syntax";
        };
      };
    };
  };

  programs.bat.enable = true;
  programs.bat.config = {
    theme = "ansi";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "exa";
      la = "exa -la";
      lt = "exa -laT";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
	      { name = "zsh-users/zsh-syntax-highlighting"; }
	      { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
    initExtra = ''
     . $HOME/.p10k.zsh
     eval "$(jump shell)"
     eval "$(direnv hook zsh)"
    '';
  };

}
