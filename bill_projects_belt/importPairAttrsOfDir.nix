{ pkgslib }:
{ filePathForRecursiveFileListing, inputsForImportPairs, activateDebug ? false }:
with builtins;
let total = rec {
  filesList = (import ./listDirsSatisfyingPred.nix { inherit pkgslib; }) {
    dir = filePathForRecursiveFileListing;
    pred = pkgslib.hasSuffix "default.nix";
  };
  mkImportPair = path: import ./mkImportPair.nix { inherit pkgslib; } { importInputs = inputsForImportPairs; filePath = path; };
  importPairList = map mkImportPair filesList;
  foldIntoAttrs = foldl' (acc: next: acc // { ${next.name} = next.value; }) {} importPairList;
  final = foldIntoAttrs;

}; in (import ./wrapDebug.nix) {
  inherit total activateDebug;
}
