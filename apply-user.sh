#!/bin/sh
pushd ~/.dotfiles
nix build .#homeManagerConfigurations.dez.activationPackage
./result/activate
popd
