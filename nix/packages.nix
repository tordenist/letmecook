{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    zsh
  ];
}