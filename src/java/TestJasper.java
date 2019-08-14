
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.engine.export.*;
import java.util.*;
import java.sql.*;

public class TestJasper {

    public static void main(String[] args) {
        JasperReport jasperReport;
        JasperPrint jasperPrint;
        JasperDesign jasperDesign;
        Connection conn = null;

        Map parameters = new HashMap();
        try {
            String connectionUrl = "jdbc:mysql://localhost:3306/";
            String dbName = "erp1";
            String userId = "root";
            String password = "1234";

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(connectionUrl + dbName, userId, password);
            // โหลดไฟล์ jrxml
            jasperDesign = JRXmlLoader.load("report/report1.jrxml");
            // คอมไพล์ report จะได้ไฟล์ report3.jasper
            jasperReport = JasperCompileManager.compileReport(jasperDesign);
            // ส่ง parameters กับ connection ของ database ให้ jasper ทำการ fill report
            jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, conn);
            // export report ออกไปเป็นไฟล์ demo.pdf
            JasperExportManager.exportReportToPdfFile(jasperPrint, "E:/demo.pdf");
        } catch (JRException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            System.err.println(ex.getMessage());
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception ignored) {
                }
            }
        }
    }
}
