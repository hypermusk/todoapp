package hypermusk.todoapi;


import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Date;
import com.google.gson.annotations.SerializedName;
import com.google.gson.Gson;
import java.io.Serializable;

public class UserService implements Serializable {



	@SerializedName("Email")
	private String _email;

	@SerializedName("Password")
	private String _password;



	public String getEmail() {
		return this._email;
	}
	public void setEmail(String _email) {
		this._email = _email;
	}

	public String getPassword() {
		return this._password;
	}
	public void setPassword(String _password) {
		this._password = _password;
	}







	
	// --- GetTodoListsParams ---
	public static class GetTodoListsParams {
		




	}
	// --- GetTodoListsResults ---
	public static class GetTodoListsResults {
		
	@SerializedName("List")
	private ArrayList<TodoList> _list;

	@SerializedName("Err")
	private RemoteError _err;



	public ArrayList<TodoList> getList() {
		return this._list;
	}
	public void setList(ArrayList<TodoList> _list) {
		this._list = _list;
	}

	public RemoteError getErr() {
		return this._err;
	}
	public void setErr(RemoteError _err) {
		this._err = _err;
	}



	}
	// --- GetTodoLists ---
	public GetTodoListsResults getTodoLists() {
	
	GetTodoListsResults results = null;
	GetTodoListsParams params = new GetTodoListsParams();
	
	Todoapi _api = Todoapi.get();

	Gson gson = _api.gson();

	Map m = new HashMap();
	m.put("Params", params);
	m.put("This", this);

	String url = String.format("%s/UserService/GetTodoLists.json", _api.getBaseURL());
	String requestBody = gson.toJson(m);

	Todoapi.RequestResult r = Todoapi.request(url, requestBody, null);


	if (r.getErr() != null) {
		results = new GetTodoListsResults();
		results.setErr(r.getErr());
		return results;
	}

	results = gson.fromJson(r.getReader(), GetTodoListsResults.class);
	try {
		r.getReader().close();
	} catch (IOException e) {
	}

	

	return results;
	}


	
	// --- GetTodoItemsParams ---
	public static class GetTodoItemsParams {
		
	@SerializedName("ListId")
	private String _listId;



	public String getListId() {
		return this._listId;
	}
	public void setListId(String _listId) {
		this._listId = _listId;
	}



	}
	// --- GetTodoItemsResults ---
	public static class GetTodoItemsResults {
		
	@SerializedName("List")
	private ArrayList<TodoItem> _list;

	@SerializedName("Err")
	private RemoteError _err;



	public ArrayList<TodoItem> getList() {
		return this._list;
	}
	public void setList(ArrayList<TodoItem> _list) {
		this._list = _list;
	}

	public RemoteError getErr() {
		return this._err;
	}
	public void setErr(RemoteError _err) {
		this._err = _err;
	}



	}
	// --- GetTodoItems ---
	public GetTodoItemsResults getTodoItems(String listId) {
	
	GetTodoItemsResults results = null;
	GetTodoItemsParams params = new GetTodoItemsParams();
	params.setListId(listId);
	
	Todoapi _api = Todoapi.get();

	Gson gson = _api.gson();

	Map m = new HashMap();
	m.put("Params", params);
	m.put("This", this);

	String url = String.format("%s/UserService/GetTodoItems.json", _api.getBaseURL());
	String requestBody = gson.toJson(m);

	Todoapi.RequestResult r = Todoapi.request(url, requestBody, null);


	if (r.getErr() != null) {
		results = new GetTodoItemsResults();
		results.setErr(r.getErr());
		return results;
	}

	results = gson.fromJson(r.getReader(), GetTodoItemsResults.class);
	try {
		r.getReader().close();
	} catch (IOException e) {
	}

	

	return results;
	}


	
	// --- PutTodoListParams ---
	public static class PutTodoListParams {
		
	@SerializedName("Name")
	private String _name;



	public String getName() {
		return this._name;
	}
	public void setName(String _name) {
		this._name = _name;
	}



	}
	// --- PutTodoListResults ---
	public static class PutTodoListResults {
		
	@SerializedName("Err")
	private RemoteError _err;



	public RemoteError getErr() {
		return this._err;
	}
	public void setErr(RemoteError _err) {
		this._err = _err;
	}



	}
	// --- PutTodoList ---
	public RemoteError putTodoList(String name) {
	
	PutTodoListResults results = null;
	PutTodoListParams params = new PutTodoListParams();
	params.setName(name);
	
	Todoapi _api = Todoapi.get();

	Gson gson = _api.gson();

	Map m = new HashMap();
	m.put("Params", params);
	m.put("This", this);

	String url = String.format("%s/UserService/PutTodoList.json", _api.getBaseURL());
	String requestBody = gson.toJson(m);

	Todoapi.RequestResult r = Todoapi.request(url, requestBody, null);


	if (r.getErr() != null) {
		results = new PutTodoListResults();
		results.setErr(r.getErr());
		return results.getErr();
	}

	results = gson.fromJson(r.getReader(), PutTodoListResults.class);
	try {
		r.getReader().close();
	} catch (IOException e) {
	}

	

	return results.getErr();
	}


	
	// --- CreateTodoParams ---
	public static class CreateTodoParams {
		
	@SerializedName("ListId")
	private String _listId;

	@SerializedName("Content")
	private String _content;



	public String getListId() {
		return this._listId;
	}
	public void setListId(String _listId) {
		this._listId = _listId;
	}

	public String getContent() {
		return this._content;
	}
	public void setContent(String _content) {
		this._content = _content;
	}



	}
	// --- CreateTodoResults ---
	public static class CreateTodoResults {
		
	@SerializedName("Err")
	private RemoteError _err;



	public RemoteError getErr() {
		return this._err;
	}
	public void setErr(RemoteError _err) {
		this._err = _err;
	}



	}
	// --- CreateTodo ---
	public RemoteError createTodo(String listId,String content) {
	
	CreateTodoResults results = null;
	CreateTodoParams params = new CreateTodoParams();
	params.setListId(listId);
	params.setContent(content);
	
	Todoapi _api = Todoapi.get();

	Gson gson = _api.gson();

	Map m = new HashMap();
	m.put("Params", params);
	m.put("This", this);

	String url = String.format("%s/UserService/CreateTodo.json", _api.getBaseURL());
	String requestBody = gson.toJson(m);

	Todoapi.RequestResult r = Todoapi.request(url, requestBody, null);


	if (r.getErr() != null) {
		results = new CreateTodoResults();
		results.setErr(r.getErr());
		return results.getErr();
	}

	results = gson.fromJson(r.getReader(), CreateTodoResults.class);
	try {
		r.getReader().close();
	} catch (IOException e) {
	}

	

	return results.getErr();
	}


	
	// --- DoneTodoParams ---
	public static class DoneTodoParams {
		
	@SerializedName("TodoItemId")
	private String _todoItemId;



	public String getTodoItemId() {
		return this._todoItemId;
	}
	public void setTodoItemId(String _todoItemId) {
		this._todoItemId = _todoItemId;
	}



	}
	// --- DoneTodoResults ---
	public static class DoneTodoResults {
		
	@SerializedName("Err")
	private RemoteError _err;



	public RemoteError getErr() {
		return this._err;
	}
	public void setErr(RemoteError _err) {
		this._err = _err;
	}



	}
	// --- DoneTodo ---
	public RemoteError doneTodo(String todoItemId) {
	
	DoneTodoResults results = null;
	DoneTodoParams params = new DoneTodoParams();
	params.setTodoItemId(todoItemId);
	
	Todoapi _api = Todoapi.get();

	Gson gson = _api.gson();

	Map m = new HashMap();
	m.put("Params", params);
	m.put("This", this);

	String url = String.format("%s/UserService/DoneTodo.json", _api.getBaseURL());
	String requestBody = gson.toJson(m);

	Todoapi.RequestResult r = Todoapi.request(url, requestBody, null);


	if (r.getErr() != null) {
		results = new DoneTodoResults();
		results.setErr(r.getErr());
		return results.getErr();
	}

	results = gson.fromJson(r.getReader(), DoneTodoResults.class);
	try {
		r.getReader().close();
	} catch (IOException e) {
	}

	

	return results.getErr();
	}


	
	// --- UndoneTodoParams ---
	public static class UndoneTodoParams {
		
	@SerializedName("TodoItemId")
	private String _todoItemId;



	public String getTodoItemId() {
		return this._todoItemId;
	}
	public void setTodoItemId(String _todoItemId) {
		this._todoItemId = _todoItemId;
	}



	}
	// --- UndoneTodoResults ---
	public static class UndoneTodoResults {
		
	@SerializedName("Err")
	private RemoteError _err;



	public RemoteError getErr() {
		return this._err;
	}
	public void setErr(RemoteError _err) {
		this._err = _err;
	}



	}
	// --- UndoneTodo ---
	public RemoteError undoneTodo(String todoItemId) {
	
	UndoneTodoResults results = null;
	UndoneTodoParams params = new UndoneTodoParams();
	params.setTodoItemId(todoItemId);
	
	Todoapi _api = Todoapi.get();

	Gson gson = _api.gson();

	Map m = new HashMap();
	m.put("Params", params);
	m.put("This", this);

	String url = String.format("%s/UserService/UndoneTodo.json", _api.getBaseURL());
	String requestBody = gson.toJson(m);

	Todoapi.RequestResult r = Todoapi.request(url, requestBody, null);


	if (r.getErr() != null) {
		results = new UndoneTodoResults();
		results.setErr(r.getErr());
		return results.getErr();
	}

	results = gson.fromJson(r.getReader(), UndoneTodoResults.class);
	try {
		r.getReader().close();
	} catch (IOException e) {
	}

	

	return results.getErr();
	}


	
	// --- UploadFileParams ---
	public static class UploadFileParams {
		
	@SerializedName("TodoItemId")
	private String _todoItemId;



	public String getTodoItemId() {
		return this._todoItemId;
	}
	public void setTodoItemId(String _todoItemId) {
		this._todoItemId = _todoItemId;
	}



	}
	// --- UploadFileResults ---
	public static class UploadFileResults {
		
	@SerializedName("Err")
	private RemoteError _err;



	public RemoteError getErr() {
		return this._err;
	}
	public void setErr(RemoteError _err) {
		this._err = _err;
	}



	}
	// --- UploadFile ---
	public RemoteError uploadFile(String todoItemId,InputStream file) {
	
	UploadFileResults results = null;
	UploadFileParams params = new UploadFileParams();
	params.setTodoItemId(todoItemId);
	
	Todoapi _api = Todoapi.get();

	Gson gson = _api.gson();

	Map m = new HashMap();
	m.put("Params", params);
	m.put("This", this);

	String url = String.format("%s/UserService/UploadFile.json", _api.getBaseURL());
	String requestBody = gson.toJson(m);

	Todoapi.RequestResult r = Todoapi.request(url, requestBody, file);


	if (r.getErr() != null) {
		results = new UploadFileResults();
		results.setErr(r.getErr());
		return results.getErr();
	}

	results = gson.fromJson(r.getReader(), UploadFileResults.class);
	try {
		r.getReader().close();
	} catch (IOException e) {
	}

	

	return results.getErr();
	}


}

