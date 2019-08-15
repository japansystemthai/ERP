<%-- 
    Document   : insert_Product
    Created on : May 9, 2019, 5:20:41 PM
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
        
        String driverName = "com.mysql.jdbc.Driver";//Check mysql jdbc Driver add from Libraries.
//	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String dbName = "erp1";//DataBase Name.
	String userId = "root";//Username.
	String password = "1234";//Password.
    
	
	try {
		Class.forName(driverName);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
        Connection connect = null;
//	Statement s = null;
//	ResultSet resultSet = null;
        
        
//        connect = DriverManager.getConnection(connectionUrl+dbName, userId, password);
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbName+"?useUnicode=yes&characterEncoding=UTF-8",userId, password);//Connect Database.
        
//	s = connect.createStatement();

        Statement statementC = null;
        ResultSet resultC = null;
        statementC = connect.createStatement();//statementC and resultC use for count item_no if item_no hive already in database. 
                                               // User will have to enter new information.
        
        String item_no,item_eng,item_th,size,spec,cus_id,currency,standard_price,mt_unit_price,process_price,date,time;
                //getParameter from Create Product Page.
                item_no = request.getParameter("item_no");  
                item_eng = request.getParameter("item_eng");
                item_th = request.getParameter("item_th");
                size = request.getParameter("size"); 
                spec = request.getParameter("spec");
                cus_id = request.getParameter("cus_id");
                currency = request.getParameter("currency");
                standard_price = request.getParameter("standard_price");
                mt_unit_price = request.getParameter("mt_unit_price");
                process_price = request.getParameter("process_price");
        
        String sql = "select count(item_no)as C_item_no from product where ITEM_NO='"+item_no+"'"; // sql for count item_no.
        resultC = statementC.executeQuery(sql);//execute query.
        
        while(resultC.next()){ //while loop check item_no have already in datebase.
            Integer itemCount = resultC.getInt("C_item_no");            
            if(itemCount == 1){   
                %><script>alert('ITEM_NO does exist!!! Please Enter New ITEM_NO');window.history.back();</script><%//Message alert when item_no have already.
            }else{
                

                String new_standard_price,new_mt_unit_price,new_process_price;
                new_standard_price = standard_price.replace(",","");//replace "," with "" because in database type is float. float can't record ","(type int is the same).
                new_mt_unit_price = mt_unit_price.replace(",","");
                new_process_price = process_price.replace(",","");

               DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");//set Date Format because the information taken from create_customer page is type String.                                                                  
               LocalDate localDate = LocalDate.now();                            //but data type in database is date So the data must be converted from String to Date.
               date = dtf.format(localDate);

               Calendar cal = Calendar.getInstance();
               SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");//set Time Format because the information taken from create_customer page is type String.
               time = sdf.format(cal.getTime() );                      //but data type in database is time So the data must be converted from String to time.

                PreparedStatement pstmt=null; //create statement 

                        pstmt=connect.prepareStatement("INSERT INTO erp1.product(ITEM_NO,ITEM_NAME_EN,ITEM_NAME_TH,SIZE,SPEC,CUST_ID,CURR_ID,ST_PRICE,MT_UNIT_PRICE,PROC_PRICE,REG_DATE,REG_TIME)VALUES"
                + "                    (?,?,?,?,?,?,?,?,?,?,?,?)"); //sql insert query.
                pstmt.setString(1,item_no); 
                pstmt.setString(2,item_eng); 
                pstmt.setString(3,item_th); 
                pstmt.setString(4,size); 
                pstmt.setString(5,spec); 
                pstmt.setString(6,cus_id); 
                pstmt.setString(7,currency); 
                pstmt.setString(8,new_standard_price); 
                pstmt.setString(9,new_mt_unit_price); 
                pstmt.setString(10,new_process_price); 
                pstmt.setString(11,date);
                pstmt.setString(12,time);


                pstmt.executeUpdate(); //execute query.

                //connect.close();  //close connection 

                out.println("Insert Successfully...!");// after insert record successfully message.

                %><meta http-equiv=refresh content=1;URL=Product_Master.jsp><% //return to Product Master Page.
          }
        }
      }
      catch(Exception e)
      {
       out.println(e);
      }

      %>
