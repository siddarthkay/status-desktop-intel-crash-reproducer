import os

const libPath = "./status-keycard-go/build/libkeycard/libkeycard.dylib"

{.push cdecl, dynlib: libPath.}
proc KeycardInitFlow*(storageDir: cstring): cstring {.importc.}
proc free*(param: pointer) {.importc: "Free".}
{.pop.}

proc main() =
  let storageDir = "/Users/siddarth/data/Status/data/keycard/pairings.json"

  let result = KeycardInitFlow(storageDir.cstring)

  if result.isNil:
    echo "isNil"

  if not result.isNil:
    echo "result -> ", $result
    defer: free(result)

  else:
    echo "Keycard flow initialized successfully"

main()
