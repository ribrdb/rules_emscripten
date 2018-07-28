package(default_visibility = ['//visibility:public'])

cc_toolchain_suite(name = "emscripten",
    toolchains = {
        "emscripten|emscripten":"emscripten_toolchain",
    }
)

filegroup(name = "empty")
filegroup(
    name = "all",
    srcs = [ 
        "emcc.sh",
        "@emscripten_toolchain//:all",
        "@emscripten_clang//:all",
        "@nodejs//:node/bin/node",
        ":emscripten_cache_content",
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
