package blog;

import java.util.*;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class Emails{
	@Id String email;
	private Emails() {}
	public Emails(String email ) {
		this.email = email;
	}
	
	public String getEmail() {
		return email;
	}
	
	@Override
	public String toString() {
		return email;
	}
	
//	@Override
//	public boolean equals(Object other) {
//		return (other.toString().equals(this.toString()));
//	}
//	
//	
//	@Override
//	public int compareTo(Emails o) {
//		if (o.getEmail().equals(this.getEmail())) return 0;
//		return 1;
//	}
	
}
