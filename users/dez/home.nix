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
    cmake
    gcc
    gnumake

    sbcl
    racket
    ghc
    rustc
    
    wmctrl
    glib
    nyxt
    
    feh
    unzip
    p7zip
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
	      { name = "marlonrichert/zsh-autocomplete"; }
	      { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
    initExtra = ''
     . $HOME/.p10k.zsh
     eval "$(jump shell)"
     eval "$(direnv hook zsh)"
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.aria2 = {
    enable = true;
    settings = {
      dir = "/home/share";
      max-connection-per-server = 5;
      save-session-interval = 60;
      enable-rpc = true;
      rpc-allow-origin-all = true;
      rpc-listen-all = true;
    };
  };
}
