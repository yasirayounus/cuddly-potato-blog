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
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
 </head>

 

  <body>

 

<%

    /* String guestbookName = request.getParameter("guestbookName");

    if (guestbookName == null) {

        guestbookName = "default";

    } 

    pageContext.setAttribute("guestbookName", guestbookName);*/

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>

<%

    } else {

%>

<p>Hello!

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

to be able to post.</p>

<%

    }

%>

 

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

        <p>Posts in Cuddly Potato Blog.</p>

        <%

        for (Post post : posts) {

            pageContext.setAttribute("post_content", post.getContent());

            pageContext.setAttribute("post_user", post.getUser());
            
            pageContext.setAttribute("post_date", post.getDate());
            
            pageContext.setAttribute("post_title", post.getTitle());

                %>
				<h1><b>${fn:escapeXml(post_title)}</b></h1>
				
                <p>Written by: ${fn:escapeXml(post_user.nickname)}</p>
                
                <!--Check to see if date is formatted correctly-->
                <p>Posted on: ${fn:escapeXml(post_date)}</p>


            <p>${fn:escapeXml(post_content)}</p>

            <%

        }

    }

%>

 

    <form action="/ofysign" method="post">

      <div><textarea name="content" rows="3" cols="60"></textarea></div>

      <div><input type="submit" value="Post Greeting" /></div>

      <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>

    </form>

 

  </body>

</html>