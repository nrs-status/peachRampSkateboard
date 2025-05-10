{ pkgslib }:
{ dir, pred, activateDebug ? false }:
let total = rec {
  recursiveListing = pkgslib.filesystem.listFilesRecursive dir;
  keepElmsSatisfyingPred = builtins.filter pred recursiveListing;
  final = keepElmsSatisfyingPred;
}; in (import ./wrapDebug.nix) {
  inherit total activateDebug;
}
