{ config, inputs, ... }:

let
  disk = "nvme0n1";
  espSize = "512M";
  swapSize = "32G";
in {
  disko.devices = {
    disk = {
      "${disk}" = {
        type = "disk";
        device = "/dev/${disk}";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "${espSize}";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            swap = {
              size = "${swapSize}";
              content = {
                type = "swap";
                randomEncryption = true;
                priority = 100;
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions.canmount = "off";
        postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot/encrypted/@blank$' || zfs snapshot zroot/encrypted/@blank";
        datasets = {

          # --- Encrypted Root Dataset ---

          "encrypted" = {
            type = "zfs_fs";
            options.mountpoint = "none";
          };
          "encrypted/" = {
            type = "zfs_fs";
            mountpoint = "/";
          };

          # --- Necessary System State ---
          # (ref: https://nixos.org/manual/nixos/stable/#ch-system-state)

          "encrypted/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          "encrypted/var/lib/nixos" = {
            type = "zfs_fs";
            mountpoint = "/var/lib/nixos";
          };
          "encrypted/var/lib/systemd" = {
            type = "zfs_fs";
            mountpoint = "/var/lib/systemd";
          };
          "encrypted/var/log/journal" = {
            type = "zfs_fs";
            mountpoint = "/var/log/journal";
          };
          "encrypted/etc/zfs" = {
            type = "zfs_fs";
            mountpoint = "/etc/zfs";
          };
          "encrypted/etc/secureboot" = {
            type = "zfs_fs";
            mountpoint = "/etc/secureboot";
          };

          # --- Optional System State ---

          # Fingerprint Sensor
          "encrypted/var/lib/fprint" = {
            type = "zfs_fs";
            mountpoint = "/var/lib/fprint";
          };

          # Wifi Connections
          "encrypted/etc/NetworkManager" = {
            type = "zfs_fs";
            mountpoint = "/etc/NetworkManager";
          };

          # Bluetooth Connections
          "encrypted/var/lib/bluetooth" = {
            type = "zfs_fs";
            mountpoint = "/var/lib/bluetooth";
          };

          # SSH Connections
          "encrypted/etc/ssh" = {
            type = "zfs_fs";
            mountpoint = "/etc/ssh";
          };
          "encrypted/home/jacob/.ssh" = {
            type = "zfs_fs";
            mountpoint = "/home/jacob/.ssh";
            # postCreateHook = "chmod 0700 /home/jacob/.ssh";
          };

          # XDG User Directories
          "encrypted/home/jacob/Desktop" = {
            type = "zfs_fs";
            mountpoint = "/home/jacob/Desktop";
          };
          "encrypted/home/jacob/Documents" = {
            type = "zfs_fs";
            mountpoint = "/home/jacob/Documents";
          };
          "encrypted/home/jacob/Downloads" = {
            type = "zfs_fs";
            mountpoint = "/home/jacob/Downloads";
          };
          "encrypted/home/jacob/Music" = {
            type = "zfs_fs";
            mountpoint = "/home/jacob/Music";
          };
          "encrypted/home/jacob/Pictures" = {
            type = "zfs_fs";
            mountpoint = "/home/jacob/Pictures";
          };
          "encrypted/home/jacob/Public" = {
            type = "zfs_fs";
            mountpoint = "/home/jacob/Public";
          };
          "encrypted/home/jacob/Templates" = {
            type = "zfs_fs";
            mountpoint = "/home/jacob/Templates";
          };
          "encrypted/home/jacob/Videos" = {
            type = "zfs_fs";
            mountpoint = "/home/jacob/Videos";
          };
        };
      };
    };
  };

  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.services.rollback = {
    description = "Rollback ZFS datasets to a pristine state";
    wantedBy = [ "initrd.target" ]; 
    after = [ "zfs-import-zroot.service" ];
    before = [ "sysroot.mount" ];
    path = with pkgs; [ zfs ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      zfs rollback -r zroot/encrypted/@blank && echo "rollback complete"
    '';
  };
}
