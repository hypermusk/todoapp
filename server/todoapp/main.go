package main

import (
	"github.com/hypermusk/todoapp/server/todoapihttpimpl"
	"log"
	"net/http"
)

func main() {

	todoapihttpimpl.AddToMux("/api", http.DefaultServeMux)
	http.DefaultServeMux.Handle("/web/", http.FileServer(http.Dir("/Users/sunfmin/gopkg/src/github.com/hypermusk/todoapp")))
	err := http.ListenAndServe(":9000", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
