<%-- 
    Document   : EditP
    Created on : May 8, 2019, 2:08:44 PM
    Author     : Jira
--%>
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

        String cus_name_en, cus_cd, name, type, indust, tel, email, website, st, su, city, region, stat, zip, country, taxid, date, time,ed_name;
        Integer cus_id;

        cus_id = Integer.parseInt(request.getParameter("cus_id"));
        cus_cd = request.getParameter("Cust_Code");
        cus_name_en = request.getParameter("Cust_Name_EN");
        name = request.getParameter("Cust_Name"); //txt_owner
        type = request.getParameter("Type"); //txt_owner
        indust = request.getParameter("Indust"); //txt_owner
        tel = request.getParameter("phone_number"); //txt_owner
        email = request.getParameter("e_mail"); //txt_owner
        website = request.getParameter("Website"); //txt_owner
        st = request.getParameter("Address"); //txt_owner
        su = request.getParameter("Suite"); //txt_owner
        city = request.getParameter("City"); //txt_owner
        region = request.getParameter("Region"); //txt_owner
        stat = request.getParameter("Stat"); //txt_owner
        zip = request.getParameter("Zip"); //txt_owner
        country = request.getParameter("Country"); //txt_owner
        taxid = request.getParameter("Taxid"); //txt_owner

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate localDate = LocalDate.now();
        date = dtf.format(localDate);

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        time = sdf.format(cal.getTime());
        ed_name = String.valueOf(session.getAttribute("username_en"));

        PreparedStatement pstmt = null; //create statement 

        pstmt = connect.prepareStatement("UPDATE erp1.customer "
                + "SET CUST_CD = ?, CUST_NAME_EN = ?,CUST_NAME = ?,TYPE = ?,INDUST = ?,TEL = ?,EMAIL = ?,WEBSITE = ?,ADDR_ST = ?,ADDR_SU = ?,"
                + "ADDR_CITY = ?,ADDR_REG = ?,ADDR_STAT = ?,ADDR_ZIP = ?,ADDR_COUNT = ?,TAX_ID = ?,UPD_DATE = ?,UPD_TIME = ?,ED_NAME = ?"
                + "WHERE CUST_ID = ?;"); //sql update query 

        pstmt.setString(1, cus_cd);
        pstmt.setString(2, cus_name_en);
        pstmt.setString(3, name);
        pstmt.setString(4, type);
        pstmt.setString(5, indust);
        pstmt.setString(6, tel);
        pstmt.setString(7, email);
        pstmt.setString(8, website);
        pstmt.setString(9, st);
        pstmt.setString(10, su);
        pstmt.setString(11, city);
        pstmt.setString(12, region);
        pstmt.setString(13, stat);
        pstmt.setString(14, zip);
        pstmt.setString(15, country);
        pstmt.setString(16, taxid);
        pstmt.setString(17, date);
        pstmt.setString(18, time);
        pstmt.setString(19, ed_name);
        pstmt.setInt(20, cus_id);

        pstmt.executeUpdate(); //execute query

        connect.close();  //close connection 
        
        

        out.println("Update Successfully...! Click Back link.");// after insert record successfully message

    } catch (Exception e) {
        out.println(e);
    }

%>
<meta http-equiv= refresh content= 1;URL=Customer_Master.jsp>