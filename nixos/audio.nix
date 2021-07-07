{ pkgs, config, ... }:

{
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraConfig = "
      load-module module-switch-on-connect
    ";
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };
  nixpkgs.config.pulseaudio = true; # Explicit PulseAudio support in applications
  environment.systemPackages = with pkgs; [
    pulsemixer
  ];
}
