{ config, pkgs, zen-browser, ... }:

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

services.xserver = {
  enable = true;
windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      i3status
      dmenu
   ];
  };
};
services.displayManager.defaultSession = "none+i3";

programs.mango.enable = true;

xdg.portal = {
  enable = true;
  extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
  ];
};
programs.dconf.enable = true;
services.gnome.gnome-keyring.enable = true;
services.udisks2.enable = true;
services.gvfs.enable = true;
security.polkit.enable = true;
services.displayManager.ly.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
};
  services.printing.enable = true;

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

  programs.firefox.enable = true;

  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
  };

hardware.bluetooth = {
  enable = true;
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


services.picom = {
  enable = true;
  vSync = true;
  backend = "glx";
  };

  hardware.graphics = {
  enable = true;
  enable32Bit = true;
  };

  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;
  fonts.packages = with pkgs; [
  nerd-fonts.jetbrains-mono
  ];
  environment.systemPackages = with pkgs; [
  zen-browser.packages."${pkgs.system}".default
tmux

neovim
  vlc
  curl
  vim
  udiskie
  networkmanagerapplet
    easyeffects
    git
    nautilus
    fastfetch
    kitty
    nixd
    qutebrowser
    rofi
    maim
    localsend
    feh #i3 wpp
    obs-studio
    fastfetch
    prismlauncher
    spice-gtk #4 virtmachinery
    brave
    lmms
    piper #4 g502
    libratbag #4 g502 
    joplin-desktop #note taking
#4 nvim config
    unzip #4 nvim config
    nodejs #4 nvim config
    clang-tools 
    lua-language-server
    gcc
  ];

  system.stateVersion = "25.11"; # Did you read the comment?

}
