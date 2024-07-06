import keycard_go
import os

proc main() =
  echo "Starting minimal crash reproduction"

  # Use a temporary directory for testing
  let tempDir = getTempDir() / "keycard_test"
  echo "Using temporary directory: ", tempDir

  # Ensure the directory exists
  createDir(tempDir)

  try:
    echo "Calling keycardInitFlow..."
    let result = keycardInitFlow(tempDir)
    echo "Result from keycardInitFlow: ", result
  except:
    echo "Exception caught: ", getCurrentExceptionMsg()
    echo "Stack trace: ", getStackTrace()

  echo "End of test"

when isMainModule:
  main()
