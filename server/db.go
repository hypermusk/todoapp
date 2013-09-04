package server

import (
	"database/sql"
	_ "github.com/bmizerany/pq"
)

func withdb(f func(db *sql.DB)) {
	db, err := sql.Open("postgres", "user=sunfmin dbname=todoapp sslmode=disable")
	if err != nil {
		panic(err)
	}
	f(db)
	db.Close()
}

func panicIf(err error) {
	if err != nil {
		panic(err)
	}
}
