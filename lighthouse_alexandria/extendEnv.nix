{ prelib, pkgslib }:
args@{ types, lclInputs, lclPkgs, target, pkgs, extension, activateDebug ? false }:
with lclInputs;
let total = rec {
  targetTotal = import target {
    inherit pkgs lclInputs lclPkgs;
    activateDebug = true;
  };
  readerFields = {
    packagesFromNixpkgs = targetTotal.packagesFromNixpkgs;
    packagesFromLocalRepo = targetTotal.packagesFromLocalRepo;
    shellHook = targetTotal.shellHook;
  };
  reader = import ./mkReader.nix { inherit pkgslib; } { inherit readerFields; };
  newEnvDecl = extension reader;
  packagesFromNixpkgs = newEnvDecl.packagesFromNixpkgs;
  packagesFromLocalRepo = newEnvDecl.packagesFromLocalRepo;
  shellHook = newEnvDecl.shellHook;
  final = pkgs.mkShell {
    packages = packagesFromNixpkgs ++ packagesFromLocalRepo;
    inherit shellHook;
  };
  debug = {
    inherit args;
  };
}; in prelib.wrapDebug {
  inherit total activateDebug;
}
