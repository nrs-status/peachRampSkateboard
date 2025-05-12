{ prelib, ... }:
{
  typeName = "Attrset";
  preds = [
    (import ../../functionToPredicate.nix { inherit prelib; } {
      predName = "isAttrs";
      function = builtins.isAttrs;
    })
  ];
}
