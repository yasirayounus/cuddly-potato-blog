<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.Collections" %>

<%@ page import="java.util.*" %>

<%@ page import="blog.Post" %>
<%@ page import="blog.Emails" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.googlecode.objectify.*" %>

<%@ page import="com.googlecode.objectify.Objectify" %>

<%@ page import="com.googlecode.objectify.ObjectifyService" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 

<html>
	<head>
		<link type="text/css" rel="stylesheet" href="/stylesheets/home.css" />
	</head>
	
	<body>
	  	<div id = header>
	  		<img id = "header_image" src="/header.jpg" alt="header Image">
		  	<div class = "header_title">
		  		<h1 class= "title">The Cuddly Potato</h1>
		  		<p class = "subtitle"><b>THE GO-TO BLOG FOR THE POTATO ENTHUSIAST</b></p>
		  	</div>
		  	
	  	</div>
	  	<hr>
	    <ul id = "menu">
	    	<li class = "menu"><a href='/'>HOME</a></li>
	    	<li class = "menu"><a href='/posts.jsp'>ALL POSTS</a></li>
	    	<li class = "menu"><a href='/blog.jsp'>CREATE POST</a></li>
	    	<li class = "menu"><a href='/newsletter.jsp'>SUBSCRIBE/UNSUBSCRIBE</a></li>
	    	<li class = "menu"><a href='/blog'>LOGIN/LOGOUT</a></li>
	    </ul>
	    <hr>
	    
	    
	    <h3 class="subscribe">Join the Potato Gang</h3>
	   
	    
	   
	   	<%
	   		
		    ObjectifyService.register(Emails.class);
			
			List<Emails> emails = ObjectifyService.ofy().load().type(Emails.class).list(); 
			System.out.println(emails.toString());
			
			UserService userService = UserServiceFactory.getUserService();
	    	User user = userService.getCurrentUser();
			
	    	pageContext.setAttribute("user", user);
	    	
	    	if (user == null){
	    		%>
				<p class="subscribe"><a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>	
				to subscribe or unsubscribe.</p>
				<%
	    		
	    	} else {
	    		
	    		Key<Emails> key = Key.create(Emails.class, user.getEmail());
		    	Emails email = ObjectifyService.ofy().load().key(key).now();
		    	if (!emails.isEmpty() && email != null){
		    		//this email is in the subscription list
		    		%>
		    			<p class="subscribe">You are already subscribed in as ${fn:escapeXml(user.nickname)}!<br>
		    			<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign out</a> to use subscribe with another email.
		    			<br>Or click unsubscribe below to stop receiving potato updates.</p>
				    	<form class="subscribe" action="/newsletter" method="post">		
					      <div><input type="submit" value="Unsubscribe" /></div>   
					    </form>
			    			    		
			    	<%
		    	} else {
		    		
		    		%>
		    			<p class="subscribe">Do you want to get your daily potato updates? Click subscribe below!</p>
		    			<p class="subscribe">You are signed in as ${fn:escapeXml(user.nickname)}! <br>
		    			<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign out</a> to use subscribe with another email.</p>
				    	<form class="subscribe" action="/newsletter" method="post">		
					      <div><input type="submit" value="Subscribe" /></div>   
					    </form>
			    			    		
			    	<%
	    
	    		}
	    		
	    		
	    		
	    		
	    		
	    	
	    	}
			
		
		%>
		
				
	</body>

</html>