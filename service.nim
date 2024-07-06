import keycard_go

proc init*() =
  var initResp = keycard_go.keycardInitFlow("/Users/siddarth/data/Status/data/keycard/pairings.json")
  echo "we are after keycard_go.keycardInitFlow"
  if initResp.len == 0:
    echo "Empty response"
  else:
    echo "result -> ", initResp

when isMainModule:
  echo "Program started"
  init()
  echo "Program finished"
