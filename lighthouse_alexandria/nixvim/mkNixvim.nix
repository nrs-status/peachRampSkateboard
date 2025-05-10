{ prelib, pkgslib, nixvimFlake, activateDebug ? false }:
{ lclInputs, system, pkgs, types }:
{symlinkJoinName, etc, keymaps, opts, filetype, pluginsList, extraPlugins, extraConfigLuaList, extraPackages}:
with builtins;
let total = rec {
  nixvimMaker = nixvimFlake.legacyPackages.${system}.makeNixvimWithModule;
  extraConfigLua = foldl' (acc: next: acc + readFile next) "" extraConfigLuaList;
  importMapping = map (path: import path { inherit lclInputs system types; }) pluginsList;
  plugins = foldl' (import ../deepMerge.nix) {} importMapping;
  argToNixvimMaker = {
    module = (import etc {}) // {
      opts = import opts { inherit lclInputs; };
      inherit filetype;
      keymaps = import keymaps {};
      inherit extraConfigLua;
      inherit extraPlugins;
      inherit plugins;
    };
  }; 
  final = pkgs.symlinkJoin {
    name = symlinkJoinName;
    paths = extraPackages ++ [ (total.nixvimMaker total.argToNixvimMaker)];
  };
};
in prelib.wrapDebug {
  inherit activateDebug total;
}

