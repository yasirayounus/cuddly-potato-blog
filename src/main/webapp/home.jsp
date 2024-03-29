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
	    
	   	<%
		    ObjectifyService.register(Post.class);
		
			List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list();   
		
			Collections.sort(posts); 
		
		    if (posts.isEmpty()) {
		%>
				<p>Cuddly Potato Blog has no posts.</p>
		<%
    		} else {
        %>
        			<h2> Most Recent Posts</h2>
        	<%
        		int c = 0;
        		for (Post post : posts) {
					
        			if (c < 5) {
	            		pageContext.setAttribute("post_content", post.getContent());
					
	            		pageContext.setAttribute("post_user", post.getUser());
	            
	            		pageContext.setAttribute("post_date", post.getDate());
	            
	            		pageContext.setAttribute("post_title", post.getTitle());
	            		
	            		c++;
        			
    		
        	%>
       				<div class="recent_posts">
					<h3><b>${fn:escapeXml(post_title)}</b></h3>
						
		            <p class="post_info">Written by: ${fn:escapeXml(post_user.nickname)}</p>
		                
		            <!--Check to see if date is formatted correctly-->
		            <p class="post_info">Posted on: ${fn:escapeXml(post_date)}</p>
		
		
		            <p>${fn:escapeXml(post_content)}</p>	
		            <hr class="post_separator">
		            </div>
		            
        <% 
        			}
        		}
    		}
        %>
	</body>

</html>