package com.thomsonreuters.listsales.beans.db2;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.StringTokenizer;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.lang.StringUtils;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomson.ts.framework.util.StringUtil;
import com.thomsonreuters.listsales.utils.DatabaseUtil;


public class OrderBean
{
  static protected Logger logger=LogFactory.getLogger(OrderBean.class);

  boolean proceed = false;

   public synchronized Document saveOrderInfo(Hashtable params) throws Exception
  {
    Document doc = null;
    logger.debug("Entered into SaveOrderinfo*******************");
    if(params != null)
    {
       String orderId = " "; //getIntValue((String) params.get("orderId"));
       String customerId = getIntValue((String) params.get("customerId"));
       String contactId = getIntValue((String) params.get("contactId"));
       String orderName = getStringValue((String) params.get("orderName"));
//       String orderedQty = getIntValue((String) params.get("orderedQty"));
       String wantedQty = getIntValue((String) params.get("wantedQty"));
       String orderDateTmp = (String) params.get("orderDate");
       String orderDate = getTimestampValue(orderDateTmp);
//       Timestamp orderDate = new Timestamp((new java.util.Date()).getTime()));

//       String requiredByDate = getStringValue((String) params.get("requiredByDate"));
//       String promisedByDate = getStringValue((String) params.get("promisedByDate"));
//       String shipDateTmp = (String) params.get("shipDate");
//       String shipDate = getTimestampValue(shipDateTmp, out));

       String deliveryFormat = getStringValue((String) params.get("deliveryFormat"));
       String deliveryMedia = getStringValue((String) params.get("deliveryMedia"));
//       String countryOnLabel = getStringValue((String) params.get("countryOnLabel"));
//       String shipMethod = getStringValue((String) params.get("shipMethod"));
       String includeCountries = getStringValue((String) params.get("includeCountries"));
       String excludeCountries = getStringValue((String) params.get("excludeCountries"));
       String includeStates = getStringValue((String) params.get("includeStates"));
       String excludeStates = getStringValue((String) params.get("excludeStates"));
       String includeRegions = getStringValue((String) params.get("includeRegions"));
       String excludeRegions = getStringValue((String) params.get("excludeRegions"));
//       String topicId = getStringValue((String) params.get("topicId"));
       String suppressOrg = getStringValue((String) params.get("suppressOrg"));
       String countryBreakOut = getStringValue((String) params.get("countryBreakOut"));
       String notes = (String) params.get("notes");
       notes = getStringValue(modifyNameForSql(notes));

       String dedupe = getStringValue((String) params.get("dedupe"));
//       String emailAddressCount = getIntValue((String) params.get("emailAddressCount"));
//       String postalAddressCount = getIntValue(params.get("postalAddressCount"));

//       String searchId = getIntValue((String) params.get("searchId"));
       String addressesshipped = getStringValue((String) params.get("addressesshipped"));
       String zipCodes = getStringValue((String) params.get("zipCodes"));

       String logData = "";
    //For Req 2 added this condition :Start
      logger.debug("Entered Into orderID*** null condition "+orderId );
      if(orderId==null || orderId.equals(" "))
      {
        logger.debug("Entered Into orderID*** null condition");
        orderId = getMaxOrderId(params);
        params.put("orderId",orderId);
        logger.debug("MaxOrderId selected from database as "+orderId);
      }
  //For Req 2 added this condition :end
       String sql = "INSERT INTO LSTSALES.ORDERS (ORDERID, CUSTOMERID, CONTACTID,  WANTEDQTY, ORDERDATE, ORDERNAME) VALUES (" + orderId +", " + customerId +", " + contactId + ",  " + wantedQty + ", " + orderDate + ", " + orderName + ")";
       logger.debug("OrderBean : saveOrderInfo : the sql is, " + sql);

       DB2_XML db2 = new DB2_XML((Connection) params.get("Connection"));

       logger.debug("Calling DB2_XML set data...");

       doc = DatabaseUtil.setData(sql, params);

       String errMsg = "";
       if(doc != null)
           {
             try {
               NodeList ndl = doc.getElementsByTagName("ERROR");
               errMsg = ndl.item(0).getFirstChild().getNodeValue();
               if(errMsg.length() > 0)
               {
                 logger.debug("OrderBean : errMsg is " + errMsg);
         return doc;
               }
             }catch(Exception e) {
               logger.debug("OrderBean : Document error " + e);
             }
           }



       String sql2 = "INSERT INTO LSTSALES.PREFERENCES (ORDERID, DELIVERYFORMAT, DELIVERYMEDIA, SUPPRESSORG, COUNTRYBREAKOUT, INCLUDECOUNTRIES, EXCLUDECOUNTRIES, INCLUDEREGIONS, EXCLUDEREGIONS, INCLUDESTATES, EXCLUDESTATES, DEDUPE, ZIPCODES, NOTES) VALUES (" + orderId + ", " + deliveryFormat + ", " + deliveryMedia + ", " + suppressOrg + ", " + countryBreakOut + ", " + includeCountries + ", " + excludeCountries + ", " + includeRegions + ", " + excludeRegions + ", " + includeStates + ", " + excludeStates + ", " + dedupe + ", " + zipCodes + ", " + notes + ")";

       logger.debug("OrderBean : saveOrderInfo : the sql2 is, " + sql2);

//       if(deliveryFormat != null && customerId != null && deliveryMedia != null)

             logger.debug("Calling DB2_XML set data...");

       try {
           db2 = new DB2_XML((Connection) params.get("Connection"));
                doc = db2.setData(sql2);
       } catch(Exception e) {
        logger.debug("Error in inserting the data for PREFERENCES " + e);

       }
       return doc;
    }
    return null;
  }


  public String getTimestampValue(String orderDateTmp) {
    if(StringUtil.isEmpty(orderDateTmp)) {
      return "NULL";
    }

    if(orderDateTmp.length() < 11) {
      try {
        String[] dateParts = StringUtils.split(orderDateTmp, "-");

            Calendar clTmp = Calendar.getInstance();

            int hr = clTmp.get(clTmp.HOUR);
            int mn = clTmp.get(clTmp.MINUTE);
            int sc = clTmp.get(clTmp.SECOND);

            String tms =
                StringUtils.leftPad(dateParts[0], 4, '0')
                  +"-"
                  +StringUtils.leftPad(dateParts[1], 2, '0')
                  +"-"
                  +StringUtils.leftPad(dateParts[2], 2, '0')
                  +" "
                  +StringUtils.leftPad(String.valueOf(hr), 2, '0')
                  +":"
                  +StringUtils.leftPad(String.valueOf(mn), 2, '0')
                  +":"
                  +StringUtils.leftPad(String.valueOf(sc), 2, '0')
                  +".00000"
                ;
            //System.out.println("tms:"+tms);
            if(logger.isDebugEnabled()) {
              logger.debug("The orderDateTmp is " + tms);
            }
            Timestamp tmsTmp = Timestamp.valueOf(tms);
            int nanoTm = tmsTmp.getNanos();
            if(logger.isDebugEnabled()) {
              logger.debug("The time stamp and nanos is " + tmsTmp + " and " + nanoTm);
            }
            tmsTmp.setNanos(nanoTm);

            if(logger.isDebugEnabled()) {
              logger.debug("The new time stamp is " + tmsTmp);
             }
            return ("'" + tmsTmp + "'");
      }catch(Exception e) {
        if(logger.isErrorEnabled()) {
          logger.error("Error in time stamp processing", e);
             }

        return "NULL";
      }
    }else{
      return ("'" + orderDateTmp + "'");
    }
  }



   public Document updateOrderInfo(Hashtable params) throws Exception
  {
    Document doc = null;
    if(params != null)
    {
       String orderId = getIntValue((String) params.get("orderId"));
       String customerId = getIntValue((String) params.get("customerId"));
       String orderName = getStringValue((String) params.get("orderName"));
//       String orderedQty = getIntValue((String) params.get("orderedQty"));
//        if(orderedQty == null || (orderedQty.equals(""))) orderedQty = "NULL";
       String wantedQty = getIntValue((String) params.get("wantedQty"));
        if(wantedQty == null || (wantedQty.equals(""))) wantedQty = "NULL";
       String orderDateTmp = (String) params.get("orderDate");
       String orderDate = getTimestampValue(orderDateTmp);

       String requiredByDate = getStringValue((String) params.get("requiredByDate"));
       String promisedByDate = getStringValue((String) params.get("promisedByDate"));
//       String shipDateTmp = (String) params.get("shipDate");
//       String shipDate = getTimestampValue(shipDateTmp, out));

       String deliveryFormat = getStringValue((String) params.get("deliveryFormat"));
       String deliveryMedia = getStringValue((String) params.get("deliveryMedia"));
//       String countryOnLabel = getStringValue((String) params.get("countryOnLabel"));
       String shipMethod = getStringValue((String) params.get("shipMethod"));
       String includeCountries = getStringValue((String) params.get("includeCountries"));
       String excludeCountries = getStringValue((String) params.get("excludeCountries"));
       String includeStates = getStringValue((String) params.get("includeStates"));
       String excludeStates = getStringValue((String) params.get("excludeStates"));
       String includeRegions = getStringValue((String) params.get("includeRegions"));
       String excludeRegions = getStringValue((String) params.get("excludeRegions"));
//       String topicId = getStringValue((String) params.get("topicId"));
       String suppressOrg = getStringValue((String) params.get("suppressOrg"));
       String countryBreakOut = getStringValue((String) params.get("countryBreakOut"));
       String notes = (String) params.get("notes");
       notes = getStringValue(modifyNameForSql(notes));

       String dedupe = getStringValue((String) params.get("dedupe"));
//       String emailAddressCount = getStringValue((String) params.get("emailAddressCount"));
//       String postalAddressCount = (String) params.get("postalAddressCount");

//       String searchId = getIntValue((String) params.get("searchId"));
       String addressesshipped = getStringValue((String) params.get("addressesshipped"));
       String zipCodes = getStringValue((String) params.get("zipCodes"));

       String logData = "";


//       if(countryBreakOut == null && (!countryBreakOut.equals("on"))) countryBreakOut = "N";
 //          else countryBreakOut = "Y";

//       if(suppressOrg == null && (!suppressOrg.equals("on"))) suppressOrg = "N";
 //          else suppressOrg = "Y";

       String sql = "UPDATE LSTSALES.ORDERS SET (SHIPMETHOD,  WANTEDQTY, ORDERDATE, ORDERNAME, REQUIREDBYDATE, PROMISEDBYDATE) = (" + shipMethod + ", " + wantedQty + ", " + orderDate + ", " + orderName + ", " + requiredByDate + ", " + promisedByDate + ") WHERE ORDERID=" + orderId + " AND CUSTOMERID=" + customerId;

       logger.debug("OrderBean : updateOrderInfo : the sql is, " + sql);

       DB2_XML db2 = new DB2_XML((Connection) params.get("Connection"));


       logger.debug("Calling DB2_XML set data...");


       try {
               doc = db2.setData(sql);
         logger.debug("Called DB2_XML.");
           } catch(Exception e) {
                logger.debug("Error in updating the data for Orders " + e);

           }
       String errMsg = "";
           if(doc != null)
           {
             try {
               NodeList ndl = doc.getElementsByTagName("ERROR");
               errMsg = ndl.item(0).getFirstChild().getNodeValue();
               if(errMsg.length() > 0)
               {
                 logger.debug("OrderBean : errMsg is " + errMsg);
                 return doc;
               }
             }catch(Exception e) {
               logger.debug("OrderBean : Document error " + e);
             }
           }


       String sql2 = "UPDATE LSTSALES.PREFERENCES SET (DELIVERYFORMAT, DELIVERYMEDIA, SUPPRESSORG, COUNTRYBREAKOUT, INCLUDECOUNTRIES, EXCLUDECOUNTRIES, INCLUDEREGIONS, EXCLUDEREGIONS, INCLUDESTATES, EXCLUDESTATES, DEDUPE, ZIPCODES, NOTES) = (" + deliveryFormat + ", " + deliveryMedia + ", " + suppressOrg + ", " + countryBreakOut + ", " + includeCountries + ", " + excludeCountries + ", " + includeRegions + ", " + excludeRegions + ", " + includeStates + ", " + excludeStates + ", " + dedupe + ", " + zipCodes + ", " + notes + ") WHERE ORDERID=" + orderId;


       logger.debug("OrderBean : updateOrderInfo : the sql2 is, " + sql2);


       doc = DatabaseUtil.setData(sql2, params);
    return doc;
    }
    return null;
  }


  public Document getShipMethodInfo(Hashtable params) throws Exception
    {
        String sql = "SELECT SHIPMETHODID as SHPMTDID, SHIPMETHOD from LSTSALES.SHIPMETD";
    // SHPMTDID is selected like this, because, in the Order Create Page, while listing all the
  // ship methods, I have to highlight the one that is selected for a specific order. There is
  // a column in the order table called SHIPMETHODID. To distinguish this from the other to compare them
  // for highlighting, I have renamed the above to SHPMTDID.

        logger.debug("OrderBean : getShipMethodInfo : the sql is,  " + sql);
        return DatabaseUtil.getData(sql, params);
    }

  public Document getPreferencesInfo(Hashtable params) throws Exception
  {
    Document dcm;
    String orderId = (String) params.get("orderId");

    String sql = "SELECT ORDERID, DELIVERYFORMAT, DELIVERYMEDIA, INCLUDECOUNTRIES, EXCLUDECOUNTRIES, INCLUDEREGIONS, EXCLUDEREGIONS, INCLUDESTATES, EXCLUDESTATES, SUPPRESSORG, COUNTRYBREAKOUT, DEDUPE, ZIPCODES, VARCHAR(NOTES) as NOTES from LSTSALES.PREFERENCES ";
    sql += " WHERE ORDERID=" + orderId;

    logger.debug("OrderBean : getPreferencesInfo : the sql is,  " + sql);

      if(orderId != null && (!orderId.equals("")))
    {
        return DatabaseUtil.getData(sql, params);
    }
    return null;
  }

  public synchronized String getMaxOrderId(Hashtable params)
  {
    String sql = "SELECT  MAX(ORDERID) + 1 as ORDERID  from LSTSALES.ORDERS";
    String str = "";
    try {
    //DB2_XML db2 = new DB2_XML((Connection) params.get("Connection"));
    Connection conn = (Connection) params.get("Connection");
    if(conn == null) {
      conn = DatabaseUtil.getConnection();
    }
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(sql);
    rs.next();
    str = rs.getString(1);

          //str = obj.toString();
    stmt.close();
    conn.close();
    }catch(Exception e){
            // logger.debug("Error in db2.getData " + e);
             return (null);
           }
      return str;


  }
   public Document getMaxOrderIdDocument(Hashtable params) throws Exception
    {
    //    String customerId = (String) params.get("customerId");
        String sql = "SELECT  MAX(ORDERID) + 1 as ORDERID, 'N' as QFLAG from LSTSALES.ORDERS";

        logger.debug("OrderBean : getMaxOrderId : the sql is,  " + sql);

        return DatabaseUtil.getData(sql, params);
    }

  public Document getAllOrderIds(Hashtable params) throws Exception
  {
      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;
        Document dcm;

    String sql = "SELECT ORDERID as ORDID, ORDERNAME as ORDNM from LSTSALES.ORDERS ORDER BY ORDERNAME";

    return DatabaseUtil.getData(sql, params);
  }

    public Document getSearchIdInfo(Hashtable params) throws Exception
    {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;
        Document dcm;
        String orderId = (String) params.get("orderId");

        String sql = "SELECT * from LSTSALES.ORDRSRCH WHERE ORDERID=" + orderId;

        if(orderId != null && (!orderId.equals("")))
        {
          return DatabaseUtil.getData(sql, params);
    }

        return (null);
    }



// This method is for the create/edit orders page, where it displays all the information
// for the user selected order.

  public Document getOrderIdInfo(Hashtable params) throws Exception
    {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;
        Document dcm;
        String orderId = (String) params.get("orderId");
        String customerId = (String) params.get("customerId");

    String sql = "SELECT A.*, B.*, 'Q' as QFLAG from LSTSALES.ORDERS A, LSTSALES.CONTACT B WHERE A.ORDERID=" + orderId + " AND A.CONTACTID=B.CONTACTID";

    if(orderId != null && (!orderId.equals("")))
    {
      return DatabaseUtil.getData(sql, params);
    }
    return (null);


  }


// This method is for the view orders page, where the orders are chosen based on customer Id,
// and/or order date, and/or order status.

   public Document getOrderInfo(Hashtable params) throws Exception
  {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder;
    Document dcm;
        String orderId = (String) params.get("orderId");
        String customerId = (String) params.get("customerId");
        String orderStatus = (String) params.get("orderStatus");
        //String custBox = (String) params.get("custBox");
        //String dateBox = (String) params.get("dateBox");
        String orderDate = (String) params.get("orderDate");
        orderDate = DatabaseUtil.normalizeSqlDate(orderDate);

        String orderDateEnd = (String) params.get("orderDateEnd");
        orderDateEnd = DatabaseUtil.normalizeSqlDate(orderDateEnd);

        //String statusBox = (String) params.get("statusBox");

        //String requiredBox = (String) params.get("requiredBox");
        String requiredByDate = (String) params.get("requiredByDate");

        //String profStatusBox = (String) params.get("profStatusBox");
        String exprStatus = (String) params.get("exprStatus");

//      String sql = "SELECT A.*, B.COMPANYNAME, C.SEARCHID, C.ADDRESSESFOUND, C.EXTRACTEDTIME, D.SEARCHDATE from (LSTSALES.ORDERS A left outer join LSTSALES.ORDRSRCH C on A.ORDERID=C.ORDERID) left outer join LSTSALES.SEARCHES D on C.searchid = D.searchid, LSTSALES.CUSTOMER B ";
//         sql += " WHERE B.CUSTOMERID=A.CUSTOMERID ";


//    String sql = "select companyname, a.customerid, ordername, a.orderid, contactlastname, contactfirstname,date(orderdate) orderdate,wantedqty,orderstatus,custlistname,d.clnid,exprstatus,e.searchid,date(searchdate) searchdate,addressesfound,addressesshipped,date(extractedtime) extractdate from (((lstsales.orders a left outer join lstsales.profexpr d on a.orderid = d.orderid) left outer join lstsales.ordrsrch e on d.orderid = e.orderid and d.clnid = e.clnid) left outer join lstsales.searches f on e.searchid = f.searchid),lstsales.customer b,lstsales.contact c where a.customerid = b.customerid and a.contactid = c.contactid ";

    String sql = "select companyname, a.customerid, ordername, a.orderid, contactlastname, contactfirstname, " +
                "       date(orderdate) orderdate,wantedqty,orderstatus,custlistname,d.clnid,exprstatus,e.searchid," +
                "       date(searchdate) searchdate,addressesfound,coalesce(g.ecntvalue, 0) + coalesce(g.icntvalue, 0) as threeyearaddresses,addressesshipped, " +
                "       date(extractedtime) extractdate, d.create_user " +
                " from (((lstsales.orders a left outer join lstsales.profexpr d on a.orderid = d.orderid) " +
                "       left outer join lstsales.ordrsrch e on d.orderid = e.orderid and d.clnid = e.clnid) " +
                "       left outer join lstsales.searches f on e.searchid = f.searchid" +
                "       left outer join lstsales.ordrrslt g on a.orderid = g.orderid and e.searchid = g.searchid and d.clnid = g.clnid and g.cnttype = 'T' and g.cntcatg = 'T')," +
                "       lstsales.customer b,lstsales.contact c " +
                " where a.customerid = b.customerid and a.contactid = c.contactid ";

    logger.debug("OrderBean : getOrderInfo : The values customerId " + customerId + " orderStatus " + orderStatus);

    if(customerId != null && (!customerId.equals("")))
    {
       sql += " AND a.CUSTOMERID=" + customerId;
    }
    if(orderStatus != null && (!orderStatus.equals("")))
    {
          sql += " AND a.ORDERSTATUS='" + orderStatus + "'";
    }
    if(orderDate != null && (!orderDate.equals("")))
    {
        StringTokenizer stnDate = new StringTokenizer(orderDate, " ");
        if(stnDate.hasMoreTokens())
        orderDate = stnDate.nextToken();
          sql += " AND a.ORDERDATE>=TIMESTAMP_ISO('" + orderDate + "')";
    }
    if(orderDateEnd != null && (!orderDateEnd.equals("")))
    {
        StringTokenizer stnDateEnd = new StringTokenizer(orderDateEnd, " ");
        if(stnDateEnd.hasMoreTokens())
          orderDateEnd = stnDateEnd.nextToken();
          sql += " AND a.ORDERDATE<=TIMESTAMP_ISO('" + orderDateEnd + "')";
    }

    if(requiredByDate != null && (!requiredByDate.equals("")))
        {
              StringTokenizer stnDate = new StringTokenizer(requiredByDate, " ");
              if(stnDate.hasMoreTokens())
                requiredByDate = stnDate.nextToken();
              sql += " AND a.REQUIREDBYDATE>='" + requiredByDate + "'";
        }
    if(exprStatus != null && (!exprStatus.equals("")))
    {
          sql += " AND d.EXPRSTATUS=" + exprStatus + "";
    }
      // Made change by Indu on Feb 14th 2005 to include the ordername in the order by clause.
//    sql += " ORDER BY companyname,contactlastname,contactfirstname, a.orderid, ordername, custlistname";
      // Change made by Indu Mar 17 2005 to accomodate Linda's new request
    sql += " ORDER BY companyname,contactlastname,contactfirstname, a.orderid, d.clnid, e.searchid";


    logger.debug("OrderBean : getOrderInfo : the sql is,  " + sql);

    return DatabaseUtil.getData(sql, params);
  }

  public String getStringValue(String strVal)
    {
        String newStr = "NULL";
        if(strVal == null || strVal.equals(""))
            return newStr;
        else
            return "'" + strVal + "'";
    }

    public String getIntValue(String strVal)
    {
        String newStr = "NULL";
        if(strVal == null || strVal.equals(""))
            return newStr;
        else
            return strVal;
    }


    public String modifyNameForSql(String usrName)
        {
           String result = "";
           int numQuotes = 0;

           StringTokenizer stnQuotes = new StringTokenizer(usrName, "'");
             while(stnQuotes.hasMoreTokens())
             {
                if(numQuotes > 0)
                   result +=  "''";
                result += stnQuotes.nextToken();
                numQuotes++;
             }
           return result;
        }


}
