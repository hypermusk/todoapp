package hypermusk.todoapi;



import java.util.Map;
import com.google.gson.annotations.SerializedName;

public class RemoteError {
	@SerializedName("Code")
	private String _code;
	@SerializedName("Message")
	private String _message;
	@SerializedName("Reason")
	private Map _reason;

	public String getCode() {
		return this._code;
	}
	public void setCode(String _code) {
		this._code = _code;
	}
	public String getMessage() {
		return this._message;
	}
	public void setMessage(String _message) {
		this._message = _message;
	}
	public Map getReason() {
		return this._reason;
	}
	public void setReason(Map _reason) {
		this._reason = _reason;
	}

	@Override
	public String toString() {
		return String.format("%s: %s", this._code, this._message);
	}
}
