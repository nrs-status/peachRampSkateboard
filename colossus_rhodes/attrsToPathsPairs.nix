{ pkgslib, prelib }:
target:
let
  recToKvPairs = import ./recToKvPair.nix { inherit pkgslib; };
  toPathVals = import ./toPathVals.nix { inherit prelib; };
in toPathVals (recToKvPairs target)
