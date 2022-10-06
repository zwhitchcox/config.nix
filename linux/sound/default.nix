{ config, lib, pkgs, ... }:
{
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };
  environment.systemPackages = with pkgs; [
    #pavucontrol
    #helvum
    #carla
    #gnome.gnome-sound-recorder
    #xsynth_dssi
    #ladspaPlugins
    #AMB-plugins
    #nova-filters
    #caps
    #csa
    #autotalent
    #zam-plugins
    #tap-plugins
    #lsp-plugins
    #swh_lv2
    #mda_lv2
    #ams-lv2
    #rkrlv2
    #magnetophonDSP.pluginUtils
    #distrho
    #bshapr
    #bchoppr
    #magnetophonDSP.CharacterCompressor
    #tunefish
    #plujain-ramp
    #magnetophonDSP.RhythmDelay
    #mod-distortion
    #x42-plugins
    #infamousPlugins
    #mooSpace
    #noise-repellent
    #eq10q
    #magnetophonDSP.LazyLimiter
    #talentedhack
    #artyFX
    #speech-denoiser
    #fverb
    #fomp
    #molot-lite
    ## surge build fails currently
    #vocproc
    ##oxefmsynth
    ##magnetophonDSP.ConstantDetuneChorus build fails currently
    #magnetophonDSP.faustCompressors
    #magnetophonDSP.VoiceOfFaust
  ];
}
