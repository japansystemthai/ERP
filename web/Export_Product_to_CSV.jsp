<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %> 
<%--<%@ page contentType="text/csv; charset=UTF-8" %>--%>

<%
    try {
        
        Connection conn = null;
        String id = request.getParameter("userId");
        String driver = "com.mysql.jdbc.Driver";
        String connectionUrl = "jdbc:mysql://localhost:3306/";
        String dbName = "erp1";
        String userId = "root";
        String password = "1234";
        Integer i = 1;
        Statement stmt;

        String Content = new String("");

        String date, time, dateu, timeu,custid;
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate localDate = LocalDate.now();
        date = dtf.format(localDate);

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH_mm_ss");
        time = sdf.format(cal.getTime());

        String filename = "Product_CSV_" + date + "_" + time + ".csv";

        Class.forName("com.mysql.jdbc.Driver").newInstance();

        Class.forName(driver).newInstance();
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbName+"?useUnicode=yes&characterEncoding=UTF-8",userId, password);

        String query = "select * from product";
        stmt = conn.createStatement();

        ResultSet rs = stmt.executeQuery(query);
        
       
        
//        response.setContentType("text/csv");
//        response.setHeader("Content-Encoding", "UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=" + filename);
//        response.setCharacterEncoding("UTF-8");
//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html;charset=UTF-8/csv");
//        response.setCharacterEncoding("UTF-8");
//        response.setContentType("application/x-msexcel;charset=Unicode");
        
        try {
            OutputStream outputStream = response.getOutputStream();
            outputStream.write(0xEF);
            outputStream.write(0xBB);
            outputStream.write(0xBF);
            
            String outputResult = "Item No, Item Name EN, Item Name TH, Size, Spec, Customer ID, Current ID, Standard Price,"
                    + " Material Unit Price, Process, Date of Registeration, Time of Registertion, FLG1, Date of Update, Time of Update, FLG2\n";
            outputStream.write(outputResult.getBytes());
            while (rs.next()) {
                outputStream.write(rs.getString(1).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(2).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(3).getBytes(StandardCharsets.UTF_8));
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(4).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(5).getBytes());
                outputStream.write(",".getBytes());
                if (rs.getString(6) == null) {
                    custid = "null";
                } else {
                    custid = rs.getString(6);
                }
                outputStream.write(custid.getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(7).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(8).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(9).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(10).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(11).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(12).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(13).getBytes());
                outputStream.write(",".getBytes());
                if (rs.getString(14) == null) {
                    dateu = "null";
                } else {
                    dateu = rs.getString(14);
                }
                outputStream.write(dateu.getBytes());
                outputStream.write(",".getBytes());
                if (rs.getString(15) == null) {
                    timeu = "null";
                } else {
                    timeu = rs.getString(15);
                }
                outputStream.write(timeu.getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(16).getBytes());
                outputStream.write("\n".getBytes());
            }
            outputStream.flush();
            outputStream.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }

    } catch (Exception e) {

        e.printStackTrace();

    }

%>