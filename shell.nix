{
  # Enable ccache support. See overlay.nix for details.
  withCcache ? false,

  # Enable multicore suport.
  smp ? false,

  # vmrunner path, for vmrunner development
  vmrunner ? "",

  includeos ? import (builtins.fetchGit {
        url = "https://github.com/includeos/IncludeOS.git";
        ref = "main";
      }) { inherit smp; inherit withCcache; },

}:
let
  stdenv = includeos.stdenv;
  pkgs = includeos.pkgs;
  pkgsStatic = includeos.pkgsStatic;
in
pkgs.mkShell.override { inherit (includeos) stdenv; } rec {
  packages = [
    includeos.vmrunner
    stdenv.cc
    pkgs.buildPackages.cmake
    pkgs.buildPackages.nasm
    pkgs.qemu
    pkgs.which
    pkgs.grub2
    pkgs.iputils
  ];

  buildInputs = [
    includeos
    includeos.chainloader
  ];

  bootloader="${includeos}/boot/bootloader";

  shellHook = ''
    echo "To build the hello_world unikernel:"
    echo " cmake src/CMakeLists.txt -B ./build"
    echo " cd ./build"
    echo " make"
    echo " boot ./hello.elf.bin"
  '';
}
