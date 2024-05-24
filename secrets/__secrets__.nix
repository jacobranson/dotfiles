let
  targetSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPkQZuJuo5yrV6YepDJlp9cQwukYLC0prR7fm+5s+7Jf root@nixos";
  sourceSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGjzIlLawfSp6zmmZZoPtKZoGbsPhxS7BPWsMWRtUblQ code@jacobranson.dev";
  allSystems = [ targetSystem sourceSystem ];
in {
  "systems/framework/luks.age".publicKeys = allSystems;
  "systems/framework/password.age".publicKeys = allSystems;
  "systems/framework/machine-id.age".publicKeys = allSystems;
  "systems/framework/ssh_host_ed25519_key.age".publicKeys = allSystems;
}
