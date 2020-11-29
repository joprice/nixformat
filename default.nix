{ pkgs ? import <nixpkgs> { } }:
with pkgs;
ocamlPackages.buildDunePackage {
  pname = "nixformat";
  version = "0.0.1";
  buildInputs = [
    ocamlPackages.pprint
    ocamlPackages.menhir
  ];
  useDune2 = true;
  src = lib.cleanSource ./.;
}
