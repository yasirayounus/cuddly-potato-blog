<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.Collections" %>

<%@ page import="java.util.List" %>

<%@ page import="blog.Post" %>

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
	    <h2>Create a Post</h2>
	<%

    	UserService userService = UserServiceFactory.getUserService();
    	User user = userService.getCurrentUser();

    	if (user != null) {
      		pageContext.setAttribute("user", user);
	%>
			<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
			<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
			<form action="/sign" method="post">	
			  <div>
			  	<h3>TITLE</h3>
			  	<textarea id="title_input" name="title" rows="1" cols="60" maxlength="60"></textarea>
			  </div>
			 
		      <div>
		      	<h3>CONTENT</h3>
		      	<textarea id = "content_input" name="content" rows="10" cols="60"></textarea></div>
		
		      <div><input type="submit" value="Post" /></div>   
		      <div><input type="reset" value="Cancel" /></div>  
		    </form>
		    
			
	<%
    	} else {
	%>
			<p>Hello!
	
			<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
	
			to be able to post.</p>
	<%
    	}
	%>


    
 

  </body>

</html>