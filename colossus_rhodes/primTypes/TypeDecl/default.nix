{ prelib, pkgslib }:
let
  mkHasExactFieldsPredicate =
    import ../../mkHasExactFieldsPredicate.nix { inherit prelib pkgslib; };
  mkFieldHasTypePredicate =
    import ../../mkFieldHasTypePredicate.nix { inherit prelib pkgslib; };
in {
  typeName = "TypeDecl";
  preds = [
    (mkHasExactFieldsPredicate { fields = [ "typeName" "preds" ]; })
    (mkFieldHasTypePredicate {
      field = "typeName";
      type = (import ../String { inherit prelib; });
    })
    # (mkFieldHasTypePredicate {
    #   field = "preds";
    #   type = (import ../List {}) (import ../NixFunction);
    # })
  ];
}
