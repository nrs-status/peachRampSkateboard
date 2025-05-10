{ prelib, pkgs, env, activateDebug ? false }:
let total = rec {
  final = pkgs.mkShell {
    packages = env.packagesFromNixpkgs ++ env.packagesFromLocalRepo;
    shellHook = ''export name=${env.name}
    ${env.shellHook}
    '';
  };
}; in prelib.wrapDebug {
  inherit total activateDebug;
}
