package hypermusk.todoapi;





import com.google.gson.annotations.SerializedName;
import java.io.Serializable;

public class TodoItem implements Serializable {

	@SerializedName("Id")
	private String _id;

	@SerializedName("ListId")
	private String _listId;

	@SerializedName("Content")
	private String _content;

	@SerializedName("Done")
	private boolean _done;



	public String getId() {
		return this._id;
	}
	public void setId(String _id) {
		this._id = _id;
	}

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

	public boolean getDone() {
		return this._done;
	}
	public void setDone(boolean _done) {
		this._done = _done;
	}



}

