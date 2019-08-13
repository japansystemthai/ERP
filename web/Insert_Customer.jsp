<%-- 
    Document   : InsertP
    Created on : May 7, 2019, 2:53:12 PM
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

 
  String cus_code,cus_name_en,name,type,indust,tel,email,website,st,su,city,region,stat,zip,country,taxid,date,time;
  
  cus_code = request.getParameter("Cust_Code"); 
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
 time = sdf.format(cal.getTime() );

  
  PreparedStatement pstmt=null; //create statement 
  
  pstmt=connect.prepareStatement("INSERT INTO erp1.customer(CUST_CD,CUST_NAME_EN,CUST_NAME,TYPE,INDUST,TEL,EMAIL,WEBSITE,ADDR_ST,ADDR_SU,ADDR_CITY,ADDR_REG,ADDR_STAT,ADDR_ZIP,ADDR_COUNT,TAX_ID,REG_DATE,REG_TIME)VALUES"
          + "                    (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"); //sql insert query 
  
  pstmt.setString(1,cus_code); 
  pstmt.setString(2,cus_name_en); 
  pstmt.setString(3,name); 
  pstmt.setString(4,type); 
  pstmt.setString(5,indust); 
  pstmt.setString(6,tel); 
  pstmt.setString(7,email); 
  pstmt.setString(8,website); 
  pstmt.setString(9,st); 
  pstmt.setString(10,su); 
  pstmt.setString(11,city); 
  pstmt.setString(12,region); 
  pstmt.setString(13,stat); 
  pstmt.setString(14,zip); 
  pstmt.setString(15,country); 
  pstmt.setString(16,taxid); 
  pstmt.setString(17,date); 
  pstmt.setString(18,time); 

  pstmt.executeUpdate(); //execute query
  
  connect.close();  //close connection 
  
  out.println("Insert Successfully...! Click Back link.");// after insert record successfully message
  
 
 
}
catch(Exception e)
{
 out.println(e);
}

%>
       <meta http-equiv= refresh content= 1;URL=Customer_Master.jsp>


