args@{ pkgslib, prelib, pkgs, types, lclpkgsdir, lclInputs, system, activateDebug ? false }:
let total = rec {
  inherit args;
  filteredFilePaths = prelib.importPairAttrsOfDir {
   filePathForRecursiveFileListing = lclpkgsdir;
   inputsForImportPairs = {
     inherit lclInputs system types pkgs;
   };
 };
final = filteredFilePaths;
}; in lclInputs.prelib.wrapDebug {
  inherit total activateDebug;
}
