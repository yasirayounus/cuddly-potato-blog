package blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;

public class NewsletterServlet extends HttpServlet {
	static {

        ObjectifyService.register(Emails.class);

    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp)

                throws IOException {

        UserService userService = UserServiceFactory.getUserService();

        User user = userService.getCurrentUser();
        		
		Key<Emails> key = Key.create(Emails.class, user.getEmail());
    	Emails email = ObjectifyService.ofy().load().key(key).now();
    	Emails newEmail = new Emails(user.getEmail());

		if (email != null) {
			ofy().delete().entity(email).now();
		} else {
			ofy().save().entity(newEmail).now();
		}
		
		resp.sendRedirect("/newsletter.jsp");

    }

}