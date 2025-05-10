{total, substitutionAttrs, activateDebug ? false}:
with builtins;
let 
  isKeyToSubstitute = key: elem key (attrNames substitutionAttrs);
in (import ./withDebug.nix) activateDebug {
  debug = mapAttrs (key: val: 
    if isKeyToSubstitute key then
      substitutionAttrs.${key}
    else
      val) total;
  nondebug = total.final;
}
