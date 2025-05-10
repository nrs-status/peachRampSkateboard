{ pkgslib }:
{
  importPairAttrsOfDir = import ./importPairAttrsOfDir.nix { inherit pkgslib; };
  listDirsSatisfyingPred = import ./listDirsSatisfyingPred.nix { inherit pkgslib; };
  mkImportPair = import ./mkImportPair.nix { inherit pkgslib; };
  withDebug = import ./withDebug.nix;
  wrapDebug = import ./wrapDebug.nix;
  wrapSubstitutingDebug = import ./wrapSubstitutingDebug.nix;
  wrapOutputtingDebug = import ./wrapOutputtingDebug.nix { inherit pkgslib; };
}
