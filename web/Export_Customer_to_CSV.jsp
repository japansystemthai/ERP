<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %> 

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

        String date, time, dateu, timeu;
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate localDate = LocalDate.now();
        date = dtf.format(localDate);

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH_mm_ss");
        time = sdf.format(cal.getTime());

        String filename = "Customer_CSV_" + date + "_" + time + ".csv";

        Class.forName("com.mysql.jdbc.Driver").newInstance();

        Class.forName(driver).newInstance();
        conn = DriverManager.getConnection(connectionUrl + dbName, userId, password);
        String query = "select * from customer";
        stmt = conn.createStatement();

        ResultSet rs = stmt.executeQuery(query);
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=" + filename);
        try {
            OutputStream outputStream = response.getOutputStream();
            outputStream.write(0xEF);
            outputStream.write(0xBB);
            outputStream.write(0xBF);
            
            String outputResult = "Customer ID, Customer Code, Customer Name EN, Customer Name, Type, Industry, Telephone, E-mail,"
                    + " Website, Street/Building, Suit/Apartment,City,Region,State/Province,Zip,Country,TAX ID,Date of Registeration, Time of Registeration, FLG1, Date of Update, Time of Update, FLG2\n";
            outputStream.write(outputResult.getBytes());
            while (rs.next()) {
                outputStream.write(rs.getString(1).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(2).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(3).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(4).getBytes(StandardCharsets.UTF_8));
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(5).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(6).getBytes());
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
                outputStream.write(rs.getString(14).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(15).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(16).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(17).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(18).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(19).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(20).getBytes());
                outputStream.write(",".getBytes());
                if (rs.getString(21) == null) {
                    dateu = "null";
                } else {
                    dateu = rs.getString(21);
                }
                outputStream.write(dateu.getBytes());
                outputStream.write(",".getBytes());
                if (rs.getString(22) == null) {
                    timeu = "null";
                } else {
                    timeu = rs.getString(22);
                }
                outputStream.write(timeu.getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(23).getBytes());
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