package(default_visibility = ["//visibility:public"])

exports_files(["test.sh"])

cc_toolchain_suite(
    name = "emscripten",
    toolchains = {
        "emscripten|emscripten": "emscripten_toolchain",
    },
)

filegroup(name = "empty")

filegroup(
    name = "all",
    srcs = [
        "emar.sh",
        "emcc.sh",
        "@emscripten_toolchain//:all",
        ":emscripten_cache_content",
        "@emscripten_clang//:all",
        "@nodejs//:node/bin/node",
    ],
)

filegroup(
    name = "emscripten_cache_content",
    srcs = glob(["emscripten_cache/**/*"]),
)

cc_toolchain(
    name = "emscripten_toolchain",
    all_files = ":all",
    compiler_files = ":all",
    cpu = "emscripten",
    dwp_files = ":empty",
    dynamic_runtime_libs = [":empty"],
    linker_files = ":all",
    objcopy_files = ":empty",
    static_runtime_libs = [":empty"],
    strip_files = ":empty",
    supports_param_files = 0,
)
