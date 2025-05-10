{ pkgs, prelib, types, pkgslib, envsdir, lclInputs, lclPkgs }:
prelib.importPairAttrsOfDir {
    filePathForRecursiveFileListing = envsdir;
    inputsForImportPairs = {
      inherit types lclInputs lclPkgs pkgs;
    };
}


