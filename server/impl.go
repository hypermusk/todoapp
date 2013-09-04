package server

import (
	"database/sql"
	"errors"
	"fmt"
	_ "github.com/bmizerany/pq"
	"github.com/hypermusk/todoapp/todoapi"
	"strconv"
)

type AppServiceImpl struct {
}

type UserServiceImpl struct {
}

func (a *AppServiceImpl) GetUserService(email string, password string) (service todoapi.UserService, err error) {
	if email != "admin@example.com" && password != "nimda" {
		err = errors.New("wrong credentials")
		return
	}
	service = new(UserServiceImpl)
	return
}

func (u *UserServiceImpl) GetTodoLists() (list []*todoapi.TodoList, err error) {
	withdb(func(db *sql.DB) {
		list = make([]*todoapi.TodoList, 0)
		rows, err := db.Query("SELECT id, name FROM todo_lists ORDER BY id ASC")
		panicIf(err)

		for rows.Next() {
			newL := new(todoapi.TodoList)
			var id int
			err = rows.Scan(&id, &newL.Name)
			panicIf(err)
			newL.Id = fmt.Sprintf("%d", id)
			list = append(list, newL)
		}
	})
	return
}

func (u *UserServiceImpl) GetTodoItems(listId string) (list []*todoapi.TodoItem, err error) {
	id, _ := strconv.ParseInt(listId, 10, 64)
	withdb(func(db *sql.DB) {
		list = make([]*todoapi.TodoItem, 0)
		rows, err := db.Query("SELECT id, content FROM todo_items WHERE todo_list_id=$1 ORDER BY id DESC", id)
		panicIf(err)

		for rows.Next() {
			newItem := new(todoapi.TodoItem)
			var id int
			err = rows.Scan(&id, &newItem.Content)
			panicIf(err)
			newItem.Id = fmt.Sprintf("%d", id)
			list = append(list, newItem)
		}
	})
	return
}

func (u *UserServiceImpl) PutTodoList(name string) (err error) {
	return
}

func (u *UserServiceImpl) CreateTodo(listId string, name string) (err error) {
	lid, _ := strconv.ParseInt(listId, 10, 64)
	withdb(func(db *sql.DB) {
		_, err := db.Exec("INSERT INTO todo_items (content, todo_list_id) VALUES ($1, $2)", name, lid)
		panicIf(err)

	})
	return
}

func (u *UserServiceImpl) DoneTodo(todoId string) (err error) {
	return
}

func (u *UserServiceImpl) UndoneTodo(todoId string) (err error) {
	return
}

var DefaultAppService = new(AppServiceImpl)
