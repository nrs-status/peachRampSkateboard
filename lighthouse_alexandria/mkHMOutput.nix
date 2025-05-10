{ prelib, pkgs, stateVersion, mockHomeExtensions, homeManagerFlake, activateDebug ? false }:
with builtins; 
let total = rec {
  mockHomeConfig = {
    home = {
      username = "placeholder";
      homeDirectory = "/home/placerholder";
      inherit stateVersion;
    };
  };
  concatedExtensions = foldl' (import ./deepMerge.nix) {} mockHomeExtensions;
  homeManagerOutput = homeManagerFlake.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [ (mockHomeConfig // concatedExtensions) ];
  }; 
  final = homeManagerOutput;
}; in prelib.wrapDebug {
  inherit total activateDebug;
}
