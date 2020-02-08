{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    terminator
    fish
    fortune
    neovim
    psmisc
    jq
    fasd
    fzf
    blueman
    pavucontrol
    alacritty
    gitAndTools.diff-so-fancy
    ripgrep
    python
    firefox-devedition-bin
    playerctl
    mpv
    vlc
    youtube-dl
    tmux
  ];
}
