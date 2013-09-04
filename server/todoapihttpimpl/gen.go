// Generated by github.com/sunfmin/goapigen
// DO NOT EDIT

package todoapihttpimpl

import (
	"time"
	"encoding/json"
	"github.com/hypermusk/todoapp/todoapi"
	"github.com/hypermusk/todoapp/server"
	"net/http"
	"github.com/sunfmin/govalidations"
)

var _ govalidations.Errors
var _ = time.Sunday

type CodeError interface {
	Code() string
}

type SerializableError struct {
	Code    string
	Message string
	Reason  error
}

func (s *SerializableError) Error() string {
	return s.Message
}

func NewError(err error) (r error) {
	se := &SerializableError{Message:err.Error()}
	ce, yes := err.(CodeError)
	if yes {
		se.Code = ce.Code()
	}
	se.Reason = err
	r = se
	return
}

func AddToMux(prefix string, mux *http.ServeMux) {
	
	mux.HandleFunc(prefix+"/UserService/GetTodoLists.json", UserService_GetTodoLists)
	mux.HandleFunc(prefix+"/UserService/GetTodoItems.json", UserService_GetTodoItems)
	mux.HandleFunc(prefix+"/UserService/PutTodoList.json", UserService_PutTodoList)
	mux.HandleFunc(prefix+"/UserService/CreateTodo.json", UserService_CreateTodo)
	mux.HandleFunc(prefix+"/UserService/DoneTodo.json", UserService_DoneTodo)
	mux.HandleFunc(prefix+"/UserService/UndoneTodo.json", UserService_UndoneTodo)
	return
}



type UserServiceData struct {
	Email string
	Password string
}


type UserService_GetTodoLists_Params struct {
	This   UserServiceData
	Params struct {
	}
}

type UserService_GetTodoLists_Results struct {
	List []*todoapi.TodoList
	Err error

}

func UserService_GetTodoLists(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")
	w.Header().Add("Access-Control-Allow-Origin", "*")

	var p UserService_GetTodoLists_Params
	if r.Body == nil {
		panic("no body")
	}
	defer r.Body.Close()
	dec := json.NewDecoder(r.Body)
	err := dec.Decode(&p)
	var result UserService_GetTodoLists_Results
	enc := json.NewEncoder(w)
	if err != nil {
		result.Err = NewError(err)
		enc.Encode(result)
		return
	}

	s, err := appservice.GetUserService(p.This.Email, p.This.Password)

	if err != nil {
		result.Err = NewError(err)
		enc.Encode(result)
		return
	}
	result.List, result.Err = s.GetTodoLists()
	if result.Err != nil {
		result.Err = NewError(result.Err)
	}
	err = enc.Encode(result)
	if err != nil {
		panic(err)
	}
	return
}

type UserService_GetTodoItems_Params struct {
	This   UserServiceData
	Params struct {
		ListId string
	}
}

type UserService_GetTodoItems_Results struct {
	List []*todoapi.TodoItem
	Err error

}

func UserService_GetTodoItems(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")
	w.Header().Add("Access-Control-Allow-Origin", "*")

	var p UserService_GetTodoItems_Params
	if r.Body == nil {
		panic("no body")
	}
	defer r.Body.Close()
	dec := json.NewDecoder(r.Body)
	err := dec.Decode(&p)
	var result UserService_GetTodoItems_Results
	enc := json.NewEncoder(w)
	if err != nil {
		result.Err = NewError(err)
		enc.Encode(result)
		return
	}

	s, err := appservice.GetUserService(p.This.Email, p.This.Password)

	if err != nil {
		result.Err = NewError(err)
		enc.Encode(result)
		return
	}
	result.List, result.Err = s.GetTodoItems(p.Params.ListId)
	if result.Err != nil {
		result.Err = NewError(result.Err)
	}
	err = enc.Encode(result)
	if err != nil {
		panic(err)
	}
	return
}

type UserService_PutTodoList_Params struct {
	This   UserServiceData
	Params struct {
		Name string
	}
}

type UserService_PutTodoList_Results struct {
	Err error

}

func UserService_PutTodoList(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")
	w.Header().Add("Access-Control-Allow-Origin", "*")

	var p UserService_PutTodoList_Params
	if r.Body == nil {
		panic("no body")
	}
	defer r.Body.Close()
	dec := json.NewDecoder(r.Body)
	err := dec.Decode(&p)
	var result UserService_PutTodoList_Results
	enc := json.NewEncoder(w)
	if err != nil {
		result.Err = NewError(err)
		enc.Encode(result)
		return
	}

	s, err := appservice.GetUserService(p.This.Email, p.This.Password)

	if err != nil {
		result.Err = NewError(err)
		enc.Encode(result)
		return
	}
	result.Err = s.PutTodoList(p.Params.Name)
	if result.Err != nil {
		result.Err = NewError(result.Err)
	}
	err = enc.Encode(result)
	if err != nil {
		panic(err)
	}
	return
}

type UserService_CreateTodo_Params struct {
	This   UserServiceData
	Params struct {
		ListId string
		Name string
	}
}

type UserService_CreateTodo_Results struct {
	Err error

}

func UserService_CreateTodo(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")
	w.Header().Add("Access-Control-Allow-Origin", "*")

	var p UserService_CreateTodo_Params
	if r.Body == nil {
		panic("no body")
	}
	defer r.Body.Close()
	dec := json.NewDecoder(r.Body)
	err := dec.Decode(&p)
	var result UserService_CreateTodo_Results
	enc := json.NewEncoder(w)
	if err != nil {
		result.Err = NewError(err)
		enc.Encode(result)
		return
	}

	s, err := appservice.GetUserService(p.This.Email, p.This.Password)

	if err != nil {
		result.Err = NewError(err)
		enc.Encode(result)
		return
	}
	result.Err = s.CreateTodo(p.Params.ListId, p.Params.Name)
	if result.Err != nil {
		result.Err = NewError(result.Err)
	}
	err = enc.Encode(result)
	if err != nil {
		panic(err)
	}
	return
}

type UserService_DoneTodo_Params struct {
	This   UserServiceData
	Params struct {
		TodoId string
	}
}

type UserService_DoneTodo_Results struct {
	Err error

}

func UserService_DoneTodo(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")
	w.Header().Add("Access-Control-Allow-Origin", "*")

	var p UserService_DoneTodo_Params
	if r.Body == nil {
		panic("no body")
	}
	defer r.Body.Close()
	dec := json.NewDecoder(r.Body)
	err := dec.Decode(&p)
	var result UserService_DoneTodo_Results
	enc := json.NewEncoder(w)
	if err != nil {
		result.Err = NewError(err)
		enc.Encode(result)
		return
	}

	s, err := appservice.GetUserService(p.This.Email, p.This.Password)

	if err != nil {
		result.Err = NewError(err)
		enc.Encode(result)
		return
	}
	result.Err = s.DoneTodo(p.Params.TodoId)
	if result.Err != nil {
		result.Err = NewError(result.Err)
	}
	err = enc.Encode(result)
	if err != nil {
		panic(err)
	}
	return
}

type UserService_UndoneTodo_Params struct {
	This   UserServiceData
	Params struct {
		TodoId string
	}
}

type UserService_UndoneTodo_Results struct {
	Err error

}

func UserService_UndoneTodo(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")
	w.Header().Add("Access-Control-Allow-Origin", "*")

	var p UserService_UndoneTodo_Params
	if r.Body == nil {
		panic("no body")
	}
	defer r.Body.Close()
	dec := json.NewDecoder(r.Body)
	err := dec.Decode(&p)
	var result UserService_UndoneTodo_Results
	enc := json.NewEncoder(w)
	if err != nil {
		result.Err = NewError(err)
		enc.Encode(result)
		return
	}

	s, err := appservice.GetUserService(p.This.Email, p.This.Password)

	if err != nil {
		result.Err = NewError(err)
		enc.Encode(result)
		return
	}
	result.Err = s.UndoneTodo(p.Params.TodoId)
	if result.Err != nil {
		result.Err = NewError(result.Err)
	}
	err = enc.Encode(result)
	if err != nil {
		panic(err)
	}
	return
}




var appservice todoapi.AppService = server.DefaultAppService

type AppServiceData struct {
}








