package hypermusk;

import hypermusk.todoapi.*;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

/**
 * Created by sunfmin on 4/11/14.
 */
public class Main {
    public static void main(String[] args) {

        Todoapi _api = Todoapi.get();
        _api.setBaseURL("http://localhost:9001/api");

        AppService app = new AppService();
        UserService userService = app.getUserService("admin@example.com", "nimda");

        UserService.GetTodoListsResults lr = userService.getTodoLists();

        for (TodoList l : lr.getList()) {
            System.out.println(l.getName());
        }

//        try {
//            InputStream is = new FileInputStream("/Users/sunfmin/Downloads/thisisbinary.txt");
//            RemoteError err = userService.uploadFile("HI, felix this is /.1231!@#$%^&*()_", is);
//        } catch (FileNotFoundException e) {
//            e.printStackTrace();
//        }


    }
}
