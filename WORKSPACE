workspace(name="rules_emscripten")

new_http_archive(
    name = 'emscripten_toolchain',
    url = 'https://github.com/kripken/emscripten/archive/1.38.6.tar.gz',
    build_file = '//toolchain:emscripten-toolchain.BUILD',
    strip_prefix = "emscripten-1.38.6",
    sha256 = "7e0d07beaa6177d7fca4446ed825cecf07ca4ced4a710f29411eea2082e763d5",
)

new_http_archive(
    name = 'emscripten_clang',
    url = 'https://s3.amazonaws.com/mozilla-games/emscripten/packages/llvm/tag/osx_64bit/emscripten-llvm-e1.38.6.tar.gz',
    build_file = '//toolchain:emscripten-clang.BUILD',
    strip_prefix = "emscripten-llvm-e1.38.6",
    sha256 = "ebdfe41cd68a32dcc4c2093a811c6dcd3e632906abc5d62243719f88dd6a6b02",
)

http_archive(
    name = "build_bazel_rules_nodejs",
    url = 'https://github.com/bazelbuild/rules_nodejs/archive/0.10.1.tar.gz',
    strip_prefix = "rules_nodejs-0.10.1",
    # sha256 = "7e0d07beaa6177d7fca4446ed825cecf07ca4ced4a710f29411eea2082e763d5",
)

load("@build_bazel_rules_nodejs//:defs.bzl", "node_repositories")
node_repositories(package_json = ["//:package.json"])