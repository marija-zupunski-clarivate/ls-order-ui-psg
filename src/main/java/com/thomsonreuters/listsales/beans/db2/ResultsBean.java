package com.thomsonreuters.listsales.beans.db2;


import java.sql.Connection;
import java.util.Hashtable;
import java.util.StringTokenizer;
import java.util.Vector;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomsonreuters.listsales.utils.DatabaseUtil;


public class ResultsBean
{
  static protected Logger logger=LogFactory.getLogger(ResultsBean.class);

  Document doc = null;
  public Document saveOrderResultsInfo(Hashtable params) throws Exception
  {

     logger.debug("ResultsBean : saveOrderResultsInfo ");
     if(params != null)
        {
        String orderId = getIntValue((String) params.get("orderId"));
        String countries = (String) params.get("cntName");
        String searchId = getIntValue((String) params.get("searchId"));
        String clnId = getIntValue((String) params.get("clnId"));
        String extractSrcId = getIntValue((String) params.get("extractSrcId"));
        String extract = (String) params.get("extract");
      if(extract == null) extract = "N";
            if(extract.equals("on")) extract = "Y";
            else extract = "N";
      extract = getStringValue(extract);


      String includeEmail = getStringValue((String) params.get("includeEmail"));
        if(includeEmail.equals("NULL")) includeEmail="'E'";
      String academic = getStringValue((String) params.get("academic"));
      String domestic = getStringValue((String) params.get("domestic"));
      String deliveryMail = getStringValue((String) params.get("deliveryMail"));
      String keycode = getStringValue((String) params.get("keycode"));


      Vector allCountries = null;
      boolean firstTime = true;
      StringTokenizer stn = null;

      if(countries != null && (!countries.equals("")))
        stn = new StringTokenizer(countries, ",");

         logger.debug("ResultsBean : saveOrderResultsInfo orderId is " + orderId);
        while(stn != null && stn.hasMoreTokens())
            {
              String ctrStr = stn.nextToken();
              if(firstTime)
                   allCountries = new Vector();
              firstTime = false;
        if(ctrStr != null && (!ctrStr.equals("")))
                allCountries.addElement(ctrStr);
        logger.debug("ResultsBean : saveOrderResultsInfo, ctrStr is " + ctrStr);
            }

            DB2_XML db2;

      String countryName = "";
      if(allCountries != null && orderId != null && (!orderId.equals("")))
      {
        for(int i = 0; i < allCountries.size(); i++)
        {
           String sql = "UPDATE LSTSALES.ORDRRSLT SET ";
         countryName = (String) allCountries.elementAt(i);
         StringTokenizer stnKeys = new StringTokenizer(countryName, ";");
         String prfx=null;
         String zoneType=null;
         String catgType=null;
         String postalKey=null;
         String orderKey=null;
         String srchKey=null;
         String clnKey=null;
         String cntKey=null;
         if(stnKeys != null && stnKeys.hasMoreElements())
         {
          prfx = stnKeys.nextToken();
          if(stnKeys.hasMoreElements())
            zoneType = stnKeys.nextToken();
          if(stnKeys.hasMoreElements())
            catgType = stnKeys.nextToken();
          if(stnKeys.hasMoreElements())
            postalKey = stnKeys.nextToken();
          if(stnKeys.hasMoreElements())
              orderKey = stnKeys.nextToken();
          if(stnKeys.hasMoreElements())
            srchKey= stnKeys.nextToken();
          if(stnKeys.hasMoreElements())
            clnKey= stnKeys.nextToken();
          if(stnKeys.hasMoreElements())
            cntKey= stnKeys.nextToken();
         }

         String postalCntRqrd = getIntValue((String) params.get(countryName));
         String emailKeyName = prfx+";"+zoneType+";"+catgType+";"+"EMLKEY;"+orderKey+";"+srchKey+";"+clnKey+";"+cntKey;
                  String imailKeyName = prfx+";"+zoneType+";"+catgType+";"+"IMLKEY;"+orderKey+";"+srchKey+";"+clnKey+";"+cntKey;

         String emailCntRqrd = getIntValue((String) params.get(emailKeyName));
                  String imailCntRqrd = getIntValue((String) params.get(imailKeyName));

         logger.debug("ResultsBean : saveOrderResultsInfo : The Postal Key: " + countryName + " and value is " + postalCntRqrd);
         logger.debug("ResultsBean : saveOrderResultsInfo : The Email Key: " + emailKeyName + " and value is " + emailCntRqrd);
                  logger.debug("ResultsBean : saveOrderResultsInfo : The Imail Key: " + imailKeyName + " and value is " + imailCntRqrd);

//         if(!(postalCntRqrd.equals("NULL") && emailCntRqrd.equals("NULL")))

         if(true)
         {
          sql += " PCNTSREQUIRED=" + postalCntRqrd + ", ECNTSREQUIRED=" + emailCntRqrd + ", ICNTSREQUIRED=" + imailCntRqrd;
          sql += " WHERE ORDERID=" + orderKey;
          sql += " AND SEARCHID=" + srchKey;
          sql += " AND CLNID=" + clnKey;
          sql += " AND CNTSEQ=" + cntKey;

          logger.debug("ResultsBean : saveOrderResultsInfo : the sql is, " + sql);

          doc = DatabaseUtil.setData(sql, params);
         }
        }
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
               return null;
             }
           }


      if((!extractSrcId.equals("NULL")) && (!orderId.equals("NULL")) && (!searchId.equals("NULL")))
      {
          String sql = "UPDATE LSTSALES.ORDRSRCH SET MARKTOEXTRACT=" + extract;
             sql += ", ACADNONACAD=" + academic + ", DOMROW=" + domestic;
             sql += ", DELIVERYEMAIL=" + deliveryMail + ", KEYCODE=" + keycode;
             sql += ", INCEMAIL=" + includeEmail;
             sql += " WHERE ORDERID=" + orderId + " AND SEARCHID=" + searchId;
             sql += " AND CLNID=" + extractSrcId;

        logger.debug("ResultsBean : saveOrderResultsInfo : the sql to save extract is, " + sql);
        try {
                        db2 = new DB2_XML((Connection) params.get("Connection"));
                        doc = db2.setData(sql);

                }catch(Exception e) {
                        logger.debug("ResultsBean : Error updating extract status value" + e);
            return null;
                }

      }


      errMsg = "";
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
                 return null;
               }
          }


      if((!extractSrcId.equals("NULL")) && (!orderId.equals("NULL")) && (!searchId.equals("NULL")))
            {

        String initialExprStatus = "";
        String newExprStatus = "";
        if(extract.equals("'Y'"))
        {
          initialExprStatus = "3";
          newExprStatus = "4";
        }
        if(extract.equals("'N'"))
        {
          initialExprStatus = "4";
          newExprStatus = "3";
        }

                String sql = "UPDATE LSTSALES.PROFEXPR SET EXPRSTATUS=" + newExprStatus;
                       sql += " WHERE CLNID=" + extractSrcId;
                       sql += " AND EXPRSTATUS=" + initialExprStatus;

                logger.debug("ResultsBean : saveOrderResultsInfo : the sql to save extract is, " + sql);
                try {
                        db2 = new DB2_XML((Connection) params.get("Connection"));
                        doc = db2.setData(sql);

                }catch(Exception e) {
                        logger.debug("ResultsBean : Error updating extract status value" + e);
                        return null;
                }

            }

    }


    return doc;

  }

  public Document getCompanyContactInfo(Hashtable params) throws Exception
    {
        Document dcm;
        String orderId = getIntValue((String) params.get("orderId"));

        String sql = "SELECT A.COMPANYNAME,  B.*,  C.* from LSTSALES.CUSTOMER A, LSTSALES.CONTACT B, LSTSALES.ORDERS C WHERE C.CUSTOMERID=A.CUSTOMERID AND C.CONTACTID=B.CONTACTID AND ";
               sql += " C.ORDERID=" + orderId;
        logger.debug("ResultsBean : getCompanyContactInfo : the sql is,  " + sql);
    if((!orderId.equals("NULL")) && (!orderId.equals("NULL")))
    {
      return DatabaseUtil.getData(sql, params);
    }

        return (null);
    }

  public Document getPreferencesInfo(Hashtable params) throws Exception
    {
        Document dcm;
        String orderId = getIntValue((String) params.get("orderId"));

        String sql = "SELECT * from LSTSALES.PREFERENCES WHERE";
               sql += " ORDERID=" + orderId;
        logger.debug("ResultsBean : getPreferencesInfo : the sql is,  " + sql);
        if(!orderId.equals("NULL"))
        {
          return DatabaseUtil.getData(sql, params);
        }
        return (null);
    }



  public Document getOrderInfo(Hashtable params) throws Exception
    {
        Document dcm;
    String orderId = (String)params.get("orderId");
    logger.debug("OrderBean : OrderId in ResultsBean is ***************** " + orderId);
    //String sql = "SELECT DISTINCT A.ORDERID as ORDID, B.ORDERNAME  from LSTSALES.ORDRRSLT A, LSTSALES.ORDERS B WHERE";
    //    sql += " A.ORDERID=B.ORDERID ORDER BY A.ORDERID";

    String sql = "SELECT DISTINCT A.ORDERID as ORDID, B.ORDERNAME  from LSTSALES.ORDRRSLT A, LSTSALES.ORDERS B WHERE";
        sql += " A.ORDERID=B.ORDERID AND A.ORDERID="+ orderId +" ORDER BY A.ORDERID";

    return DatabaseUtil.getData(sql, params);
    }


  public Document getSearchInfo(Hashtable params) throws Exception
    {
        Document dcm;
        String orderId = (String) params.get("orderId");

        String sql = "SELECT DISTINCT SEARCHID, ORDERID as ORDRID from LSTSALES.ORDRRSLT WHERE ORDERID=" + orderId + " ORDER BY SEARCHID";
        logger.debug("ResultsBean : getSearchInfo : the sql is,  " + sql);



    if(orderId != null && (!orderId.equals("")))
    {
          try {
              return DatabaseUtil.getData(sql, params);
          }catch(Exception e){
            logger.debug("OrderBean : Error in db2.getData " + e);
            return (null);
          }
    }
        return (null);
    }

    public Document getProfileInfo(Hashtable params) throws Exception
    {
        Document dcm;
        String orderId = (String) params.get("orderId");
        String searchId = (String) params.get("searchId");
    String clnId = (String) params.get("clnId");
//code modfied for requirement 5....made changes in where clause added clnid in condition
        String sql = "SELECT DISTINCT A.CLNID, A.ORDERID as ORDRID, A.SEARCHID as SRCID, B.CUSTLISTNAME, B.EXPRSTATUS from LSTSALES.ORDRRSLT A, LSTSALES.PROFEXPR B WHERE A.ORDERID=" + orderId + " AND SEARCHID=" + searchId + " AND A.CLNID=B.CLNID ORDER BY CLNID";
        logger.debug("ResultsBean : getSearchInfo : the sql is,  " + sql);


    if(orderId != null && (!orderId.equals("")) && searchId != null && (!searchId.equals("")))
    {
      return DatabaseUtil.getData(sql, params);
      }
        return (null);
    }





   public Document getOrderResultsInfo(Hashtable params) throws Exception
  {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder;
    Document dcm;
        String orderId = (String) params.get("orderId");
        String searchId = (String) params.get("searchId");
        String clnId = (String) params.get("clnId");
//      String sql = "SELECT ORDERID as ORDRID, SEARCHID as SRCID, CLNID as CLID, CNTSEQ, CNTNAME, PCNTVALUE, ECNTVALUE, PCNTSREQUIRED, ECNTSREQUIRED, CNTTYPE, COUNTRYID, CNTCATG from LSTSALES.ORDRRSLT ";
        String sql = "SELECT ORDERID as ORDRID, SEARCHID as SRCID, CLNID as CLID, CNTSEQ, CNTNAME, PCNTVALUE, ECNTVALUE, case when ICNTVALUE is null then 0 else ICNTVALUE end as ICNTVALUE, PCNTSREQUIRED, ECNTSREQUIRED, ICNTSREQUIRED, CNTTYPE, COUNTRYID, CNTCATG from LSTSALES.ORDRRSLT ";

    if(orderId != null && (!orderId.equals("")) && searchId != null && (!searchId.equals("")) && clnId != null && (!clnId.equals("")))
    {
      sql += " WHERE ORDERID="+orderId;
      sql += " AND SEARCHID="+searchId;
      sql += " AND CLNID="+clnId;

      logger.debug("ResultsBean : getOrderResultsInfo : the sql is,  " + sql);

      return DatabaseUtil.getData(sql, params);
    }
    return (null);
  }

    public Document getExtractInfo(Hashtable params) throws Exception
    {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;
        Document dcm;
        String orderId = (String) params.get("orderId");
        String searchId = (String) params.get("searchId");
        String clnId = (String) params.get("clnId");
        String sql = "SELECT * from LSTSALES.ORDRSRCH ";

        if(orderId != null && (!orderId.equals("")) && searchId != null && (!searchId.equals("")) && clnId != null && (!clnId.equals("")))
        {
            sql += " WHERE ORDERID="+orderId;
      sql += " AND SEARCHID="+searchId;
      sql += " AND CLNID="+clnId;

            logger.debug("ResultsBean : getSearchIdandExtractInfo : the sql is,  " + sql);
            return DatabaseUtil.getData(sql, params);
        }
        return (null);
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



}
