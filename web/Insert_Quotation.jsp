<%-- 
    Document   : Insert_Quotation
    Created on : Jun 4, 2019, 10:06:12 AM
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
        String qt_id, qt_no, qt_cust_id, qtd_qt_id;
        String qt_contact, qt_cont_tel, qt_name, qt_stats, qt_date, qt_valid;
        String qt_comp_tax, qt_crr_id;
        String qt_cre_date, qt_cre_time, qt_flg1 = "", qt_exp_date, qt_user_id;
        String qt_comm, qt_valid_term, qt_delivery_term, qt_payment_term, reg_date, reg_time, flg1 = "", upd_date, upd_time, flg2 = "";

        String date, time;

        float qt_amt, qt_amt_wotax, qt_discount, qt_subtotal, qt_vat;
        int counts = 0;

        counts = Integer.parseInt(request.getParameter("save_counter"));
//        counts = counts-1;
        if (counts == 0) {%>

<script>alert('Please Enter Product');</script>
<meta http-equiv= refresh content= 1;URL=Create_Quotation.jsp>

<%
    } else {

        qt_id = request.getParameter("ID");
        qt_no = request.getParameter("Quotation_no");
        qt_cust_id = request.getParameter("customer_id");
        qt_contact = request.getParameter("contact");
        qt_cont_tel = request.getParameter("contact_tel");
        qt_name = request.getParameter("subject");
        qt_stats = request.getParameter("status");
        //no default of date and time when user not input
        qt_date = request.getParameter("date");
        qt_valid = request.getParameter("valid_until");
        qt_crr_id = request.getParameter("currency");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate localDate = LocalDate.now();
        date = dtf.format(localDate);
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        time = sdf.format(cal.getTime());
        qt_cre_date = date;
        qt_cre_time = time;
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
        reg_date = date;
        reg_time = time;
        upd_date = date;
        upd_time = time;

        PreparedStatement pstmt = null, pstmtd = null; //create statement 

        pstmt = connect.prepareStatement("INSERT INTO erp1.qt_head(QT_ID,QT_NO,QT_CUST_ID,"
                + "QT_CONTACT,QT_CONT_TEL,QT_NAME,QT_STATS,QT_DATE,QT_VALID,QT_CRR_ID,"
                + "QT_CRE_DATE,"
                + "QT_CRE_TIME,QT_EXP_DATE,QT_USER_ID,QT_COMM,QT_AMT,QT_AMT_WOTAX,QT_DISCOUNT,QT_SUBTOTAL,QT_VAT,"
                + "QT_VALID_TERM,QT_DELIVERY_TERM,QT_PAYMENT_TERM,REG_DATE,REG_TIME)VALUES"
                + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"); //sql insert query 

        pstmt.setString(1, qt_id);
        pstmt.setString(2, qt_no);
        pstmt.setString(3, qt_cust_id);
        pstmt.setString(4, qt_contact);
        pstmt.setString(5, qt_cont_tel);
        pstmt.setString(6, qt_name);
        pstmt.setString(7, qt_stats);
        pstmt.setString(8, qt_date);
        pstmt.setString(9, qt_valid);
        pstmt.setString(10, qt_crr_id);
        pstmt.setString(11, qt_cre_date);
        pstmt.setString(12, qt_cre_time);
        pstmt.setString(13, qt_exp_date);
        pstmt.setString(14, qt_user_id);
        pstmt.setString(15, qt_comm);
        pstmt.setFloat(16, qt_amt);
        pstmt.setFloat(17, qt_amt_wotax);
        pstmt.setFloat(18, qt_discount);
        pstmt.setFloat(19, qt_subtotal);
        pstmt.setFloat(20, qt_vat);
        pstmt.setString(21, qt_valid_term);
        pstmt.setString(22, qt_delivery_term);
        pstmt.setString(23, qt_payment_term);
        pstmt.setString(24, reg_date);
        pstmt.setString(25, reg_time);
        pstmt.executeUpdate(); //execute query

        pstmtd = connect.prepareStatement("INSERT INTO erp1.qt_detail(QT_ID,"
                + "QTD_LINENO,QTD_ITEM_NO,QTD_DES_HEAD,QTD_DEST,QTD_UNIT_PRICE,QTD_QTY,QTD_AMT,QTD_DISC_PERCENT,QTD_DISC_AMOUNT,QTD_AMT_A_DISC,REG_DATE,REG_TIME)VALUES"
                + "(?,?,?,?,?,?,?,?,?,?,?,?,?)"); //sql insert query 12 parameter

        statement = connect.createStatement();
//                        String sql = "SELECT * FROM customer where FLG2 = 0";
//                        String sql = "select * from qt_head";
        String sql = "SELECT QT_ID FROM erp1.qt_head ORDER BY QT_ID DESC LIMIT 0, 1;";
        resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            qtd_qt_id = resultSet.getString("QT_ID");

//                        String sqluser = "select * from user_master";
            String qtd_dest, qtd_item_no, qtd_des_head;
            int qt_qty, qtd_lineno, counter;
            float qt_dis_amt, qt_dis_per, qtd_amt, qtd_amt_a_dis, qtd_unit_per_price;
            counter = Integer.parseInt(request.getParameter("save_counter"));
//            counter = counter-1;
            for (int i = 1; i <= counter; i++) {
                qtd_lineno = Integer.parseInt(request.getParameter("line" + i));
                qtd_des_head = request.getParameter("deshead" + i);
                qtd_dest = request.getParameter("description" + i);
                qtd_item_no = request.getParameter("product" + i);
                qtd_unit_per_price = Float.parseFloat(request.getParameter("unit_price" + i).replace(",", ""));
                qt_qty = Integer.parseInt(request.getParameter("quantity" + i));
                qtd_amt = Float.parseFloat(request.getParameter("amount" + i).replace(",", ""));
                qt_dis_per = Float.parseFloat(request.getParameter("discount_per" + i).replace(",", ""));
                qt_dis_amt = Float.parseFloat(request.getParameter("discountamt" + i).replace(",", ""));
                qtd_amt_a_dis = Float.parseFloat(request.getParameter("amount_after" + i).replace(",", ""));
                
                pstmtd.setString(1, qtd_qt_id);
                pstmtd.setInt(2, qtd_lineno);
                pstmtd.setString(3, qtd_item_no);
                pstmtd.setString(4, qtd_des_head);
                pstmtd.setString(5, qtd_dest);
                pstmtd.setFloat(6, qtd_unit_per_price);
                pstmtd.setInt(7, qt_qty);
                pstmtd.setFloat(8, qtd_amt);
                pstmtd.setFloat(9, qt_dis_per);
                pstmtd.setFloat(10, qt_dis_amt);
                pstmtd.setFloat(11, qtd_amt_a_dis);
                pstmtd.setString(12, reg_date);
                pstmtd.setString(13, reg_time);
                pstmtd.executeUpdate();

            }
        }
        out.println("Insert Successfully...!");// after insert record successfully message
    }
%>
<meta http-equiv=refresh content=1;URL=Quotation.jsp>
<%
} catch (Exception e) {%>
<!--<script>alert('Please Enter Product');</script>
<meta http-equiv= refresh content= 1;URL=Create_Quotation.jsp>-->
   

<%
    out.println(e);
    }

%>

