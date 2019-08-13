<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.sql.*" %>  

<%
    try {
        String driverName = "com.mysql.jdbc.Driver";
        String connectionUrl = "jdbc:mysql://localhost:3306/";
        String dbName = "erp1";
        String userId = "root";
        String password = "1234";

        try {
            Class.forName(driverName);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        Connection connect = null;

        connect = DriverManager.getConnection(connectionUrl + dbName, userId, password);

        String date, time;
        String strProductID = request.getParameter("ProID");
        String strCustomerID = request.getParameter("CusID");
        String strQuotationID = request.getParameter("QTID");

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate localDate = LocalDate.now();
        date = dtf.format(localDate);

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        time = sdf.format(cal.getTime());

        PreparedStatement pstmt = null; //create statement 

        if (strCustomerID != null) {
            pstmt = connect.prepareStatement("UPDATE erp1.customer SET FLG1 = 1,UPD_DATE = ?,UPD_TIME = ?,FLG2 = 1 " + " WHERE CUST_ID = '" + strCustomerID + "'"); //sql update query 

            pstmt.setString(1, date);
            pstmt.setString(2, time);

            pstmt.executeUpdate(); //execute query

            connect.close();


%>
<meta http-equiv= refresh content= 0;URL=Customer_Master.jsp>

<%        } else if (strProductID != null) {

    pstmt = connect.prepareStatement("UPDATE erp1.product SET FLG1 = 1,UPD_DATE = ?,UPD_TIME = ?,FLG2 = 1  WHERE ITEM_NO = ?"); //sql update query 

    pstmt.setString(1, date);
    pstmt.setString(2, time);
    pstmt.setString(3,strProductID );

    pstmt.executeUpdate(); //execute query

    connect.close();
%>
<meta http-equiv= refresh content= 0;URL=Product_Master.jsp>

<%
        }
else if (strQuotationID != null) {

    pstmt = connect.prepareStatement("UPDATE erp1.qt_head SET FLG1 = 1,UPD_DATE = ?,UPD_TIME = ?,FLG2 = 1  WHERE QT_ID = ?"); //sql update query 

    pstmt.setString(1, date);
    pstmt.setString(2, time);
    pstmt.setString(3,strQuotationID );

    pstmt.executeUpdate(); //execute query

    connect.close();
%>
<meta http-equiv= refresh content= 0;URL=Quotation.jsp>

<%
        }

    } catch (Exception e) {
        // TODO Auto-generated catch block
        out.println(e.getMessage());
        e.printStackTrace();
    }
%>
</body>
</html>