{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
   ];

boot.loader.grub = {
  enable = true;
  device = "nodev";
  efiSupport = true;
  useOSProber = true;
  timeout = 5;
};
    boot.loader.efi.canTouchEfiVariables = false;
    boot.loader.grub.efiInstallAsRemovable = true;
    boot.loader.systemd-boot.enable = false;

    networking.hostName = "nixos-btw";
    
    networking.networkmanager.enable = true;
    networking.firewall.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

 services.xserver.xkb = {
    layout = "us";
    variant = "";
};

services.xserver = {
  enable = true;
windowManager.oxwm.enable = true;
windowManager.windowmaker.enable = true;
};

xdg.portal = {
  enable = true;
  config.common.default = "*";
  extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];
};

programs.dconf.enable = true;
services.udisks2.enable = true;
services.gvfs.enable = true; #this for da pcmanfm or thunar dependency and shit 
security.polkit.enable = true;
services.displayManager.ly.enable = true;
services.picom = {
  enable = true;
  vSync = true;
  backend = "glx";
  };


  services.printing.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  users.users.elliot = {
    isNormalUser = true;
    description = "elliot";
    extraGroups = [ "networkmanager" "plugdev" "wheel" "libvirtd" ];
  };

  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
  };

hardware.bluetooth = {
  enable = false;
  powerOnBoot = false;
};

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  security.wrappers.spice-client-glib-usb-acl-helper = {
  source = "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";
  owner = "root";
  group = "root";
  setuid = true;
};

  hardware.graphics = {
  enable = true;
  enable32Bit = true;
  };

 nixpkgs.config.allowUnfree = false;

fonts = {
packages = with pkgs; [
  nerd-fonts.jetbrains-mono
  maple-mono.NF
  ];
  fontconfig.defaultFonts = {
  monospace = [ "Maple Mono NF" ];
  };
  };

programs.starship.enable = true;
programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    libreoffice
    librewolf
    freecad
    openscad
    fastfetch
    tmux
    xbindkeys
    conky
    cmatrix
    xdotool
    dmenu
    htop
    yazi
    neovim
    vlc
    pcmanfm 
    curl
    ghostty
    udiskie
    git
    nixd
    qutebrowser
    maim
    localsend
    feh 
    spice-gtk #4 virtmachinery
    unzip #4 nvim config
    nodejs #4 nvim config
    clang-tools 
    lua-language-server
    gcc
  ];

  system.stateVersion = "25.11";
}
