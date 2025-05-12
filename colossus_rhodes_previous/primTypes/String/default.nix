{ prelib, ... }:
{
  typeName = "String";
  preds = [
    (import ../../functionToPredicate.nix { inherit prelib; } {
      predName = "isString";
      function = builtins.isString;
    })
  ];
}
