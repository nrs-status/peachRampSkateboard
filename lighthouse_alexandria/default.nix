{ tclib, pkgslib, prelib, nixvimFlake }:
{
  preMkNixvim = import ./nixvim/mkNixvim.nix { inherit pkgslib prelib nixvimFlake; }; #still needs pkgs and system, which are passed directly at montezuma_circles_scroll;
  concatAttrSets = import ./concatAttrSets.nix;
  attrsSubtype = import ./attrsSubtype.nix;
  extendNixvimEnvAttrs1 = import ./nixvim/extendNixvimEnvAttrs1.nix;
  extendEnv = import ./extendEnv.nix { inherit prelib pkgslib; };
  mkLclPkgs = import ./mkLclPkgs.nix;
  shellOfEnv = import ./shellOfEnv.nix;
  deepMerge = import ./deepMerge.nix;
  mkMockHMOutputAndExtractFiles = import ./mkMockHMOutputAndExtractFiles.nix;
  mkHMOutput = import ./mkHMOutput.nix;
  mkOutput = import ./mkOutput.nix;
}

