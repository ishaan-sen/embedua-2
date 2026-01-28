cd build
uiua build ../src/uiua/ui.ua -o uiua.uasm
cd ..
uiua-analysis build/uiua.uasm build/uiua.mlir
mlir-opt build/uiua.mlir --pass-pipeline='builtin.module(symbol-dce,cse,func.func(tosa-to-linalg-named,tosa-to-linalg,tosa-to-arith,convert-elementwise-to-linalg),one-shot-bufferize{allow-return-allocs-from-loops bufferize-function-boundaries},func.func(buffer-hoisting,buffer-loop-hoisting),drop-equivalent-buffer-results,func.func(promote-buffers-to-stack),buffer-deallocation-pipeline,convert-bufferization-to-memref,expand-strided-metadata,convert-linalg-to-affine-loops,lower-affine,finalize-memref-to-llvm,convert-scf-to-cf,convert-to-llvm,reconcile-unrealized-casts,canonicalize)' -o build/uiua_opt.mlir
mlir-opt --convert-func-to-llvm --convert-arith-to-llvm build/uiua_opt.mlir | mlir-translate --mlir-to-llvmir | clang --target=arm-none-eabi -mcpu=cortex-m0plus -mthumb -Wall -ffreestanding -nostdlib -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Ihw/cmsis -Ihw/samd21 -D__SAMD21G18A__ -c -x ir - -o build/uiua.o.tmp
arm-none-eabi-objcopy -R .ARM.exidx -R .ARM.extab build/uiua.o.tmp build/uiua.o
arm-none-eabi-ar rcs lib/uiua/libuiua.a build/uiua.o

