package blog;

import java.util.*;
import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class GAEJCronServlet extends HttpServlet {
	private static final Logger _logger = Logger.getLogger(GAEJCronServlet.class.getName());
	
	static {

        ObjectifyService.register(Emails.class);

    }

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			List<Emails> emails = ObjectifyService.ofy().load().type(Emails.class).list();
			_logger.info(emails.toString());
			
			//Put your logic here
			//BEGIN
			//END
		} catch (Exception ex) {
			//Log any exceptions in your Cron Job
		}
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}