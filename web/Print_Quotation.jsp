<%@page import="java.io.*" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Map" %>
<%@page import="net.sf.jasperreports.engine.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<html>
    <head>
         <link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>PDF</title>


    </head>

    <body>

        <%
            Connection conn = null;//create connections.
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp1", "root", "1234");//connect dabase
                File reportFile = new File(application.getRealPath("//report//quotation.jasper"));//The path that records the location of the jasper file.
                String QTID = request.getParameter("qtid");
                Map parameters = new HashMap();// On the jasper request 1 parameters so we create parameters for this.
                parameters.put("qt_id",QTID);
                parameters.put("qt_id1",QTID);
                byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, conn);
                
               
                
                response.setContentType("application/pdf");//Set recording type.
                response.setContentLength(bytes.length);
                
                ServletOutputStream outStream = response.getOutputStream();
                
                outStream.write(bytes, 0, bytes.length);
                outStream.flush();//write file.
                outStream.close();
                

            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }


        %>






    </body>






</html>




