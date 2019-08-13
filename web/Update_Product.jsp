<%-- 
    Document   : Update_Product
    Created on : May 13, 2019, 4:47:21 PM
    Author     : pakasit
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.sql.*" %>  
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>  

<%
try
{ 
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
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
	Statement s = null;
	ResultSet resultSet = null;
        
        
//        connect = DriverManager.getConnection(connectionUrl+dbName, userId, password);
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbName+"?useUnicode=yes&characterEncoding=UTF-8",userId, password);
        
        
	s = connect.createStatement();

 
        String item_no,item_eng,item_th,size,spec,date,time;
        Integer cus_id,currency,flg1;
        Float  standard_price, mt_unit_price, process_price;
        
        item_no = request.getParameter("item_no");  
        item_eng = request.getParameter("item_eng");
        item_th = request.getParameter("item_th");
        size = request.getParameter("size"); 
        spec = request.getParameter("spec");
        cus_id = Integer.parseInt(request.getParameter("customer_id"));
        currency = Integer.parseInt(request.getParameter("cur_id"));
        standard_price = Float.parseFloat(request.getParameter("standard_price").replace(",",""));
        mt_unit_price = Float.parseFloat(request.getParameter("mt_unit_price").replace(",",""));
        process_price = Float.parseFloat(request.getParameter("process_price").replace(",",""));
        flg1 = Integer.parseInt("1");
        
        
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate localDate = LocalDate.now();
        date = dtf.format(localDate);

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        time = sdf.format(cal.getTime() );

        PreparedStatement pstmt=null; //create statement 

        pstmt=connect.prepareStatement("UPDATE erp1.product "
          + "SET ITEM_NAME_EN = ?,ITEM_NAME_TH = ?,SIZE = ?,SPEC = ?,CUST_ID = ?,CURR_ID=?,ST_PRICE = ?,MT_UNIT_PRICE = ?,PROC_PRICE = ?,"
          + "UPD_DATE = ?,UPD_TIME = ?,FLG1=? WHERE ITEM_NO = ?;");
        
//        pstmt.setString(1,item_no);     
        pstmt.setString(1,item_eng); 
        pstmt.setString(2,item_th); 
        pstmt.setString(3,size); 
        pstmt.setString(4,spec); 
        pstmt.setInt(5,cus_id);
        pstmt.setInt(6,currency);
        pstmt.setFloat(7,standard_price); 
        pstmt.setFloat(8,mt_unit_price); 
        pstmt.setFloat(9,process_price); 
        pstmt.setString(10,date); 
        pstmt.setString(11,time);
        pstmt.setInt(12,flg1);
        pstmt.setString(13,item_no);
        
        
        pstmt.executeUpdate(); //execute query

        connect.close();  //close connection 

        out.println("Update Successfully...!");// after insert record successfully message

        

      }
      catch(Exception e)
      {
       out.println(e);
        
      }

      %>
      <meta http-equiv=refresh content=1;URL=Product_Master.jsp>