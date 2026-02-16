{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.splashImage = ./cookie-grub-theme/background.png;
  boot.loader.grub.theme = ./cookie-grub-theme;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "i915.modeset=1" ];
   
  networking.hostName = "cookie";

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "ru_RU.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

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

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  programs.hyprland.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-vaapi-driver
    libva
  ];

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.libinput.enable = true;

  users.users.cookie = {
    isNormalUser = true;
    description = "Cookie";
    extraGroups = [ "networkmanager" "wheel" ];
    useDefaultShell = true;
  };
  users.defaultUserShell = pkgs.zsh;

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      # theme = "powerlevel10k/powerlevel10k";
    };
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };

  environment.systemPackages = with pkgs; [
    hyprland
    hyprlock
    brightnessctl
    networkmanager
    bluez
    stress-ng
    mpvpaper
    foot
    mako
    wofi
    wofi-emoji
    waybar
    neovim
    neovide
    python3
    gcc
    pkgs.llvmPackages_20.clang-unwrapped
    lua
    lua51Packages.lua
    luaPackages.luarocks
    kitty
    unzip
    wget
    git
    kdePackages.dolphin
    telegram-desktop
    kronosnet
    discord
    fastfetch
    nwg-look
    grim
    grimblast
    slurp
    wl-clipboard
  ];
  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    roboto
    roboto-serif
  ];

  fonts.fontconfig.defaultFonts = {
    serif = [ "Roboto Serif" ];
    sansSerif = [ "Roboto" ];
    monospace = [ "JetBrainsMono Nerd Font Mono" ];
    emoji = [ "NoTo Color Emoji" ];
  };

  system.stateVersion = "25.11";
}
