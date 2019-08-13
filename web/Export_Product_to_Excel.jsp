<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%> 
<%@page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="java.io.*" %>
<%

    Connection conn = null;
    String id = request.getParameter("userId");
    String driver = "com.mysql.jdbc.Driver";
    String connectionUrl = "jdbc:mysql://localhost:3306/";
    String dbName = "erp1";
    String userId = "root";
    String password = "1234";
    Integer i = 1;
    Statement stmt;

    Class.forName(driver).newInstance();
    conn = DriverManager.getConnection(connectionUrl + dbName, userId, password);
    String query = "select * from product";
    stmt = conn.createStatement();

    ResultSet rs = stmt.executeQuery(query);

    try {

// create a small spreadsheet
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet();
        HSSFRow row = sheet.createRow(0);
        sheet.addMergedRegion(new CellRangeAddress(
                0, //first row (0-based)
                0, //last row (0-based)
                0, //first column (0-based)
                0 //last column (0-based)
        ));

        String date, time;
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate localDate = LocalDate.now();
        date = dtf.format(localDate);

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH_mm_ss");
        time = sdf.format(cal.getTime());

        String filename = "product_xls_" + date + "_" + time + ".xls";

        HSSFCell cell;
        row = sheet.createRow(0);
        cell = row.createCell(0);
        cell.setCellValue("Item_NO");
        cell = row.createCell(1);
        cell.setCellValue("Item_Name_EN");
        cell = row.createCell(2);
        cell.setCellValue("Item Name TH");
        cell = row.createCell(3);
        cell.setCellValue("Size");
        cell = row.createCell(4);
        cell.setCellValue("Spec");
        cell = row.createCell(5);
        cell.setCellValue("Customer ID");
        cell = row.createCell(6);
        cell.setCellValue("Current ID");
        cell = row.createCell(7);
        cell.setCellValue("Standard Price");
        cell = row.createCell(8);
        cell.setCellValue("Material Unit Price");
        cell = row.createCell(9);
        cell.setCellValue("Process Price");
        cell = row.createCell(10);
        cell.setCellValue("Date of Registration");
        cell = row.createCell(11);
        cell.setCellValue("Time of Registration");
        cell = row.createCell(12);
        cell.setCellValue("FLG1");
        cell = row.createCell(13);
        cell.setCellValue("Date of Update");
        cell = row.createCell(14);
        cell.setCellValue("Time of Update");
        cell = row.createCell(15);
        cell.setCellValue("FLG2");

        while (rs.next()) {

            row = sheet.createRow(i);
            cell = row.createCell(0);
            cell.setCellValue(rs.getString(1));
            cell = row.createCell(1);
            cell.setCellValue(rs.getString(2));
            cell = row.createCell(2);
            cell.setCellValue(rs.getString(3));
            cell = row.createCell(3);
            cell.setCellValue(rs.getString(4));
            cell = row.createCell(4);
            cell.setCellValue(rs.getString(5));
            cell = row.createCell(5);
            cell.setCellValue(rs.getString(6));
            cell = row.createCell(6);
            cell.setCellValue(rs.getString(7));
            cell = row.createCell(7);
            cell.setCellValue(rs.getString(8));
            cell = row.createCell(8);
            cell.setCellValue(rs.getString(9));
            cell = row.createCell(9);
            cell.setCellValue(rs.getString(10));
            cell = row.createCell(10);
            cell.setCellValue(rs.getString(11));
            cell = row.createCell(11);
            cell.setCellValue(rs.getString(12));
            cell = row.createCell(12);
            cell.setCellValue(rs.getString(13));
            cell = row.createCell(13);
            cell.setCellValue(rs.getString(14));
            cell = row.createCell(14);
            cell.setCellValue(rs.getString(15));
            cell = row.createCell(15);
            cell.setCellValue(rs.getString(16));
           

            i++;
        }

// write it as an excel attachment
        conn.close();
        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        wb.write(outByteStream);
        byte[] outArray = outByteStream.toByteArray();
        response.setContentType("application/ms-excel");
        response.setContentLength(outArray.length);
        response.setHeader("Expires:", "0"); // eliminates browser caching
        response.setHeader("Content-Disposition", "attachment; filename= " + filename);
        OutputStream outStream = response.getOutputStream();
        outStream.write(outArray);
        outStream.flush();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>