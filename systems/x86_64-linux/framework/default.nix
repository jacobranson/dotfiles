{ config, inputs, pkgs, system, lib, ... }:

let
  user = "jacob";
  hostname = "framework";
  layout = "us";
  locale = "en_US.UTF-8";
  timezone = "America/New_York";
  ssh-keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGjzIlLawfSp6zmmZZoPtKZoGbsPhxS7BPWsMWRtUblQ code@jacobranson.dev"
  ];
in {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ./hardware-configuration.nix
    ./disk-configuration.nix
  ];

  # linux kernel version to use
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.lanzaboote = {
    enable = false;
    pkiBundle = "/etc/secureboot";
  };
  
  # hides boot logs behind a loading screen
  boot.plymouth.enable = true;
  boot.plymouth.extraConfig = "DeviceScale=2";
  
  # hacky way to make the system boot without showing logs.
  # can be overridden by pressing "Escape".
  boot.kernelParams = [ "quiet" ];
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;

  # hide the nixos generation boot selection menu by default.
  # can be overridden by holding "Space".
  boot.loader.timeout = 0;
  
  # allows for firmware updates
  services.fwupd.enable = true;

  # ensure the system can connect to the internet
  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  
  # assign the machine id
  environment.etc.machine-id.source = "/persist/etc/machine-id";

  # ensure the system can be accessed remotely via ssh
  services.openssh = {
    enable = true;
    
    # ragenix uses this to determine which ssh keys to use for decryption
    hostKeys = [{
      path = "/persist/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }];
  };

  # enable the GNOME desktop environment
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  # configure the keyboard layout
  services.xserver.xkb.layout = layout;

  # set the locale and timezone
  i18n.defaultLocale = locale;
  time.timeZone = timezone;

  # skip the login screen and automatically login as the primary user
  # services.displayManager.autoLogin.user = user;
  # workaround for login crash, see https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-2094933256 (doesn't work)

  # dconf
  programs.dconf.enable = true;
  
  # hidpi
  programs.dconf.profiles.gdm.databases = [{
    settings."org/gnome/desktop/interface".scaling-factor = lib.gvariant.mkUint32 2;
  }];
  
  # remove NixOS manual
  documentation.nixos.enable = false;
  
  # remove xterm
  services.xserver.excludePackages = [ pkgs.xterm ];
  
  # remove GNOME Tour
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
  
  # set GNOME Web as default browser
  xdg.mime.defaultApplications = {
    "text/html" = "org.gnome.Epiphany.desktop";
    "x-scheme-handler/http" = "org.gnome.Epiphany.desktop";
    "x-scheme-handler/https" = "org.gnome.Epiphany.desktop";
    "x-scheme-handler/about" = "org.gnome.Epiphany.desktop";
    "x-scheme-handler/unknown" = "org.gnome.Epiphany.desktop";
  };

  # enable audio via pipewire
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # configure standard fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk
    ];
  };

  # add additional system packages to install
  environment.systemPackages = with pkgs; [
    sbctl # For debugging and troubleshooting Secure Boot.
    gh devbox
  ];

  # secrets for this machine
  age.secrets = {
    password.file = ./secrets/password.age;
  };

  # configure the users of this system
  users.mutableUsers = false;
  users.users.root.hashedPasswordFile = config.age.secrets.password.path;
  users.users."${user}" = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.password.path;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = ssh-keys;
  };
  
  # fingerprint reader support
  # sudo fprintd-enroll $USER

  # configure persistent files via impermanence
  fileSystems."/persist".neededForBoot = true;
  boot.initrd.services.lvm.enable = true;
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.services.rollback = {
    description = "Rollback BTRFS root subvolume to a pristine state";
    wantedBy = [
      "initrd.target"
    ];
    after = [
      # LUKS/TPM process
      "systemd-cryptsetup@enc.service"
    ];
    before = [
      "sysroot.mount"
    ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir /btrfs_tmp
      mount /dev/root_vg/root /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
    '';
  };

  environment.persistence.persist.persistentStoragePath = "/persist";
  environment.persistence.persist.hideMounts = true;
  environment.persistence.persist = {
    directories = [
      # required by NixOS
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/var/log/journal"
      
      # Secure Boot
      "/etc/secureboot"
      
      # Fingerprint Sensor
      "/var/lib/fprint"
      
      # WiFi
      "/etc/NetworkManager/system-connections"
      
      # Bluetooth
      "/var/lib/bluetooth"
    ];
    users."${user}" = {
      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Projects"
        "Public"
        "Templates"
        "Videos"
        { directory = ".ssh"; mode = "0700"; }
        ".local/share/keyrings"
        ".config/dotfiles"
        ".config/gh"
      ];
      files = [
        ".bash_history"
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
