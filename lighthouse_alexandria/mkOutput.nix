{ prelib, tclib }:
{ envsdir, lclpkgsdir, outputDeclAttrs, activateDebug ? false }:
with builtins;
with tclib;
with tclib.types;
let total = rec {

  nameValuePairBootstrap = name: value: { inherit name value; };
  genAttrsBootstrap = names: f: listToAttrs (map (n: nameValuePairBootstrap n (f n)) names);
  reader = form: form;

  mkSelectedEnvs = reader: reader.pkgslib.attrsets.genAttrs reader.envsToProvide (label: reader.envsAttrs.${label});
  mkSelectedPackages = reader: import ./mkSelectedPackages.nix {
    inherit lclpkgsdir reader prelib;
  };
  initReaderWith = funcToApply: declKey: declVal: genAttrsBootstrap declVal.supportedSystems (system: { ${declKey} = funcToApply (reader (rec {
    nixpkgs = declVal.nixpkgs;
    pkgs = import declVal.nixpkgs {
      inherit system;
      config = declVal.nixpkgsConfig;
    };
    pkgslib = pkgs.lib;
    lclInputs = tc Attrset (declVal.lclInputs pkgs);
    types =  tc Attrset (declVal.types lclInputs);
    inherit system;
    packagesToProvide = tc (List String) declVal.packagesToProvide;
    envsToProvide = tc (List String) declVal.envsToProvide;
    lclPkgs = tc Attrset (import ./mkLclPkgs.nix {
      inherit pkgslib pkgs prelib types lclpkgsdir lclInputs system;
    });
    envsAttrs = tc Attrset (import ./mkEnvsAttrs.nix {
      inherit lclPkgs prelib envsdir pkgslib pkgs lclInputs types;
    });
  })); });

  selectedPackagesAux = initReaderWith mkSelectedPackages; #is separate for easier debug
  selectedPackages = mapAttrs selectedPackagesAux outputDeclAttrs;

  selectedEnvsAux = initReaderWith mkSelectedEnvs; #is separate for easier debug
  selectedEnvs = mapAttrs selectedEnvsAux outputDeclAttrs;

  deepMerge = import ./deepMerge.nix;
  foldIntoPackagesVal = builtins.foldl' deepMerge {} (attrValues selectedPackages);
  foldIntoDevShellsVal = builtins.foldl' deepMerge {} (attrValues selectedEnvs);

  mkByproduct = reader: with reader; {
    inherit nixpkgs pkgs lclPkgs lclInputs types envsAttrs;
  };
  byproducts = mapAttrs (initReaderWith mkByproduct) outputDeclAttrs;
  clipFirstAttr = builtins.foldl' deepMerge {} (attrValues byproducts);

  final = {
    packages = foldIntoPackagesVal;
    devShells = foldIntoDevShellsVal;
    byproducts = clipFirstAttr;
  };
}; in prelib.wrapDebug {
  inherit total activateDebug;
}
