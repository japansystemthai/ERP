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
            Connection conn = null;
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp1", "root", "1234");
                File reportFile = new File(application.getRealPath("//report//customerreport.jasper"));
                byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), null, conn);

                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                ServletOutputStream outStream = response.getOutputStream();
                outStream.write(bytes, 0, bytes.length);
                outStream.flush();
                outStream.close();

            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }


        %>






    </body>






</html>




