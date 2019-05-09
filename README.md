# hello_world
Basic IncludeOS example

A basic example to demonstrate the open source unikernel project - [IncludeOS](https://github.com/includeos/includeos).

The following steps let you build and boot this example with IncludeOS.

```bash
$ git clone https://github.com/includeos/hello_world.git
$ mkdir your_build_dir && cd "$_"
$ conan install ../hello_world -pr <your_conan_profile>
$ source activate.sh
$ cmake ../hello_world
$ cmake --build .
$ boot hello
```

Checkout out prepared conan profiles in the [conan config repository](https://github.com/includeos/conan_config). The [README](https://github.com/includeos/conan_config/blob/master/README.md) has information on which profile is suited for your environment.

For more advanced examples see the [examples repo](https://github.com/includeos/demo-examples) or the integration tests (under ./IncludeOS/test/\*/integration).

Once you're done `$ source deactivate.sh` will reset the environment to its previous state.

If you have any questions, feel free to [chat with us on Slack](https://goo.gl/NXBVsc).
