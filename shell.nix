{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc
    gnumake
    erlangR26
    elixir_1_15
    nodejs_20
    inotify-tools
  ];
  shellHook = ''
    export NODE_OPTIONS="--openssl-legacy-provider"
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
  '';
}

