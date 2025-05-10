{ prelib, pkgslib }:
{ readerFields, activateDebug ? false }:
let total = rec {
  mkExtendables = import ./mkExtendablesForReader.nix { inherit pkgslib; };
  mkExtendablesWith = import ./mkExtendablesForReaderWith.nix { inherit pkgslib; };
  final = readerFields // {
    extend = mkExtendables { inherit readerFields; };
    concat = mkExtendablesWith {
      inherit readerFields;
      extensionFunc = x: y: x ++ y;
    };
  };
}; in prelib.wrapDebug {
  inherit total activateDebug;
}
