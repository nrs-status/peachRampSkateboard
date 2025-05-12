{ ... }:
{
  typeName = "NixFunction";
  spec = [
    {
      path = [];
      pred = import ../../predicates/isNixFunction {};
    }
  ];
}
