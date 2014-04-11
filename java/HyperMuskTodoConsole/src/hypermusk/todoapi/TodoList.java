package hypermusk.todoapi;





import com.google.gson.annotations.SerializedName;
import java.io.Serializable;

public class TodoList implements Serializable {

	@SerializedName("Id")
	private String _id;

	@SerializedName("Name")
	private String _name;



	public String getId() {
		return this._id;
	}
	public void setId(String _id) {
		this._id = _id;
	}

	public String getName() {
		return this._name;
	}
	public void setName(String _name) {
		this._name = _name;
	}



}

