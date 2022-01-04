{ config, pkgs, ... }:
{
  services.samba = {
  enable = true;
  # securityType = "user";
  extraConfig = ''
    workgroup = WORKGROUP
    server string = Samba Server Version %v
  '';
  shares = {
    public = {
      path = "/home/dez/share/public";
      browseable = "yes";
      "public" = "yes";
      "read only" = "no";
      "guest ok" = "yes";
    };
    private = {
      path = "/home/dez/share/private";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "username";
      "force group" = "groupname";
    };
  };
  };
}
