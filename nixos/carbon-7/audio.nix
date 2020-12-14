{ pkgs, config, ... }:

{
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true; # Explicit PulseAudio support in applications
  environment.systemPackages = with pkgs; [
    pulsemixer
  ];
}
