{ pkgs ? import <nixpkgs> { } }:
let default = (import ./default.nix { }); in
pkgs.mkShell {
  buildInputs = default.buildInputs;
}
