{.push cdecl, dynlib: "greetings.so".}
proc greeting(who: cstring) {.importc.}
{.pop.}

proc hey() =
  let name = readLine(stdin)
  greeting(name.cstring)

proc main() =
  let path = "pairings.json"

main()
