{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    multimc
    logmein-hamachi
  ];
}
