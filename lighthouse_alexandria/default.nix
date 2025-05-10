{ tclib, pkgslib, prelib }: {
  concatAttrSets = import ./concatAttrSets.nix;
  attrsSubtype = import ./attrsSubtype.nix;
  extendEnv = import ./extendEnv.nix { inherit prelib pkgslib; };
  mkLclPkgs = import ./mkLclPkgs.nix;
  shellOfEnv = import ./shellOfEnv.nix;
  deepMerge = import ./deepMerge.nix;
  mkMockHMOutputAndExtractFiles = import ./mkMockHMOutputAndExtractFiles.nix;
  mkHMOutput = import ./mkHMOutput.nix;
  mkOutput = import ./mkOutput.nix { inherit prelib; };
  types = prelib.importPairAttrsOfDir {
    filePathForRecursiveFileListing = ./types;
    inputsForImportPairs = { inherit prelib pkgslib; };
  };
}

