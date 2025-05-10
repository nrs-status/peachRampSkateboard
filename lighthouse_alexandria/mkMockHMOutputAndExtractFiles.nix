{ prelib, pkgs, stateVersion, homeManagerFlake, attrsOfPathsStartingAtPlaceholderHome, mockHomeExtensions, activateDebug ? false, ... }:
#I don't understand how what's at the index given by elemAtArg is determined
with builtins;
let total = rec {
  homeManagerOutput = import ./mkHMOutput.nix {
    inherit mockHomeExtensions prelib homeManagerFlake stateVersion pkgs;
  };
  transformPathsIntoStringsToFetchFiles = mapAttrs (key: val: ".config" + (toString val)) attrsOfPathsStartingAtPlaceholderHome;
  grabMatchingTarget = targetToMatch: acc: next: if next.target == targetToMatch then next else acc;
  toFetchers = mapAttrs (_key: val: grabMatchingTarget val) transformPathsIntoStringsToFetchFiles;
  mockHomeConfigFilesInternalAttrs = attrValues (homeManagerOutput.config.home.file); #need to use attrValues because the keys are paths and nix won't accpet a string to acces them
  handler = result: if result == {} then throw ("mkMockHMOutputAndExtractFiles.nix: unallowed empty set while fetching files") else result;
  withFetched = mapAttrs (_key: val: handler (foldl' val {} mockHomeConfigFilesInternalAttrs)) toFetchers;
  withFileContents = mapAttrs (_key: val: readFile val.source) withFetched;
  final = withFileContents;
}; in prelib.wrapDebug {
  inherit total activateDebug;
}
