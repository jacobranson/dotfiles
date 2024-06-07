let
  targetSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPkQZuJuo5yrV6YepDJlp9cQwukYLC0prR7fm+5s+7Jf root@nixos";
  sourceSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGjzIlLawfSp6zmmZZoPtKZoGbsPhxS7BPWsMWRtUblQ code@jacobranson.dev";
  allSystems = [ targetSystem sourceSystem ];
in {
  "systems/x86_64-linux/framework-16-7040-amd/secrets/luks.age".publicKeys = allSystems;
  "systems/x86_64-linux/framework-16-7040-amd/secrets/password.age".publicKeys = allSystems;
  "systems/x86_64-linux/framework-16-7040-amd/secrets/machine-id.age".publicKeys = allSystems;
  "systems/x86_64-linux/framework-16-7040-amd/secrets/ssh_host_ed25519_key.age".publicKeys = allSystems;
}
