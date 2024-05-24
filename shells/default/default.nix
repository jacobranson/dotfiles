{ pkgs, inputs, system, ... }:

pkgs.mkShell {
  shellHook = ''
    export EDITOR=hx

    agenix() {
      command agenix --rules secrets/__secrets__.nix "$@"
    }

    decrypt() {
      agenix --editor cat --edit "$1" | grep -v "wasn't changed"
    }

    sysdecrypt() {
      decrypt "secrets/systems/$hostname/$1.age"
    }

    install-nixos() {
      temp=$(mktemp -d)
      cleanup() {
        rm -rf "$temp"
      }
      trap cleanup EXIT

      etc="$temp/persist/etc"
      ssh="$etc/ssh"

      mkdir -p "$ssh" && chmod 755 "$ssh"
      sysdecrypt ssh_host_ed25519_key > "$ssh/ssh_host_ed25519_key"
      chmod 600 "$ssh/ssh_host_ed25519_key"

      sysdecrypt machine-id > "$etc/machine-id"
      chmod 644 "$etc/machine-id"

      command nixos-anywhere "root@$ip" \
        --flake ".#$hostname" \
        --build-on-remote -L \
        --extra-files "$temp" \
        --disk-encryption-keys /tmp/luks.key <(sysdecrypt luks)
    }
  '';

  packages = with pkgs; [
    coreutils git gh openssh openssl
    rsync helix nil nixos-anywhere
    inputs.agenix.packages.${system}.default
  ];
}