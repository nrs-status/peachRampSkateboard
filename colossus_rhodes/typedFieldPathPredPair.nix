{ prelib, pkgslib }:
field: type:
let 
typechecksPred = import ./typechecksPred.nix { inherit prelib pkgslib; };
in
{
  path = [field];
  pred = typechecksPred { inherit type; };
}
