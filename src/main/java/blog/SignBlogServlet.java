package blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

public class SignBlogServlet extends HttpServlet {
	static {

        ObjectifyService.register(Post.class);

    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp)

                throws IOException {

        UserService userService = UserServiceFactory.getUserService();

        User user = userService.getCurrentUser();

        //String guestbookName = req.getParameter("guestbookName");

        String content = req.getParameter("content");
        
        String title = req.getParameter("title");
        Date date = new Date();

        Post post = new Post(title, user, date, content);
        ofy().save().entity(post).now();
     
        //Not sure if needed, come back to this line
        //resp.sendRedirect("/ofyguestbook.jsp?guestbookName=" + guestbookName);

    }

}