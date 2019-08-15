<%-- 
    Document   : Update_Quotation
    Created on : Jun 6, 2019, 10:19:21 AM
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
    try {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String driverName = "com.mysql.jdbc.Driver";//Check mysql jdbc Driver add from Libraries.
	String dbName = "erp1";//DataBase Name.
	String userId = "root";//Username.
	String password = "1234";//Password.

        try {
            Class.forName(driverName);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        Connection connect = null;//Create Connection

//        connect = DriverManager.getConnection(connectionUrl+dbName, userId, password);
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + dbName + "?useUnicode=yes&characterEncoding=UTF-8", userId, password);//Connect Database

        String od_no, od_cust_id;
        String od_contact, od_cont_tel, od_name, od_stats,od_pay_stat, od_odate;
        String od_cur_id;
        String od_user_id;
        String od_comm, od_delivery_date, od_pay_date, reg_date, reg_time, upd_date, upd_time;

        String date, time;

        float od_amt, od_amt_wotax, od_discount, od_subtotal, od_vat;
        int od_flg1 = 1, flg1 = 1, od_id, save_counter;

        //getParameter from Edit Sales Order Page.
        od_id = Integer.parseInt(request.getParameter("od_id"));
        od_no = request.getParameter("od_no");
        od_cust_id = request.getParameter("customer_id");
        od_contact = request.getParameter("contact");
        od_cont_tel = request.getParameter("contact_tel");
        od_name = request.getParameter("subject");
        od_stats = request.getParameter("od_status");
        od_pay_stat = request.getParameter("od_pay_stat");
        od_odate = request.getParameter("od_odate");
        od_cur_id = request.getParameter("currency");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");//set Date Format because the information taken from create_customer page is type String.
        LocalDate localDate = LocalDate.now();                            //but data type in database is date So the data must be converted from String to Date.
        date = dtf.format(localDate);
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");//set Time Format because the information taken from create_customer page is type String.
        time = sdf.format(cal.getTime());                       //but data type in database is time So the data must be converted from String to time.
        od_user_id = request.getParameter("sales");
        od_comm = request.getParameter("comment");
        od_amt = Float.parseFloat(request.getParameter("od_amt").replace(",", ""));//replace "," with "" because in database type is float. float can't record ","(type int is the same).
        od_amt_wotax = Float.parseFloat(request.getParameter("od_amt_wotax").replace(",", ""));
        od_discount = Float.parseFloat(request.getParameter("od_discount").replace(",", ""));
        od_subtotal = Float.parseFloat(request.getParameter("od_subtotal").replace(",", ""));
        od_vat = Float.parseFloat(request.getParameter("od_vat").replace(",", ""));
        od_delivery_date = request.getParameter("od_delivery_date");
        od_pay_date = request.getParameter("od_pay_date");
        upd_date = date;
        upd_time = time;
        reg_date = date;
        reg_time = time;
        save_counter = Integer.parseInt(request.getParameter("save_counter"));//save_counter is Number of Product in Sales Order Page
        
         if (save_counter == 0) {//If there is no product. return to Sales Order Page.%>

       <script>alert('Please Enter Product');</script><!--Message alert when there is no product-->
       <meta http-equiv= refresh content= 1;URL=Sales_Order.jsp><!-- Return to Sales Order Page -->

<%
    } else {
        

//
        PreparedStatement pstmt = null, pstmtd = null, pstmtds = null; //create statement.
//
        pstmt = connect.prepareStatement("UPDATE erp1.od_head "
                + "SET OD_NO = ?,OD_CUST_ID = ?,OD_CONTACT=?,OD_CONT_TEL = ?,OD_NAME = ?,OD_STATS = ?,OD_PAY_STAT = ?,"
                + "OD_ODATE = ?,OD_CUR_ID = ?,"
                + "OD_FLG1=?,OD_USER_ID = ?,"
                + "OD_COMM = ?,OD_AMT = ?,OD_AMT_WOTAX = ?,OD_DISCOUNT = ?,OD_SUBTOTAL = ?,OD_VAT = ?,OD_DELIVERY_DATE = ?,OD_PAY_DATE = ?,FLG1 = ?,UPD_DATE = ?,UPD_TIME = ?"
                + "WHERE OD_ID = ?;");//sql update query. 
        
        

        pstmt.setString(1, od_no);
        pstmt.setString(2, od_cust_id);
        pstmt.setString(3, od_contact);
        pstmt.setString(4, od_cont_tel);
        pstmt.setString(5, od_name);
        pstmt.setString(6, od_stats);
        pstmt.setString(7, od_pay_stat);
        pstmt.setString(8, od_odate);
        pstmt.setString(9, od_cur_id);
        pstmt.setInt(10, od_flg1);
        pstmt.setString(11, od_user_id);
        pstmt.setString(12, od_comm);
        pstmt.setFloat(13, od_amt);
        pstmt.setFloat(14, od_amt_wotax);
        pstmt.setFloat(15, od_discount);
        pstmt.setFloat(16, od_subtotal);
        pstmt.setFloat(17, od_vat);
        pstmt.setString(18, od_delivery_date);
        pstmt.setString(19, od_pay_date);
        pstmt.setInt(20, flg1);
        pstmt.setString(21, upd_date);
        pstmt.setString(22, upd_time);
        pstmt.setInt(23, od_id);
        pstmt.executeUpdate(); //execute query

        //connect.close();  //close connection 
        pstmtd = connect.prepareStatement("UPDATE erp1.od_detail SET "
                + "ODD_OD_ID = ?,"
                + "ODD_LINENO = ?,"
                + "ODD_ITEM_NO = ?,"
                + "ODD_DES_HEAD = ?,"
                + "ODD_DEST = ?,"
                + "ODD_UNIT_PRICE = ?,"
                + "ODD_QTY = ?,"
                + "ODD_AMT = ?,"
                + "ODD_DISC_PERCENT = ?,"
                + "ODD_DISC_AMOUNT = ?,"
                + "ODD_AMT_A_DISC = ?,"
                + "FLG1 = ?,"
                + "UPD_DATE = ?,"
                + "UPD_TIME = ? "
                + "WHERE ODD_OD_ID = ? and ODD_LINENO = ?;"); //sql update query. 
          
        String selectpro;

        int odd_qty,odd_lineno, countPro;
        String odd_od_ids, odd_dest,odd_des_head;
        float odd_dis_amt, odd_dis_per, odd_amt, odd_unit_per_price, odd_amt_a_dis;
        int y = 0;
        odd_od_ids = request.getParameter("od_id");        
        countPro = Integer.parseInt(request.getParameter("countPro"));
        

        if (countPro == save_counter) {//countPro is Number of Product in Database.Identified by ID that get from Edit Sales Order.
            for (int i = 1; i <= countPro; i++) {// If the number of products does not change
                odd_lineno = Integer.parseInt(request.getParameter("line" + i));
                selectpro = request.getParameter("product" + i);
                odd_des_head = request.getParameter("deshead" + i);
                odd_dest = request.getParameter("description" + i);
                odd_unit_per_price = Float.parseFloat(request.getParameter("unit_price" + i).replace(",", ""));
                odd_qty = Integer.parseInt(request.getParameter("quantity" + i));
                odd_amt = Float.parseFloat(request.getParameter("amount" + i).replace(",", ""));
                odd_dis_per = Float.parseFloat(request.getParameter("discount_per" + i).replace(",", ""));
                odd_dis_amt = Float.parseFloat(request.getParameter("discountamt" + i).replace(",", ""));
                odd_amt_a_dis = Float.parseFloat(request.getParameter("amount_after" + i).replace(",", ""));

                pstmtd.setInt(1, od_id);
                pstmtd.setInt(2, odd_lineno);
                pstmtd.setString(3, selectpro);
                pstmtd.setString(4, odd_des_head);
                pstmtd.setString(5, odd_dest);
                pstmtd.setFloat(6, odd_unit_per_price);
                pstmtd.setInt(7, odd_qty);
                pstmtd.setFloat(8, odd_amt);
                pstmtd.setFloat(9, odd_dis_per);
                pstmtd.setFloat(10, odd_dis_amt);
                pstmtd.setFloat(11, odd_amt_a_dis);
                pstmtd.setFloat(12, flg1);
                pstmtd.setString(13, upd_date);
                pstmtd.setString(14, upd_time);
                pstmtd.setInt(15, od_id);
                pstmtd.setInt(16, odd_lineno);
                pstmtd.executeUpdate();

            }
            
        } 
        else if (countPro < save_counter) {//If the number of products in the database is less than the number of products on the Edit Sales Order page.

            int add;
            add = save_counter - countPro;

            for (int i = 1; i <= countPro; i++) {
                odd_lineno = Integer.parseInt(request.getParameter("line" + i));
                selectpro = request.getParameter("product" + i);
                odd_des_head = request.getParameter("deshead" + i);
                odd_dest = request.getParameter("description" + i);
                odd_unit_per_price = Float.parseFloat(request.getParameter("unit_price" + i).replace(",", ""));
                odd_qty = Integer.parseInt(request.getParameter("quantity" + i));
                odd_amt = Float.parseFloat(request.getParameter("amount" + i).replace(",", ""));
                odd_dis_per = Float.parseFloat(request.getParameter("discount_per" + i).replace(",", ""));
                odd_dis_amt = Float.parseFloat(request.getParameter("discountamt" + i).replace(",", ""));
                odd_amt_a_dis = Float.parseFloat(request.getParameter("amount_after" + i).replace(",", ""));
//            qtd_id = Integer.parseInt(request.getParameter(splitqtdid[i]));
                pstmtd.setString(1, odd_od_ids);
                pstmtd.setInt(2, odd_lineno);
                pstmtd.setString(3, selectpro);
                pstmtd.setString(4, odd_des_head);
                pstmtd.setString(5, odd_dest);
                pstmtd.setFloat(6, odd_unit_per_price);
                pstmtd.setInt(7, odd_qty);
                pstmtd.setFloat(8, odd_amt);
                pstmtd.setFloat(9, odd_dis_per);
                pstmtd.setFloat(10, odd_dis_amt);
                pstmtd.setFloat(11, odd_amt_a_dis);
                pstmtd.setFloat(12, flg1);
                pstmtd.setString(13, upd_date);
                pstmtd.setString(14, upd_time);
                pstmtd.setString(15, odd_od_ids);
                pstmtd.setInt(16, odd_lineno);
                pstmtd.executeUpdate();
            }
            pstmtds = connect.prepareStatement("INSERT INTO erp1.od_detail(ODD_OD_ID,"
                    + "ODD_LINENO,ODD_ITEM_NO,ODD_DES_HEAD,ODD_DEST,ODD_UNIT_PRICE,ODD_QTY,ODD_AMT,ODD_DISC_PERCENT,ODD_DISC_AMOUNT,ODD_AMT_A_DISC,REG_DATE,REG_TIME)VALUES"
                    + "(?,?,?,?,?,?,?,?,?,?,?,?,?)"); //sql insert query.

            for (int j = 1; j <= add; j++) {//Enter the number of products added.
                int countp;
                countp = countPro + j;

                int odd_lineno_i, odd_lineno_i_total;

                String selectpro_i,odd_dest_head_i , odd_dest_i;

                odd_lineno_i = Integer.parseInt(request.getParameter("line" + countPro)); //<-----
                odd_lineno_i_total = odd_lineno_i + j;

                selectpro_i = request.getParameter("product" + countp);
                
                odd_dest_head_i = request.getParameter("deshead" + countp);
                odd_dest_i = request.getParameter("description" + countp);

                String odd_unit_per_price_s = request.getParameter("unit_price" + countp);
                odd_unit_per_price_s = odd_unit_per_price_s.replace(",", "");

                String odd_qty_s = request.getParameter("quantity" + countp);

                String odd_amt_s = request.getParameter("amount" + countp);
                odd_amt_s = odd_amt_s.replace(",", "");

                String odd_dis_per_s = request.getParameter("discount_per" + countp);
                odd_dis_per_s = odd_dis_per_s.replace(",", "");

                String odd_dis_amt_s = request.getParameter("discountamt" + countp);
                odd_dis_amt_s = odd_dis_amt_s.replace(",", "");

                String odd_amt_a_dis_s = request.getParameter("amount_after" + countp);
                odd_amt_a_dis_s = odd_amt_a_dis_s.replace(",", "");

                pstmtds.setInt(1, od_id);
                pstmtds.setInt(2, odd_lineno_i_total);
                pstmtds.setString(3, selectpro_i);
                pstmtds.setString(4, odd_dest_head_i);
                pstmtds.setString(5, odd_dest_i);
                pstmtds.setString(6, odd_unit_per_price_s);
                pstmtds.setString(7, odd_qty_s);
                pstmtds.setString(8, odd_amt_s);
                pstmtds.setString(9, odd_dis_per_s);
                pstmtds.setString(10, odd_dis_amt_s);
                pstmtds.setString(11, odd_amt_a_dis_s);
                pstmtds.setString(12, reg_date);
                pstmtds.setString(13, reg_time);
                pstmtds.executeUpdate();

            }
        } else if (countPro > save_counter) {//If the number of products in the database is more than the number of products on the Edit Sales Order page.
            int del, countdel;

            countdel = countPro - save_counter;
            

            pstmtds = connect.prepareStatement("DELETE FROM `erp1`.`od_detail`WHERE ODD_OD_ID = ? and ODD_LINENO = ?;");//sql delete query.
//
            for (int x = 1; x <= countdel; x++) {
                del = save_counter + x;
                pstmtds.setInt(1, od_id);
                pstmtds.setInt(2, del);
                pstmtds.executeUpdate();
//
            }

            for (int i = 1; i <= save_counter; i++) {
                odd_lineno = Integer.parseInt(request.getParameter("line" + i));
                selectpro = request.getParameter("product" + i);
                odd_des_head = request.getParameter("deshead" + i);
                odd_dest = request.getParameter("description" + i);
                odd_unit_per_price = Float.parseFloat(request.getParameter("unit_price" + i).replace(",", ""));
                odd_qty = Integer.parseInt(request.getParameter("quantity" + i));
                odd_amt = Float.parseFloat(request.getParameter("amount" + i).replace(",", ""));
                odd_dis_per = Float.parseFloat(request.getParameter("discount_per" + i).replace(",", ""));
                odd_dis_amt = Float.parseFloat(request.getParameter("discountamt" + i).replace(",", ""));
                odd_amt_a_dis = Float.parseFloat(request.getParameter("amount_after" + i).replace(",", ""));

                pstmtd.setInt(1, od_id);
                pstmtd.setInt(2, odd_lineno);
                pstmtd.setString(3, selectpro);
                pstmtd.setString(4, odd_des_head);
                pstmtd.setString(5, odd_dest);
                pstmtd.setFloat(6, odd_unit_per_price);
                pstmtd.setInt(7, odd_qty);
                pstmtd.setFloat(8, odd_amt);
                pstmtd.setFloat(9, odd_dis_per);
                pstmtd.setFloat(10, odd_dis_amt);
                pstmtd.setFloat(11, odd_amt_a_dis);
                pstmtd.setFloat(12, flg1);
                pstmtd.setString(13, upd_date);
                pstmtd.setString(14, upd_time);
                pstmtd.setInt(15, od_id);
                pstmtd.setInt(16, odd_lineno);
                pstmtd.executeUpdate();
            }

        }

//
        out.println("Update Successfully...!");// after insert record successfully message

%>
<meta http-equiv=refresh content=1;URL=Sales_Order.jsp><!-- Return to Sales Order Page -->
<%    }
       
  } catch (Exception e) {

        out.println(e);
//
//        }
    }

%>

