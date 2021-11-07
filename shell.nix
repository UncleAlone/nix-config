# shell.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python39
    black
    #git
    #nodejs
    wget
  ];
  shellHook = ''
    echo "Welcome"
  '';
}
