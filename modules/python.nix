{ pkgs, ... }:
with pkgs;
let
  my-python-packages = python3Packages: with python3Packages; [
    # for eaf
    pyqt5
    pyqtwebengine
    sip qrcode
    epc
    retry

    # eaf-filemanager
    lxml

    # eaf-system-monitor
    psutil

    # other
    pip
    qtawesome
    percol
  ];
  python-with-my-package = python3.withPackages my-python-packages;
in
{
  python-with-my-package
}
