{ pkgs, inputs, system, ... }:

pkgs.mkShell {
  shellHook = ''
    export EDITOR=hx

    agenix() {
      command agenix --rules ./secrets.nix "$@"
    }

    decrypt() {
      agenix --editor cat --edit "$1" | grep -v "wasn't changed"
    }

    sysdecrypt() {
      decrypt "systems/$arch/$hostname/secrets/$1.age"
    }

    install-nixos() {
      temp=$(mktemp -d)
      cleanup() {
        rm -rf "$temp"
      }
      trap cleanup EXIT

      ssh="$temp/persist/etc/ssh"
      mkdir -p "$ssh" && chmod 755 "$ssh"
      sysdecrypt ssh_host_ed25519_key > "$ssh/ssh_host_ed25519_key"
      chmod 600 "$ssh/ssh_host_ed25519_key"
      ssh-keygen -f "$ssh/ssh_host_ed25519_key" -y > "$ssh/ssh_host_ed25519_key.pub"
      chmod 644 "$ssh/ssh_host_ed25519_key.pub"

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
