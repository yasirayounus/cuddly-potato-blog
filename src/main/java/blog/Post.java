package blog;

import java.util.*;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class Post implements Comparable<Post> {
	@Id Long id;
	@Index User user;
	@Index Date date;
	@Index String content;
	@Index String title;
	private Post() {}
	public Post(String title, User user, Date date, String content ) {
		this.user = user;
		this.title = title;
		this.date = date;
		this.content = content;
	}
	
	public String getTitle() {
		return title;
	}
	
	public Date getDate() {
		return date;
	}
	
	public User getUser() {
		return user;
	}
	
	public String getContent() {
		return content;
	}
	 @Override
	 public int compareTo(Post other) {
	        if (date.after(other.date)) {
	            return -1;
	        } else if (date.before(other.date)) {
	            return 1;
	        }
	        return 0;
	     }
}
