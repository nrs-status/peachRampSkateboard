{ pkgslib }:
{ total, targets, logPath, activateDebug ? false }:
with builtins;
import ./withDebug activateDebug {
  debug = let
    targettedAttributes = (import ./filterAttrsBootstrap.nix) (k: v: elem k targets) total.final;
    outputTargets = (import ./appendToFile.nix) {
      pathToFile = logPath;
      textToAppend = pkgslib.generators.toKeyValue targettedAttributes;
    };
    in seq outputTargets total.final;
  nondebug = total.final;
}
