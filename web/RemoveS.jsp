<%-- 
    Document   : test2
    Created on : May 14, 2019, 5:03:22 PM
    Author     : Jira
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
     

        <title>Logout</title>
    </head>

    <body>
        <%
            
            
            session.removeAttribute("sUser");
            session.removeAttribute("username_en");
            session.removeAttribute("userid");
            String user,username,userid;
            
            user = String.valueOf(session.getAttribute("sUser"));
            
            username = String.valueOf(session.getAttribute("username_en"));
            userid = String.valueOf(session.getAttribute("userid"));
            
            out.print(user);
            out.print(username);
            out.print(userid);
              


        %> 
        <p>Please wait.....</p>
    </body>

</html>
<meta http-equiv= refresh content= 1;URL=Login.jsp>
