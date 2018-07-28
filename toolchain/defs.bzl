def emcc_binary(name, memory_init_file=0,wasm=True,worker=False,linkopts=[], **kwargs):
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
        outputs.append(basename+".js")
    if includehtml:
        outputs.append(basename+".html")
    if wasm:
        outputs.append(basename+".wasm")
    else:
        linkopts.append('-s WASM=0')
    if memory_init_file:
        outputs.append(basename+".mem")
    if worker:
        outputs.append(basename+".worker.js")
        linkopts.append('--proxy-to-worker')
    linkopts.append('--memory-init-file %d'%memory_init_file)
    if includejs:
        tarfile = name+".tar"
        # we'll generate a tarfile and extract multiple outputs
        native.cc_binary(name=tarfile,linkopts=linkopts,**kwargs)
        native.genrule(name="emcc_extract_"+tarfile,srcs=[tarfile],outs=outputs,output_to_bindir=1,cmd="""
          tar xf $< -C "$(@D)"/$$(dirname "%s")
        """%[outputs[0]])
    else:
        native.cc_binary(name=name,linkopts=linkopts,**kwargs)
