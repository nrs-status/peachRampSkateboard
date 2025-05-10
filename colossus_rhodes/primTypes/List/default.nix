{ ... }:
type:
{
  typeName = "List ${type.typeName}";
  preds = [
    (import ../../mkListTypePredicate.nix type)
  ];
}
