package main

import "C"
import "fmt"

//export greeting
func greeting(who *C.char) {
    fmt.Printf("Hello, %s from Go!\n", C.GoString(who))
}

func main() {}
