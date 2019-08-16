<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %> 

<%
    try {
        Connection conn = null;//create connection.
        String driver = "com.mysql.jdbc.Driver";//Check mysql jdbc Driver add from Libraries.
        String connectionUrl = "jdbc:mysql://localhost:3306/";
        String dbName = "erp1";//Database Name.
        String userId = "root";//Username.
        String password = "1234";//Password.
        Statement stmt;//Used for storing sql commands.

        String date, time, dateu, timeu;
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");//set Date Format because the information taken from create_customer page is type String.
        LocalDate localDate = LocalDate.now();                            //but data type in database is date So the data must be converted from String to Date.
        date = dtf.format(localDate);

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH_mm_ss");//set Time Format because the information taken from create_customer page is type String.
        time = sdf.format(cal.getTime());                       //but data type in database is time So the data must be converted from String to time.

        String filename = "Customer_CSV_" + date + "_" + time + ".csv";//create filename.

        Class.forName("com.mysql.jdbc.Driver").newInstance();

        Class.forName(driver).newInstance();
        conn = DriverManager.getConnection(connectionUrl + dbName, userId, password);//connect Database
        String query = "select * from customer";//sql select query.
        stmt = conn.createStatement();

        ResultSet rs = stmt.executeQuery(query);//execute query.
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/csv");//Set recording type.
        response.setHeader("Content-Disposition", "attachment; filename=" + filename);//set filename.
        try {
            OutputStream outputStream = response.getOutputStream();//OutputStream is Writing data out, we will do it through the OutputStream (the flow way: flow out of our program) byte data in our program. Will be sent to the destination (file) automatically.
            outputStream.write(0xEF);
            outputStream.write(0xBB);
            outputStream.write(0xBF);
            
            String outputResult = "Customer ID, Customer Code, Customer Name EN, Customer Name, Type, Industry, Telephone, E-mail,"
                    + " Website, Street/Building, Suit/Apartment,City,Region,State/Province,Zip,Country,TAX ID,Date of Registeration, Time of Registeration, FLG1, Date of Update, Time of Update, FLG2\n";//Create column header.
            outputStream.write(outputResult.getBytes());
            while (rs.next()) {//while loop for writing data on csv files
                outputStream.write(rs.getString(1).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(2).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(3).getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(4).getBytes(StandardCharsets.UTF_8));//set StandardCharsets.UTF_8 because it can use Thai language.
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
                if (rs.getString(21) == null) {// If the date is null, it stores the null value that is a string.
                    dateu = "null";
                } else {
                    dateu = rs.getString(21);
                }
                outputStream.write(dateu.getBytes());
                outputStream.write(",".getBytes());
                if (rs.getString(22) == null) {//If the time is null, it stores the null value that is a string.
                    timeu = "null";
                } else {
                    timeu = rs.getString(22);
                }
                outputStream.write(timeu.getBytes());
                outputStream.write(",".getBytes());
                outputStream.write(rs.getString(23).getBytes());
                outputStream.write("\n".getBytes());
            }
            outputStream.flush();//Write file
            outputStream.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }

    } catch (Exception e) {

        e.printStackTrace();

    }

%>