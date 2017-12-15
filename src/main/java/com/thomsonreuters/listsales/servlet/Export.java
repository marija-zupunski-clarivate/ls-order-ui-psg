package com.thomsonreuters.listsales.servlet;

import java.awt.Color;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomsonreuters.listsales.beans.Constants;
import com.thomsonreuters.listsales.utils.DatabaseUtil;

public class Export extends BaseServlet {
  protected static Logger logger = LogFactory.getLogger(Export.class);

  protected void processRequest(HttpServletRequest request,
      HttpServletResponse response)
      throws javax.servlet.ServletException, java.io.IOException {

    this.exportToExcelt(request, response);
  }

  protected void exportToExcelt(HttpServletRequest request,
      HttpServletResponse response)
      throws javax.servlet.ServletException, java.io.IOException {
    ResultSet rs = null;
    Connection connection = null;

    String str2 = null;
    int postRow = 0;
    int posCol = 0;
    float col[] = null;
    Color col_obj = new Color(194, 194, 194);
    // Color.RGBtoHSB(194,194,194,col[]);
    // short col_def=(short)col_obj.;
    short color_blue = (new HSSFColor.SKY_BLUE().getIndex());// 16764057;
    short color_yellow = (new HSSFColor.YELLOW().getIndex());// 65535;
    short color_maroon = (new HSSFColor.GREY_25_PERCENT().getIndex());
    try {
      String orderId = request.getParameter("ORDERID");
      String srcId = request.getParameter("SRCHID");
      String clnId = request.getParameter("CLNID");
      String ordName = request.getParameter("ORDNAME");
      String custListName = request.getParameter("CUSTLSTNAME");
      String cmpName = request.getParameter("CMPNAME");
      String contact = request.getParameter("CONTACT");

      connection = DatabaseUtil.getConnection();

      HSSFWorkbook wb = new HSSFWorkbook();
      HSSFSheet s = wb.createSheet();
      s.setDefaultColumnWidth(((short) 20));

      Hashtable headers = null;
      response.setContentType("application/vnd.ms-excel");
      response.setHeader("Content-Disposition",
          "attachment; filename=unknown.xls");
      OutputStream out1 = response.getOutputStream();

      HSSFCellStyle style_blue = wb.createCellStyle();
      style_blue.setAlignment(HSSFCellStyle.ALIGN_LEFT);
      style_blue.setVerticalAlignment(HSSFCellStyle.VERTICAL_JUSTIFY);
      // font bold start
      HSSFFont fonBold = wb.createFont();
      fonBold.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
      style_blue.setFont(fonBold);
      // end here
      style_blue.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
      style_blue.setWrapText(false);
      style_blue.setFillForegroundColor(color_blue);

      HSSFCellStyle style_yellow = wb.createCellStyle();
      style_yellow.setAlignment(HSSFCellStyle.ALIGN_LEFT);
      style_yellow.setVerticalAlignment(HSSFCellStyle.VERTICAL_JUSTIFY);
      // font bold start
      HSSFFont fonBold2 = wb.createFont();
      fonBold2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
      style_yellow.setFont(fonBold2);
      // end here
      style_yellow.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
      style_yellow.setWrapText(false);
      style_yellow.setFillForegroundColor(color_yellow);

      HSSFCellStyle style_grey = wb.createCellStyle();
      style_grey.setAlignment(HSSFCellStyle.ALIGN_LEFT);
      style_grey.setVerticalAlignment(HSSFCellStyle.VERTICAL_JUSTIFY);
      style_grey.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
      style_grey.setWrapText(false);
      style_grey.setFillForegroundColor(color_maroon);

      // Class.forName("com.ibm.db2.jcc.DB2Driver"); //load db
      // com.thomsonreuters.listsales.servlet if not already loaded
      // connection =
      // DriverManager.getConnection("jdbc:db2://sandbox.isinet.com:3754/listdb","txtsrch","ts957");
      Statement stmnt = connection.createStatement();
      // String headSql
      // ="SELECT distinct CNTCATG from LSTSALES.ORDRRSLT where ORDERID="+orderId+" and SEARCHID="+srcId+" AND CLNID="+clnId+" and CNTNAME in ('Domestic','Foreign','12 Months/Total','3 Months','6 Months','9 Months')";
      String headSql = "SELECT distinct CNTCATG from LSTSALES.ORDRRSLT where ORDERID="
          + orderId
          + " and SEARCHID="
          + srcId
          + " AND CLNID="
          + clnId
          + " and CNTTYPE in ('D','F','T','3','6','9','X','Y','W')";

      // rs.setFetchDirection(ResultSet.FETCH_FORWARD);
      // ResultSetMetaData rsMetaData = rs.getMetaData();
      // int numberOfColumns = rsMetaData.getColumnCount();
      HSSFRow rw = null;
      HSSFCell cell = null;
      int i = 1;
      // Starting of excel by writing headers such as customer name,serach
      // id ,customer listname
      rw = s.createRow(i);
      short ceNum = 0;
      cell = rw.createCell(ceNum);
      cell.setCellStyle(style_blue);
      cell.setCellType(HSSFCell.CELL_TYPE_STRING);
      cell.setCellValue("OrderName:");
      ceNum++;
      cell = rw.createCell(ceNum);
      cell.setCellStyle(style_blue);
      cell.setCellType(HSSFCell.CELL_TYPE_STRING);
      cell.setCellValue(ordName);
      ceNum++;
      cell = rw.createCell(ceNum);
      cell.setCellStyle(style_blue);
      cell.setCellType(HSSFCell.CELL_TYPE_STRING);
      cell.setCellValue("Search ID:");
      ceNum++;
      cell = rw.createCell(ceNum);
      cell.setCellStyle(style_blue);
      cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
      cell.setCellValue(((double) Integer.parseInt(srcId)));
      ceNum++;
      cell = rw.createCell(ceNum);
      cell.setCellStyle(style_blue);
      cell.setCellType(HSSFCell.CELL_TYPE_STRING);
      cell.setCellValue("Customer List Name :");
      ceNum++;
      cell = rw.createCell(ceNum);
      cell.setCellStyle(style_blue);
      cell.setCellType(HSSFCell.CELL_TYPE_STRING);
      cell.setCellValue(custListName);
      i++;// second row
      rw = s.createRow(i);
      ceNum = 0;
      cell = rw.createCell(ceNum);
      cell.setCellStyle(style_blue);
      cell.setCellType(HSSFCell.CELL_TYPE_STRING);
      cell.setCellValue("CompanyName :");
      ceNum++;
      cell = rw.createCell(ceNum);
      cell.setCellStyle(style_blue);
      cell.setCellType(HSSFCell.CELL_TYPE_STRING);
      cell.setCellValue(cmpName);
      ceNum++;
      cell = rw.createCell(ceNum);
      cell.setCellStyle(style_blue);
      cell.setCellType(HSSFCell.CELL_TYPE_STRING);
      cell.setCellValue("Contact :");
      ceNum++;
      cell = rw.createCell(ceNum);
      cell.setCellStyle(style_blue);
      cell.setCellType(HSSFCell.CELL_TYPE_STRING);
      cell.setCellValue(contact);
      // end here
      i = i + 3;

      for (int tab = 0; tab < 3; tab++) {
        String sql = "";

        rs = stmnt.executeQuery(headSql);

        rw = s.createRow(i);

        int k = 1;
        short kk = 1;
        cell = rw.createCell(kk);
        cell.setCellStyle(style_yellow);
        if (tab == 0) {
          sql = "SELECT CNTNAME, PCNTVALUE from LSTSALES.ORDRRSLT where ORDERID="
              + orderId
              + " and SEARCHID="
              + srcId
              + " AND CLNID="
              + clnId
              + " and CNTTYPE in ('D','F','T','3','6','9','X','Y','W')";
          cell.setCellType(HSSFCell.CELL_TYPE_STRING);
          cell.setCellValue("POSTAL");
        } else if (tab == 1) {
          sql = "SELECT CNTNAME, ECNTVALUE from LSTSALES.ORDRRSLT where ORDERID="
              + orderId
              + " and SEARCHID="
              + srcId
              + " AND CLNID="
              + clnId
              + " and CNTTYPE in ('D','F','T','3','6','9','X','Y','W') order by cntseq";
          cell.setCellType(HSSFCell.CELL_TYPE_STRING);
          cell.setCellValue("Emails");
        } else {
          sql = "SELECT CNTNAME, case when ICNTVALUE is null then 0 else ICNTVALUE end as ICNTVALUE from LSTSALES.ORDRRSLT where ORDERID="
              + orderId
              + " and SEARCHID="
              + srcId
              + " AND CLNID="
              + clnId
              + " and CNTTYPE in ('D','F', 'U', 'T','3','6','9','X','Y','W') order by cntseq";
          cell.setCellType(HSSFCell.CELL_TYPE_STRING);
          cell.setCellValue("Emails with Invalid Postal");
        }
        i++;
        rw = s.createRow(i);
        cell = rw.createCell(kk);
        cell.setCellStyle(style_blue);
        cell.setCellType(HSSFCell.CELL_TYPE_STRING);
        cell.setCellValue("Results");
        i++;
        rw = s.createRow(i);
        String prin = "abc";
        headers = new Hashtable();
        while (rs.next()) {
          prin = rs.getString(k);
          headers.put(prin, " ");
          // cell=rw.createCell(kk);
          // cell.setCellStyle(style);
          // cell.setCellValue(headers.get(prin).toString() );
          // kk++;
        }// end of while

        if (headers.containsKey("A")) {
          cell = rw.createCell(kk);
          cell.setCellStyle(style_blue);
          cell.setCellType(HSSFCell.CELL_TYPE_STRING);
          cell.setCellValue("Academic");
          kk++;
        }
        if (headers.containsKey("N")) {
          cell = rw.createCell(kk);
          cell.setCellStyle(style_blue);
          cell.setCellType(HSSFCell.CELL_TYPE_STRING);
          cell.setCellValue("Non-Academic");
          kk++;
        }
        if (headers.containsKey("T")) {
          cell = rw.createCell(kk);
          cell.setCellStyle(style_blue);
          cell.setCellType(HSSFCell.CELL_TYPE_STRING);
          cell.setCellValue("All");
          kk++;
        }
        if (headers.containsKey("3")) {
          cell = rw.createCell(kk);
          cell.setCellStyle(style_blue);
          cell.setCellType(HSSFCell.CELL_TYPE_STRING);
          cell.setCellValue("3 Months");
          kk++;
        }
        if (headers.containsKey("6")) {
          cell = rw.createCell(kk);
          cell.setCellStyle(style_blue);
          cell.setCellType(HSSFCell.CELL_TYPE_STRING);
          cell.setCellValue("6 Months");
          kk++;
        }
        if (headers.containsKey("9")) {
          cell = rw.createCell(kk);
          cell.setCellStyle(style_blue);
          cell.setCellType(HSSFCell.CELL_TYPE_STRING);
          cell.setCellValue("9 Months");
          kk++;
        }
        if (headers.containsKey("X")) {
          cell = rw.createCell(kk);
          cell.setCellStyle(style_blue);
          cell.setCellType(HSSFCell.CELL_TYPE_STRING);
          cell.setCellValue("12 Months");
          kk++;
        }
        if (headers.containsKey("Y")) {
          cell = rw.createCell(kk);
          cell.setCellStyle(style_blue);
          cell.setCellType(HSSFCell.CELL_TYPE_STRING);
          cell.setCellValue("18 Months");
          kk++;
        }
        if (headers.containsKey("W")) {
          cell = rw.createCell(kk);
          cell.setCellStyle(style_blue);
          cell.setCellType(HSSFCell.CELL_TYPE_STRING);
          cell.setCellValue("24 Months");
          kk++;
        }
        // String query= ("sql"+tab).toString();
        rs = stmnt.executeQuery(sql);
        String temp = "temp";

        while (rs.next()) {
          String val = rs.getString(1);
          if (!temp.equals(val)) {
            i++;
            kk = 0;
            rw = s.createRow(i);
            cell = rw.createCell(kk);
            cell.setCellStyle(style_blue);
            cell.setCellType(HSSFCell.CELL_TYPE_STRING);
            cell.setCellValue(val);
            cell = rw.createCell(++kk);
            cell.setCellStyle(style_grey);
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
            cell.setCellValue(((double) Integer.parseInt(rs
                .getString(2))));
            temp = val;
          } else {
            kk++;
            val = rs.getString(2);
            cell = rw.createCell(kk);
            cell.setCellStyle(style_grey);
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
            cell.setCellValue(((double) Integer.parseInt(val)));
          }
        }// end of while
        i++;
        i++;
      }// end of for tab
        // end of first
        // table..............................................................................................

      // email And Postal Results Table
      String headSql2 = "SELECT distinct CNTCATG from LSTSALES.ORDRRSLT where ORDERID="
          + orderId
          + " and SEARCHID="
          + srcId
          + " AND CLNID="
          + clnId
          + " and CNTTYPE not in ('D','F','U','T','3','6','9','X','Y','W') ";
      rs = stmnt.executeQuery(headSql2);
      int k = 1;
      short kk = 1;
      short ce = 0;
      short ce2 = 0;
      boolean tabStart = false;
      // int rsLen=rs.getFetchSize();

      if (!tabStart) {
        i++;
        rw = s.createRow(i);
        postRow = i;
        cell = rw.createCell(kk);
        posCol = kk;
        cell.setCellStyle(style_yellow);
        cell.setCellType(HSSFCell.CELL_TYPE_STRING);
        cell.setCellValue("POSTAL");
        i++;
        rw = s.createRow(i);
        cell = rw.createCell(kk);
        cell.setCellStyle(style_blue);
        cell.setCellValue("Results");
        cell.setCellType(HSSFCell.CELL_TYPE_STRING);
        tabStart = true;
        headers = new Hashtable();
        // i++;
        // rw = s.createRow(i);
        while (rs.next()) {
          // prin=rs.getString(k);
          headers.put(rs.getString(k), " ");
          // cell=rw.createCell(kk);
          // cell.setCellStyle(style);
          // cell.setCellValue(headers.get(prin).toString() );
          // kk++;
        }// end of while
          // /for email header printing
        rw = s.getRow(postRow);
        ce = (short) (posCol + (headers.size()));
        cell = rw.createCell(ce);
        cell.setCellStyle(style_yellow);
        cell.setCellType(HSSFCell.CELL_TYPE_STRING);
        cell.setCellValue("Email");
        rw = s.getRow(postRow + 1);
        // int ce=posCol+(headers.size()-1);
        cell = rw.createCell(ce);
        cell.setCellStyle(style_blue);
        cell.setCellType(HSSFCell.CELL_TYPE_STRING);
        cell.setCellValue("Results");
        // end of email header
        // /for email with invalid postal header printing
        rw = s.getRow(postRow);
        ce2 = (short) (posCol + (headers.size()) * 2);
        cell = rw.createCell(ce2);
        cell.setCellStyle(style_yellow);
        cell.setCellType(HSSFCell.CELL_TYPE_STRING);
        cell.setCellValue("Emails with Invalid Postal");
        rw = s.getRow(postRow + 1);
        // int ce=posCol+(headers.size()-1);
        cell = rw.createCell(ce2);
        cell.setCellStyle(style_blue);
        cell.setCellType(HSSFCell.CELL_TYPE_STRING);
        cell.setCellValue("Results");
        // end of email with invalid postal header
        i++;
        rw = s.createRow(i);
        for (int l = 0; l < 3; l++) {
          if (headers.containsKey("A")) {
            cell = rw.createCell(kk);
            cell.setCellStyle(style_blue);
            cell.setCellValue("Academic");
            Object remo = headers.remove("A");
            headers.put("A", "1");
            kk++;
          }
          if (headers.containsKey("N")) {
            cell = rw.createCell(kk);
            cell.setCellStyle(style_blue);
            cell.setCellValue("Non-Academic");
            Object remo = headers.remove("N");
            headers.put("N", "2");
            kk++;
          }
          if (headers.containsKey("T")) {
            cell = rw.createCell(kk);
            cell.setCellStyle(style_blue);
            cell.setCellValue("All");
            Object remo = headers.remove("T");
            headers.put("T", "3");
            kk++;
          }
        }// end of for headers

        // String query= ("sql"+tab).toString();
        String sql123 = "SELECT CNTNAME,PCNTVALUE, ECNTVALUE, case when ICNTVALUE is null then 0 else ICNTVALUE end as ICNTVALUE, CNTCATG from LSTSALES.ORDRRSLT where ORDERID="
            + orderId
            + " and SEARCHID="
            + srcId
            + " AND CLNID="
            + clnId
            + " and CNTTYPE not in ('D','F','U','T','3','6','9','X','Y','W')";
        rs = stmnt.executeQuery(sql123);
        String temp = "temp";
        short postRow_inc = (short) postRow;
        short posCol_inc = ce;
        short posCol_inc_2 = 0;
        short posCol_inc_3 = 0;
        short prev_posCol = 0;
        while (rs.next()) {
          String val = rs.getString(1);
          if (!temp.equals(val)) {
            i++;
            kk = 0;

            posCol_inc = ce;
            // posCol_inc=7;
            rw = s.createRow(i);
            cell = rw.createCell(kk);
            cell.setCellStyle(style_blue);
            cell.setCellType(HSSFCell.CELL_TYPE_STRING);
            cell.setCellValue(val);
            // cell=rw.createCell(++kk);
            for (short cc = ((short) (kk + 1)); cc < headers.size(); cc++) {
              cell = rw.createCell(cc);
              cell.setCellStyle(style_grey);
              cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
              cell.setCellValue(((double) Integer.parseInt("0")));
              posCol_inc_2 = (short) (posCol_inc + cc - 1);
              cell = rw.createCell(posCol_inc_2);
              cell.setCellStyle(style_grey);
              cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
              cell.setCellValue(((double) Integer.parseInt("0")));

              posCol_inc_3 = (short) (posCol_inc * 2 + cc - 2);
              cell = rw.createCell(posCol_inc_3);
              cell.setCellStyle(style_grey);
              cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
              cell.setCellValue(((double) Integer.parseInt("0")));
            }// end of for
              // -----
            if (headers.containsKey("A")) {
              // kk=(short)Integer.parseInt(headers.get(rs.getString(4)).toString());
              kk = (short) Integer.parseInt(headers.get(
                  rs.getString(5)).toString());
              // this for loop is to fill the non available cell
              // values with value 0
              /*
               * for(short c=1;c<kk;c++) { cell=rw.createCell(c);
               * cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
               * cell.setCellStyle(style_yellow);
               * cell.setCellValue
               * (((double)Integer.parseInt("0")));
               * posCol_inc_2=(short)(posCol_inc+c-1);
               * cell=rw.createCell(posCol_inc_2);
               * cell.setCellStyle(style_yellow);
               * cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
               * cell
               * .setCellValue(((double)Integer.parseInt("0")));
               * 
               * }//end of for
               */
              // end of for loop
            } else {
              kk++;
            }
            cell = rw.createCell(kk);
            // -----
            cell.setCellStyle(style_grey);
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
            cell.setCellValue(((double) Integer.parseInt(rs
                .getString(2))));
            // rw = s.getRow(postRow+1);
            posCol_inc_2 = (short) (posCol_inc + kk - 1);
            cell = rw.createCell(posCol_inc_2);
            cell.setCellStyle(style_grey);
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
            cell.setCellValue(((double) Integer.parseInt(rs
                .getString(3))));
            posCol_inc_3 = (short) (posCol_inc * 2 + kk - 2);
            cell = rw.createCell(posCol_inc_3);
            cell.setCellStyle(style_grey);
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
            cell.setCellValue(((double) Integer.parseInt(rs
                .getString(4))));
            temp = val;
          } else {
            prev_posCol = kk;
            kk++;
            // posCol_inc++;
            val = rs.getString(2);
            // cell=rw.createCell(kk);
            // ----
            // kk=(short)Integer.parseInt(headers.get(rs.getString(4)).toString());
            kk = (short) Integer.parseInt(headers.get(
                rs.getString(5)).toString());
            cell = rw.createCell(kk);
            // -----
            cell.setCellStyle(style_grey);
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
            cell.setCellValue(((double) Integer.parseInt(val)));
            // posCol_inc=(short)(posCol_inc+kk);
            posCol_inc_2 = (short) (posCol_inc + kk - 1);
            cell = rw.createCell(posCol_inc_2);
            cell.setCellStyle(style_grey);
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
            cell.setCellValue(((double) Integer.parseInt(rs
                .getString(3))));
            // posCol_inc_2=posCol_inc;
            posCol_inc_3 = (short) (posCol_inc * 2 + kk - 2);
            cell = rw.createCell(posCol_inc_3);
            cell.setCellStyle(style_grey);
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
            cell.setCellValue(((double) Integer.parseInt(rs
                .getString(4))));
            // posCol_inc_2=posCol_inc;
          }
        }// end of while

      }// end of if tabstart

      // end of second table
      wb.write(out1);
      out1.flush();
      out1.close();

      return;
    } catch (Exception e) {
      if(logger.isErrorEnabled()) {
        logger.error("Error to export--", e);
      }
      try {
        showJspView(request, response, Constants.ERROR_PAGE);
      } catch(Exception e1) {
        logger.error("Error to export--", e1);
        e.printStackTrace();
      }
    } finally {
      if(connection != null) {
        try {
          connection.close();
        } catch(Exception e) {
          logger.error("Error to export--", e);
          e.printStackTrace();
        }
      }

    }

  }

}
