package todoapi

import (
	"io"
)

type TodoList struct {
	Id   string
	Name string
}

type TodoItem struct {
	Id      string
	ListId  string
	Content string
	Done    bool
}

type AppService interface {
	GetUserService(email string, password string) (service UserService, err error)
}

type UserService interface {
	GetTodoLists() (list []*TodoList, err error)
	GetTodoItems(listId string) (list []*TodoItem, err error)
	PutTodoList(name string) (err error)
	CreateTodo(listId string, content string) (err error)
	DoneTodo(todoItemId string) (err error)
	UndoneTodo(todoItemId string) (err error)
	UploadFile(todoItemId string, file io.Reader) (err error)
}
