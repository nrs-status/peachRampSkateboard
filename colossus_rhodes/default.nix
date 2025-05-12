{ pkgslib, prelib }:
rec {
  areIdenticalUnorderedLists = import ./areIdenticalUnorderedLists.nix { inherit prelib; };
  typecheck = import ./typecheck.nix { inherit prelib pkgslib; };
  tc = type: target: typecheck { inherit pkgslib prelib; } { inherit type target; };
}
