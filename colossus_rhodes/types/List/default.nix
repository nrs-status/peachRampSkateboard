{ pkgslib, prelib }:
type:
let
  allTrue = import ../../allElmsOfListAreTrue.nix;
  typechecksPred = import ../../typechecksPred.nix { inherit prelib pkgslib; };
  hasType = typechecksPred { inherit type; };
in {
  typeName = "List ${type.typeName}";
  spec = [
    {
      path = [ ];
      pred = import ../../predicates/isList;
    }
    {
      path = [ ];
      pred = {
        predName = "elements satisfy type: ${type.typeName}";
        func = list: allTrue (map (x: hasType.func x) list);
      };
    }
  ];
}
