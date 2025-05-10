{ prelib, ... }: {
  typeName = "NixFunction";
  preds = [
    (import ../../functionToPredicate.nix { inherit prelib; } {
      predName = "isNixFunction";
      function = builtins.isFunction;
    })
  ];
}
