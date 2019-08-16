<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %> 
<%--<%@ page contentType="text/csv; charset=UTF-8" %>--%>

<%
    try {
        
        Connection conn = null;//create connection.
        String driver = "com.mysql.jdbc.Driver";//Check mysql jdbc Driver add from Libraries.
        String dbName = "erp1";//Database Name.
        String userId = "root";//Username.
        String password = "1234";//Password.
        Statement stmt;//Used for storing sql commands.


        String date, time, dateu, timeu,custid;
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");//set Date Format because the information taken from create_customer page is type String.
        LocalDate localDate = LocalDate.now();                            //but data type in database is date So the data must be converted from String to Date.
        date = dtf.format(localDate);

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH_mm_ss");//set Time Format because the information taken from create_customer page is type String.
        time = sdf.format(cal.getTime());                       //but data type in database is time So the data must be converted from String to time.


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
            OutputStream outputStream = response.getOutputStream();//OutputStream is Writing data out, we will do it through the OutputStream (the flow way: flow out of our program) byte data in our program. Will be sent to the destination (file) automatically.
            outputStream.write(0xEF);
            outputStream.write(0xBB);
            outputStream.write(0xBF);
            
            String outputResult = "Item No, Item Name EN, Item Name TH, Size, Spec, Customer ID, Current ID, Standard Price,"
                    + " Material Unit Price, Process, Date of Registeration, Time of Registertion, FLG1, Date of Update, Time of Update, FLG2\n";
            outputStream.write(outputResult.getBytes());
            while (rs.next()) {//while loop for writing data on csv files
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
                if (rs.getString(6) == null) {// If custid is null, it stores the null value that is a string.
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
                if (rs.getString(14) == null) {// If the date is null, it stores the null value that is a string.
                    dateu = "null";
                } else {
                    dateu = rs.getString(14);
                }
                outputStream.write(dateu.getBytes());
                outputStream.write(",".getBytes());
                if (rs.getString(15) == null) {// If the time is null, it stores the null value that is a string.
                    timeu = "null";
                } else {
                    timeu = rs.getString(15);
                }
                outputStream.write(timeu.getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(16).getBytes());
                outputStream.write("\n".getBytes());
            }
            outputStream.flush();//write file
            outputStream.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }

    } catch (Exception e) {

        e.printStackTrace();

    }

%>