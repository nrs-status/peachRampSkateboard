{ ... }:
{
  typeName = "NixFunction";
  preds = [
    (import ../../functionToPredicate.nix {
      predName = "isNixFunction";
      function = builtins.isFunction;
    })
  ];
}
