package main

/*
#cgo LDFLAGS: -L${SRCDIR} -lunits -lpthread -lm
#include <stdlib.h>
#include "units.h"
*/
import "C"

import (
	"fmt"
	"unsafe"
)

func convert(s string) string {
	cs := C.CString(s)
	defer C.free(unsafe.Pointer(cs))
	out := C.zv_convert(cs)
	defer C.free(unsafe.Pointer(out))
	return C.GoString(out)
}

func main() {
	C.zevic_init(0, nil) // starts the Zevic runtime; call it once, before any other Zevic function

	for _, c := range []float64{-40, 0, 36.6, 100} {
		fmt.Printf("%6.1f C = %6.1f F\n", c, float64(C.zv_c_to_f(C.double(c))))
	}
	fmt.Printf("212 F = %.1f C\n", float64(C.zv_f_to_c(212)))

	for _, s := range []string{"21C", "72.5F", " 0C ", "hot", "12K", "C"} {
		fmt.Printf("convert(%q) = %s\n", s, convert(s))
	}
}
