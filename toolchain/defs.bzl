def emcc_binary(name,
                memory_init_file=0,
                wasm=True,
                worker=False,
                linkopts=[],
                **kwargs):
    includejs = False
    includehtml = False
    linkopts = list(linkopts)
    if name.endswith(".html"):
        basename = name[:-5]
        includehtml = True
        includejs = True
    elif name.endswith(".js"):
        basename = name[:-3]
        includejs = True
    outputs = []
    if includejs:
        outputs.append(basename + ".js")
        if wasm:
            outputs.append(basename + ".wasm")
        if memory_init_file:
            outputs.append(basename + ".mem")
        if worker:
            outputs.append(basename + ".worker.js")
            linkopts.append('--proxy-to-worker')

    if includehtml:
        outputs.append(basename + ".html")
    if not wasm:
        linkopts.append('-s WASM=0')
        linkopts.append('--memory-init-file %d' % memory_init_file)
    if includejs:
        tarfile = name + ".tar"
        # we'll generate a tarfile and extract multiple outputs
        native.cc_binary(name=tarfile, linkopts=linkopts, **kwargs)
        native.genrule(
            name="emcc_extract_" + tarfile,
            srcs=[tarfile],
            outs=outputs,
            output_to_bindir=1,
            testonly=kwargs.get('testonly'),
            cmd="""
          tar xf $< -C "$(@D)"/$$(dirname "%s")
        """ % [outputs[0]])
    else:
        native.cc_binary(name=name, linkopts=linkopts, **kwargs)


def emcc_test(name, **kwargs):
    binary_args = {}
    test_args = {}
    data = ["@nodejs//:node/bin/node"]
    for key, val in kwargs.items():
        if key == 'tags':
            binary_args[key] = val
            test_args[key] = val
        elif key == 'data':
            data.extend(val)
        elif key in [
                'args', 'size', 'timeout', 'flaky', 'local', 'shard_count'
        ]:
            test_args[key] = val
        else:
            binary_args[key] = val
    jsfile = name + ".js"
    data.append(jsfile)
    if kwargs.get('wasm', True):
        data.append(name+'.wasm')
    emcc_binary(jsfile, testonly=True, **binary_args)
    shfile = name + "_test.sh"
    native.genrule(
        name="gen_" + shfile,
        cmd="cp $< $@",
        srcs=["@rules_emscripten//toolchain:test.sh"],
        testonly=True,
        outs=[shfile])
    native.sh_test(
        name=name,
        srcs=[shfile],
        data=data,
        deps=[
            "@bazel_tools//tools/bash/runfiles",
        ],
        **test_args)
