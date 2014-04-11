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

public class AppService implements Serializable {





	public UserService getUserService(String email,String password) {
	
	UserService results = new UserService();
	results.setEmail(email);
	results.setPassword(password);
	

	return results;
	}


}

