package blog;

import java.util.*;
import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.*;

//[START simple_includes]
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
//[END simple_includes]

//[START multipart_includes]
import java.io.UnsupportedEncodingException;
import java.time.LocalDate;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class GAEJCronServlet extends HttpServlet {
	private static final Logger _logger = Logger.getLogger(GAEJCronServlet.class.getName());
	
	static {;

        ObjectifyService.register(Emails.class);

    }

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			List<Emails> emails = ObjectifyService.ofy().load().type(Emails.class).list();
			List<Post> post = ObjectifyService.ofy().load().type(Post.class).list();
			
			_logger.info(emails.get(0).toString());
			
			
			//Put your logic here
			Properties props = new Properties();
			Session session = Session.getDefaultInstance(props, null);
			String email_content = "Hi there! Thank you for being a Cuddly Potato Reader! We value your time and dedication! Here are all the new posts in the last 24 hours: \n";
			String email_posts = "";
			Collections.sort(post); 
			

			Date yesterday = new Date(System.currentTimeMillis() - TimeUnit.HOURS.toMillis(24));
			
			for(int c = 0; c < post.size(); c++) {
				if (post.get(c).getDate().after(yesterday)) {
					
					email_posts+=post.get(c).getTitle() +"\n"+ post.get(c).getUser().getEmail() + "\n"
							+ post.get(c).getDate().toString() + "\n" + post.get(c).getContent() + "\n\n";
				}
			}	
			if (!email_posts.equals("")) {	
				
				for (Emails email: emails)
				{	try {
					  Message msg = new MimeMessage(session);
					  msg.setFrom(new InternetAddress("admin@cuddly-potato-blog.appspotmail.com", "Andrea Admin"));
					  msg.addRecipient(Message.RecipientType.TO,
					                   new InternetAddress(email.getEmail(), "Potato Enthusiast"));
					  msg.setSubject("It's Your Daily Potato Updates");
					  msg.setText(email_content+email_posts);
					  Transport.send(msg);
					} catch (AddressException e) {
					  // ...
					} catch (MessagingException e) {
					  // ...
					} catch (UnsupportedEncodingException e) {
					  // ...
					}
				}	
				//BEGIN
				//END
			}	
		} catch (Exception ex) {
			//Log any exceptions in your Cron Job
		}
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}