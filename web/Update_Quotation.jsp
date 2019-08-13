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
        Statement statement = null;
        ResultSet resultSet = null;

//        connect = DriverManager.getConnection(connectionUrl+dbName, userId, password);
        connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + dbName + "?useUnicode=yes&characterEncoding=UTF-8", userId, password);

//        String item_no,item_eng,item_th,size,spec,cus_id,currency,standard_price,mt_unit_price,process_price,date,time;
        String qt_no, qt_cust_id, qtd_qt_id;
        String qt_contact, qt_cont_tel, qt_name, qt_stats, qt_date, qt_valid;
        String qt_comp_tax, qt_crr_id;
        String qt_cre_date, qt_cre_time, qt_exp_date, qt_user_id;
        String qt_comm, qt_valid_term, qt_delivery_term, qt_payment_term, reg_date, reg_time, upd_date, upd_time, flg2 = "";

        String date, time;

        float qt_amt, qt_amt_wotax, qt_discount, qt_subtotal, qt_vat;
        int qt_flg1 = 1, flg1 = 1, qt_id;

        qt_id = Integer.parseInt(request.getParameter("ID"));
        qt_no = request.getParameter("Quotation_no");
        qt_cust_id = request.getParameter("customer_id");
        qt_contact = request.getParameter("contact");
        qt_cont_tel = request.getParameter("contact_tel");
        qt_name = request.getParameter("subject");
        qt_stats = request.getParameter("status");
        qt_date = request.getParameter("date");
        qt_valid = request.getParameter("valid_until");
        qt_crr_id = request.getParameter("currency");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate localDate = LocalDate.now();
        date = dtf.format(localDate);
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        time = sdf.format(cal.getTime());
        qt_exp_date = dtf.format(LocalDate.parse(qt_date).plusDays(30));
        //qt_exp_date = date;
        qt_user_id = request.getParameter("sales");
        qt_comm = request.getParameter("comment");
        qt_amt = Float.parseFloat(request.getParameter("qt_amt").replace(",", ""));
        qt_amt_wotax = Float.parseFloat(request.getParameter("qt_amt_wotax").replace(",", ""));
        qt_discount = Float.parseFloat(request.getParameter("qt_discount").replace(",", ""));
        qt_subtotal = Float.parseFloat(request.getParameter("qt_subtotal").replace(",", ""));
        qt_vat = Float.parseFloat(request.getParameter("qt_vat").replace(",", ""));
        qt_valid_term = request.getParameter("valid_term");
        qt_delivery_term = request.getParameter("delivery_term");
        qt_payment_term = request.getParameter("payment_term");
        upd_date = date;
        upd_time = time;
        reg_date = date;
        reg_time = time;

//
        PreparedStatement pstmt = null, pstmtd = null, pstmtds = null; //create statement 
//
        pstmt = connect.prepareStatement("UPDATE erp1.qt_head "
                + "SET QT_NO = ?,QT_CUST_ID = ?,QT_CONTACT=?,QT_CONT_TEL = ?,QT_NAME = ?,QT_STATS = ?,"
                + "QT_DATE = ?,QT_VALID = ?,QT_CRR_ID = ?,"
                + "QT_FLG1=?,QT_EXP_DATE = ?,QT_USER_ID = ?,"
                + "QT_COMM = ?,QT_AMT = ?,QT_AMT_WOTAX = ?,QT_DISCOUNT = ?,QT_SUBTOTAL = ?,QT_VAT = ?,QT_VALID_TERM = ?,QT_DELIVERY_TERM = ?,QT_PAYMENT_TERM = ?,FLG1 = ?,UPD_DATE = ?,UPD_TIME = ?"
                + "WHERE QT_ID = ?;");

        pstmt.setString(1, qt_no);
        pstmt.setString(2, qt_cust_id);
        pstmt.setString(3, qt_contact);
        pstmt.setString(4, qt_cont_tel);
        pstmt.setString(5, qt_name);
        pstmt.setString(6, qt_stats);
        pstmt.setString(7, qt_date);
        pstmt.setString(8, qt_valid);
        pstmt.setString(9, qt_crr_id);
        pstmt.setInt(10, qt_flg1);
        pstmt.setString(11, qt_exp_date);
        pstmt.setString(12, qt_user_id);
        pstmt.setString(13, qt_comm);
        pstmt.setFloat(14, qt_amt);
        pstmt.setFloat(15, qt_amt_wotax);
        pstmt.setFloat(16, qt_discount);
        pstmt.setFloat(17, qt_subtotal);
        pstmt.setFloat(18, qt_vat);
        pstmt.setString(19, qt_valid_term);
        pstmt.setString(20, qt_delivery_term);
        pstmt.setString(21, qt_payment_term);
        pstmt.setInt(22, flg1);
        pstmt.setString(23, upd_date);
        pstmt.setString(24, upd_time);
        pstmt.setInt(25, qt_id);
        pstmt.executeUpdate(); //execute query
//
//        //connect.close();  //close connection 
        pstmtd = connect.prepareStatement("UPDATE erp1.qt_detail SET "
                + "QT_ID = ?,"
                + "QTD_LINENO = ?,"
                + "QTD_ITEM_NO = ?,"
                + "QTD_DES_HEAD = ?,"
                + "QTD_DEST = ?,"
                + "QTD_UNIT_PRICE = ?,"
                + "QTD_QTY = ?,"
                + "QTD_AMT = ?,"
                + "QTD_DISC_PERCENT = ?,"
                + "QTD_DISC_AMOUNT = ?,"
                + "QTD_AMT_A_DISC = ?,"
                + "FLG1 = ?,"
                + "UPD_DATE = ?,"
                + "UPD_TIME = ? "
                + "WHERE QT_ID = ? and QTD_LINENO = ?;"); //sql insert query 14 parameter
//
//        statement = connect.createStatement();
////                        String sql = "SELECT * FROM customer where FLG2 = 0";
////                        String sql = "select * from qt_head";
////                        
        String selectpro;
        String qtd_id_str;

        int qt_qty, qtd_id, qtd_qt_idi, qtd_lineno, countPro, save_counter;
        String qtd_qt_ids, qtd_dest,qtd_des_head;
        float qt_dis_amt, qt_dis_per, qtd_amt, qtd_unit_per_price, qtd_amt_a_dis;
        qtd_qt_idi = Integer.parseInt(request.getParameter("ID"));
        int y = 0;
        qtd_qt_ids = request.getParameter("ID");
        countPro = Integer.parseInt(request.getParameter("countPro"));
        save_counter = Integer.parseInt(request.getParameter("save_counter"));

        if (countPro == save_counter) {
            for (int i = 1; i <= countPro; i++) {
                qtd_lineno = Integer.parseInt(request.getParameter("line" + i));
                selectpro = request.getParameter("product" + i);
                qtd_des_head = request.getParameter("deshead" + i);
                qtd_dest = request.getParameter("description" + i);
                qtd_unit_per_price = Float.parseFloat(request.getParameter("unit_price" + i).replace(",", ""));
                qt_qty = Integer.parseInt(request.getParameter("quantity" + i));
                qtd_amt = Float.parseFloat(request.getParameter("amount" + i).replace(",", ""));
                qt_dis_per = Float.parseFloat(request.getParameter("discount_per" + i).replace(",", ""));
                qt_dis_amt = Float.parseFloat(request.getParameter("discountamt" + i).replace(",", ""));
                qtd_amt_a_dis = Float.parseFloat(request.getParameter("amount_after" + i).replace(",", ""));
//            qtd_id = Integer.parseInt(request.getParameter(splitqtdid[i]));
                pstmtd.setString(1, qtd_qt_ids);
                pstmtd.setInt(2, qtd_lineno);
                pstmtd.setString(3, selectpro);
                pstmtd.setString(4, qtd_des_head);
                pstmtd.setString(5, qtd_dest);
                pstmtd.setFloat(6, qtd_unit_per_price);
                pstmtd.setInt(7, qt_qty);
                pstmtd.setFloat(8, qtd_amt);
                pstmtd.setFloat(9, qt_dis_per);
                pstmtd.setFloat(10, qt_dis_amt);
                pstmtd.setFloat(11, qtd_amt_a_dis);
                pstmtd.setFloat(12, flg1);
                pstmtd.setString(13, upd_date);
                pstmtd.setString(14, upd_time);
                pstmtd.setString(15, qtd_qt_ids);
                pstmtd.setInt(16, qtd_lineno);
                pstmtd.executeUpdate();

            }
        } else if (countPro < save_counter) {

            int add;
            add = save_counter - countPro;

            for (int i = 1; i <= countPro; i++) {
                qtd_lineno = Integer.parseInt(request.getParameter("line" + i));
                selectpro = request.getParameter("product" + i);
                qtd_des_head = request.getParameter("deshead" + i);
                qtd_dest = request.getParameter("description" + i);
                qtd_unit_per_price = Float.parseFloat(request.getParameter("unit_price" + i).replace(",", ""));
                qt_qty = Integer.parseInt(request.getParameter("quantity" + i));
                qtd_amt = Float.parseFloat(request.getParameter("amount" + i).replace(",", ""));
                qt_dis_per = Float.parseFloat(request.getParameter("discount_per" + i).replace(",", ""));
                qt_dis_amt = Float.parseFloat(request.getParameter("discountamt" + i).replace(",", ""));
                qtd_amt_a_dis = Float.parseFloat(request.getParameter("amount_after" + i).replace(",", ""));
//            qtd_id = Integer.parseInt(request.getParameter(splitqtdid[i]));
                pstmtd.setString(1, qtd_qt_ids);
                pstmtd.setInt(2, qtd_lineno);
                pstmtd.setString(3, selectpro);
                pstmtd.setString(4, qtd_des_head);
                pstmtd.setString(5, qtd_dest);
                pstmtd.setFloat(6, qtd_unit_per_price);
                pstmtd.setInt(7, qt_qty);
                pstmtd.setFloat(8, qtd_amt);
                pstmtd.setFloat(9, qt_dis_per);
                pstmtd.setFloat(10, qt_dis_amt);
                pstmtd.setFloat(11, qtd_amt_a_dis);
                pstmtd.setFloat(12, flg1);
                pstmtd.setString(13, upd_date);
                pstmtd.setString(14, upd_time);
                pstmtd.setString(15, qtd_qt_ids);
                pstmtd.setInt(16, qtd_lineno);
                pstmtd.executeUpdate();
            }
            pstmtds = connect.prepareStatement("INSERT INTO erp1.qt_detail(QT_ID,"
                    + "QTD_LINENO,QTD_ITEM_NO,QTD_DES_HEAD,QTD_DEST,QTD_UNIT_PRICE,QTD_QTY,QTD_AMT,QTD_DISC_PERCENT,QTD_DISC_AMOUNT,QTD_AMT_A_DISC,REG_DATE,REG_TIME)VALUES"
                    + "(?,?,?,?,?,?,?,?,?,?,?,?,?)"); //sql insert query 12 parameter

            //statement = connect.createStatement();
            for (int j = 1; j <= add; j++) {
                int countp;
                countp = countPro + j;

                int qtd_lineno_i, qtd_lineno_i_total;

                String selectpro_i,qtd_dest_head_i , qtd_dest_i;

                qtd_lineno_i = Integer.parseInt(request.getParameter("line" + countPro)); //<-----
                qtd_lineno_i_total = qtd_lineno_i + j;

                selectpro_i = request.getParameter("product" + countp);
                
                qtd_dest_head_i = request.getParameter("deshead" + countp);
                qtd_dest_i = request.getParameter("description" + countp);

                String qtd_unit_per_price_s = request.getParameter("unit_price" + countp);
                qtd_unit_per_price_s = qtd_unit_per_price_s.replace(",", "");

                String qt_qty_s = request.getParameter("quantity" + countp);

                String qtd_amt_s = request.getParameter("amount" + countp);
                qtd_amt_s = qtd_amt_s.replace(",", "");

                String qt_dis_per_s = request.getParameter("discount_per" + countp);
                qt_dis_per_s = qt_dis_per_s.replace(",", "");

                String qt_dis_amt_s = request.getParameter("discountamt" + countp);
                qt_dis_amt_s = qt_dis_amt_s.replace(",", "");

                String qtd_amt_a_dis_s = request.getParameter("amount_after" + countp);
                qtd_amt_a_dis_s = qtd_amt_a_dis_s.replace(",", "");

                pstmtds.setString(1, qtd_qt_ids);
                pstmtds.setInt(2, qtd_lineno_i_total);
                pstmtds.setString(3, selectpro_i);
                pstmtds.setString(4, qtd_dest_head_i);
                pstmtds.setString(5, qtd_dest_i);
                pstmtds.setString(6, qtd_unit_per_price_s);
                pstmtds.setString(7, qt_qty_s);
                pstmtds.setString(8, qtd_amt_s);
                pstmtds.setString(9, qt_dis_per_s);
                pstmtds.setString(10, qt_dis_amt_s);
                pstmtds.setString(11, qtd_amt_a_dis_s);
                pstmtds.setString(12, reg_date);
                pstmtds.setString(13, reg_time);
                pstmtds.executeUpdate();

            }
        } else if (countPro > save_counter) {
            int del, countdel;

            countdel = countPro - save_counter;
            

            pstmtds = connect.prepareStatement("DELETE FROM `erp1`.`qt_detail`WHERE QT_ID = ? and QTD_LINENO = ?;");
//
            for (int x = 1; x <= countdel; x++) {
                del = save_counter + x;
                pstmtds.setString(1, qtd_qt_ids);
                pstmtds.setInt(2, del);
                pstmtds.executeUpdate();
//
            }

            for (int i = 1; i <= save_counter; i++) {
                qtd_lineno = Integer.parseInt(request.getParameter("line" + i));
                selectpro = request.getParameter("product" + i);
                qtd_des_head = request.getParameter("deshead" + i);
                qtd_dest = request.getParameter("description" + i);
                qtd_unit_per_price = Float.parseFloat(request.getParameter("unit_price" + i).replace(",", ""));
                qt_qty = Integer.parseInt(request.getParameter("quantity" + i));
                qtd_amt = Float.parseFloat(request.getParameter("amount" + i).replace(",", ""));
                qt_dis_per = Float.parseFloat(request.getParameter("discount_per" + i).replace(",", ""));
                qt_dis_amt = Float.parseFloat(request.getParameter("discountamt" + i).replace(",", ""));
                qtd_amt_a_dis = Float.parseFloat(request.getParameter("amount_after" + i).replace(",", ""));
//            qtd_id = Integer.parseInt(request.getParameter(splitqtdid[i]));
                pstmtd.setString(1, qtd_qt_ids);
                pstmtd.setInt(2, qtd_lineno);
                pstmtd.setString(3, selectpro);
                pstmtd.setString(4, qtd_des_head);
                pstmtd.setString(5, qtd_dest);
                pstmtd.setFloat(6, qtd_unit_per_price);
                pstmtd.setInt(7, qt_qty);
                pstmtd.setFloat(8, qtd_amt);
                pstmtd.setFloat(9, qt_dis_per);
                pstmtd.setFloat(10, qt_dis_amt);
                pstmtd.setFloat(11, qtd_amt_a_dis);
                pstmtd.setFloat(12, flg1);
                pstmtd.setString(13, upd_date);
                pstmtd.setString(14, upd_time);
                pstmtd.setString(15, qtd_qt_ids);
                pstmtd.setInt(16, qtd_lineno);
                pstmtd.executeUpdate();
            }

        }
//
        out.println("Update Successfully...!");// after insert record successfully message

%>
<meta http-equiv=refresh content=1;URL=Quotation.jsp>
<%    } catch (Exception e) {

        out.println(e);
       

//
//        }
    }

%>

