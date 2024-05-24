{ ... }:

{
  home.username = "jacob";
  home.homeDirectory = "/home/jacob";
  home.stateVersion = "24.05";
  programs.git = {
    enable = true;
    userName = "Jacob Ranson";
    userEmail = "code@jacobranson.dev";
    extraConfig.init.defaultBranch = "main";
  };
}
