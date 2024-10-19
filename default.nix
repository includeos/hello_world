{
  withCcache ? false, # Enable ccache support
  smp ? false, # Enable SMP support

  includeos ? import (builtins.fetchGit {
        url = "https://github.com/includeos/IncludeOS.git";
        ref = "v0.16.0-release"; # Currently using v0.16 pre-release branch
      }) { inherit smp; inherit withCcache; },
}:
let
  stdenv = includeos.stdenv;
in
stdenv.mkDerivation {
  name = "IncludeOS Hello world";
  version = "dev";

  src = ./src;

  inherit (includeos) nativeBuildInputs;

  buildInputs = [
    includeos
  ];

}
