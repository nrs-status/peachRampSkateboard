
with builtins; rec {
  pkgs = import <nixpkgs> { system = "x86_64-linux"; };
  someAttrs = {
    a = [ 1 2 ];
    b = {
      c = [ 3 4 ];
      d = { e = [ ]; };
      f = {
        g = [ 5 ];
        h = [ 6 ];
      };
    };
  };
  pkgslib = pkgs.lib;
  prelib = import ../bill_projects_belt { inherit pkgslib; };
  areIdUnordLists = import ../colossus_rhodes_two/areIdenticalUnorderedLists.nix { inherit prelib; };
  recToKvPair = import ../colossus_rhodes_two/recToKvPair.nix { inherit pkgslib; };
  toPathVals = import ../colossus_rhodes_two/toPathVals.nix { inherit prelib; };
  isKvPairList = import ../colossus_rhodes_two/isKvPairList.nix { inherit prelib; };
  toNestedkvpairslist = recToKvPair someAttrs;
  fst = builtins.elemAt toNestedkvpairslist 1;
  snd = builtins.elemAt fst.value 1;
  trd = builtins.elemAt snd.value 0;
  result = toPathVals toNestedkvpairslist;
  fst' = builtins.elemAt result 1;
  snd' = builtins.elemAt result 2;
}
