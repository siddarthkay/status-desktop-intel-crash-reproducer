## Summary

This repo holds my experiment in trying to reproduce the intel MacOS crash.
What we know is that `keyCardInitFlow` and `keyCardCancelFlow` are mentioned in crash stack traces on intel MacOS.
These crashes were observed after go was upgraded to 1.21.10.
We also know that status-desktop app works fine if we comment out calls to `keyCardInitFlow` and `keyCardCancelFlow`

## Reproducibility

Inorder to narrow down further the root cause of the `SIGSEV` issue we see this repository is an attempt to reproduce the
problem, the entry point is `service.nim` which calls `keycardInitFlow` from `keycard_go.nim`.
The `keycard_go.nim` file is just a fancy wrapper which calls the actual methods which are present in the git submodule 
inside `status-keycard-go`
The mapping of function names and their parameters exist in `keycard_go/impl.nim`
Some code has been decorated with lavish logs to figure out which paths of the code execute before we can simulate a crash

`status-keycard-go` builds the library we reference in `keycard_go/impl.nim` by calling `make build-lib` inside
`status-keycard-go` repo. One key thing to remember when building this library is that the go version must be 1.21.x

## Attempts

Sadly I have been unsuccessful in reproducing the crash.

```
sudo nim c -r service.nim
Hint: used config file '/Users/siddarth/.choosenim/toolchains/nim-2.0.8/config/nim.cfg' [Conf]
Hint: used config file '/Users/siddarth/.choosenim/toolchains/nim-2.0.8/config/config.nims' [Conf]
........................................................................
CC: ../.choosenim/toolchains/nim-2.0.8/lib/system/exceptions.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/private/since.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/system/ctypes.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/sysatomics.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/system/ansi_c.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/system/memory.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/private/syslocks.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/private/threadtypes.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/private/digitsutils.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/private/miscdollars.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/assertions.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/system/iterators.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/system/coro_detection.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/private/dragonbox.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/private/schubfach.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/formatfloat.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/objectdollar.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/system/dollars.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/typedthreads.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/system/stacktraces.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/private/bitops_utils.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/system/countbits_impl.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/system/repr_v2.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/widestrs.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/std/syncio.nim
CC: ../.choosenim/toolchains/nim-2.0.8/lib/system.nim
CC: keycard_go/impl.nim
CC: keycard_go.nim
CC: service.nim
Hint:  [Link]
Hint: mm: orc; threads: on; opt: none (DEBUG BUILD, `-d:release` generates faster code)
27884 lines; 0.659s; 30.359MiB peakmem; proj: /Users/siddarth/reproduce-intel-status-desktop-crash/service.nim; out: /Users/siddarth/reproduce-intel-status-desktop-crash/service [SuccessX]
Hint: /Users/siddarth/reproduce-intel-status-desktop-crash/service [Exec]
Program started
before calling keycardInitFlow
after calling keycardInitFlow
after feeeing memory in keycardInitFlow
funcOut is not Nil in keycardInitFlow
returning response for keycardInitFlow ->ok
we are after keycard_go.keycardInitFlow
result -> ok
Program finished
```
