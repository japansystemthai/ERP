<%-- 
    Document   : Description
    Created on : Jul 22, 2019, 10:35:21 AM
    Author     : pakasit
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        
        <title>Description Page</title>
    </head>
    <body>
        <h1 align="center">Description</h1>
        <% String line = request.getParameter("line"); 
           String desfrommain = request.getParameter("des"); 
        %>
        <table align="center" style="width: 90%">
            <tr>
                <td ><textarea id="despopup" class="form-control" rows="20" ><%= desfrommain %></textarea></td>
            </tr>
            <tr><td><button class="btn btn-success" id="buttontable" onclick="sendback()">OK</button>
                <button class="btn btn-danger" id="back" name="Back" type="button" onclick="closepop()">Back</button></td></tr>
        </table>

        <input  hidden id="line" value='<%= line %>' >
        <script>
                function sendback() {
                    var line = document.getElementById("line").value;
                    var msg = document.getElementById("despopup").value;
                                if (window.opener !== null && !window.opener.closed) {
                                    var txtName = window.opener.document.getElementById("description"+line);
                                    txtName.value = msg.toString();
                                }
                    window.close();
                }

            function closepop() {
                    window.close();
                }
        </script>
    </body>
</html>
