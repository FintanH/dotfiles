{ pkgs, config, ... }:

{
  fonts = {
    fonts = with pkgs; [
      inconsolata
      powerline-fonts
    ];
  };
}
