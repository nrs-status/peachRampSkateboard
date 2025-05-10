{ prelib, pkgslib, activateDebug ? false }:
type: target:
let total = rec {
  typecheck = import ./typecheck.nix { inherit prelib pkgslib; };
  final = typecheck {
    inherit type target;
  };
}; in prelib.wrapDebug {
  inherit total activateDebug;
}
