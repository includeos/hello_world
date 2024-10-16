# IncludeOS Hello World
A basic example to demonstrate the open source unikernel project - [IncludeOS](https://github.com/includeos/includeos).

IncludeOS is built with [nix](https://nixos.org). Before building the example
you need a working nix-installation. To speed up the build process, we also
recommend having [ccache enabled](https://nixos.wiki/wiki/CCache) installed, but this is
not a requirement. To use ccache, add `--arg withCcache true` to the nix commands below.

The source code for the example is in `./src/main.cpp`. It prints "Hello world" and calls shutdown:
```c++
$ cat ./src/main.cpp
#include <iostream>
#include <os>

int main(){
  std::cout << "Hello world\n";
  os::shutdown();
}
```

The following steps let you build and boot this example with IncludeOS.

```bash
$ nix-build
```

This will download and build the latest IncludeOS libraries and their
dependencies and build the `hello-world` service. The final binary will be
called `hello.bin.elf` in `./result/bin`.

```bash
$ ls ./result/bin
hello.elf.bin
```

To boot the unikernel you need to add a bootloader or use the IncludeOS
chainloader. The separate tool
[vmrunner](https://github.com/includeos/vmrunner), can be used to automatically
manage this. QEMU and `vmrunner` is already configured in `shell.nix`.

To boot the unikernel, run

```
$ nix-shell --command "boot ./result/bin/hello.elf.bin"
[...]
ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, stripped

SeaBIOS (version rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org)


iPXE (http://ipxe.org) 00:03.0 CA00 PCI2.10 PnP PMM+06FD0E60+06F30E60 CA00
Press Ctrl-B to configure iPXE (PCI 00:03.0)...


Booting from ROM..* Multiboot begin: 0x9500
* Multiboot cmdline @ 0x29d02e: /nix/store/jd9dhri62mz7lm5mld58c7c1wn2dsnbx-chainloader-static-i686-unknown-linux-musl-dev/bin/chainloader ""
* Multiboot end: 0x29d09c
* Module list @ 0x29d000
	 * Module @ 0x29e000
	 * Args: ./result/bin/hello.elf.bin ""
 	 * End: 0x43d6c0
 * Multiboot end: 0x43d6c0
* ELF syms header CRC OK
<Multiboot>Booted with multiboot
	* Boot flags: 0x24f
	* Valid memory (130559 Kib):
	  0x00000000 - 0x0009fbff (639 Kib)
	  0x00100000 - 0x07fdffff (129920 Kib)

	* Booted with parameters @ 0x29d02e: /nix/store/jd9dhri62mz7lm5mld58c7c1wn2dsnbx-chainloader-static-i686-unknown-linux-musl-dev/bin/chainloader ""
	* Multiboot provided memory map  (7 entries @ 0x9000)
	  0x0000000000 - 0x000009fbff FREE (639 Kb.)
	  0x000009fc00 - 0x000009ffff RESERVED (1 Kb.)
	  0x00000f0000 - 0x00000fffff RESERVED (64 Kb.)
	  0x0000100000 - 0x0007fdffff FREE (129920 Kb.)
	  0x0007fe0000 - 0x0007ffffff RESERVED (128 Kb.)
	  0x00fffc0000 - 0x00ffffffff RESERVED (256 Kb.)
	  0x0000000000 - 0x00ffffffff RESERVED (0 Kb.)

<Multiboot>OS loaded with 1 modules
	* ./result/bin/hello.elf.bin "" @ 0x29e000 - 0x43d6c0, size: 1701568b
* Multiboot begin: 0x9500
* Multiboot end: 0x3e59c0
[x86_64 PC] constructor
[ Machine ] Initializing heap
[ Machine ] Main memory detected as 129998656 b
[ Machine ] Reserving 1048576 b for machine use
<Multiboot>Booted with multiboot
	* Boot flags: 0x24f
	* Valid memory (130559 Kib):
	  0x00000000 - 0x0009fbff (639 Kib)
	  0x00100000 - 0x07fdffff (129920 Kib)

	* Booted with parameters @ 0x8000: ./result/bin/hello.elf.bin ""
	* Multiboot provided memory map  (7 entries @ 0x9000)
	  0x0000000000 - 0x000009fbff FREE (639 Kb.)
	  0x000009fc00 - 0x000009ffff RESERVED (1 Kb.)
	  0x00000f0000 - 0x00000fffff RESERVED (64 Kb.)
	  0x0000100000 - 0x0007fdffff FREE (129920 Kb.)
	  0x0007fe0000 - 0x0007ffffff RESERVED (128 Kb.)
	  0x00fffc0000 - 0x00ffffffff RESERVED (256 Kb.)
	  0xfd00000000 - 0xffffffffff RESERVED (12582912 Kb.)

================================================================================
 IncludeOS VERY_DIRTY (x86_64 / 64-bit)
 +--> Running [ Hello world - OS included ]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 +--> WARNING: No good random source found: RDRAND/RDSEED instructions not available.
 +-->        To make this warning fatal, re-compile with FOR_PRODUCTION=ON.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Hello world
       [ main ] returned with status 0
     [ Kernel ] Stopping service
     [ Kernel ] Powering off

[ SUCCESS ] process exited
```

You can also use `shell.nix` to rebuild and boot the unikernel during
development, without having to invoke `nix-shell` every time. Just run
`nix-shell` and follow the instructions:

```
$ nix-shell
To build the hello_world unikernel:
 cmake src/CMakeLists.txt -B ./build
 cd ./build
 make
 boot ./hello.elf.bin
```

For more details on how to develop with IncludeOS see the [main
repository](https://github.com/includeos/includeos.git).
