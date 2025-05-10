{ prelib, pkgslib }:
{ typeName, fieldsAndTypesAttrs, activateDebug ? false }:
with builtins;
let
  total = rec {
    mkFieldHasTypePredicate =
      import ./mkFieldHasTypePredicate.nix { inherit pkgslib prelib; };
    mkHasExactFieldsPredicate =
      import ./mkHasExactFieldsPredicate.nix { inherit prelib pkgslib; };
    attrsMapping = mapAttrs (k: v:
      mkFieldHasTypePredicate {
        field = k;
        type = v;
      }) fieldsAndTypesAttrs;
    final = {
      inherit typeName;
      preds = [
        (attrValues attrsMapping)
        (mkHasExactFieldsPredicate { fields = attrNames attrsMapping; })
      ];
    };
  };
in prelib.wrapDebug { inherit total activateDebug; }
