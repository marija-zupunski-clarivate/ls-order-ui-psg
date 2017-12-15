package com.thomsonreuters.listsales.beans.db2;

import java.util.Enumeration;
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


public class StopAddressBean
{
  static protected Logger logger=LogFactory.getLogger(StopAddressBean.class);

   public Document getAddressInfo(Hashtable params) throws Exception
  {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder;
    Document dcm;
        String authorName = (String) params.get("authorName");
        String authorBox = (String) params.get("authorBox");
        String mainBox = (String) params.get("mainBox");
        String mainOrg = (String) params.get("mainOrg");
        String countryBox = (String) params.get("countryBox");
        String countryId = (String) params.get("countryId");
        String postalBox = (String) params.get("postalBox");
        String postalCode = (String) params.get("postalCode");

      String sql = "SELECT D.*, B.COUNTRY, a.AUTHORNAME" +
                " FROM LSTSALES.AUTHORS_ADDR D " +
                " join LSTSALES.AUTHORS A on A.issueno = d.issueno and A.itemno = D.itemno and A.authseq = D.authseq " +
                " JOIN LSTSALES.COUNTRY B  on b.countryid=d.countryid ";
    boolean firstCondition = false;
    if(authorBox != null && authorBox.equals("on") && authorName != null && (!authorName.equals("")))
    {
       sql += " AND A.AUTHORNAME LIKE '" + authorName + "%'";
       firstCondition = true;
    }
    if(mainBox != null && mainBox.equals("on") &&  mainOrg != null && (!mainOrg.equals("")))
    {
       sql += " AND D.MAINORG LIKE '" + mainOrg + "%'";
       firstCondition = true;
    }
    if(countryBox != null && countryBox.equals("on") &&  countryId != null && (!countryId.equals("")))
    {
       sql += " AND D.COUNTRYID=" + countryId;
       firstCondition = true;
    }
    if(postalBox != null && postalBox.equals("on") &&  postalCode != null && (!postalCode.equals("")))
    {
        sql += " AND D.POSTALCODE='" + postalCode + "'";
        firstCondition = true;
    }
    sql += " ORDER BY AUTHORNAME FETCH FIRST 100 ROWS ONLY";

    logger.debug("StopAddressBean : getOrderInfo : the sql is,  " + sql);


    if(firstCondition)
    {
      return DatabaseUtil.getData(sql, params);
    }
    else
      logger.debug("StopAddressBean : getOrderInfo : No search data entered....");

     return (null);
  }


  public Document getCountriesInfo(Hashtable params) throws Exception
  {
    String sql = "SELECT DISTINCT A.COUNTRYID as CNTRID, B.COUNTRY from LSTSALES.AUTHORS_ADDR A, LSTSALES.COUNTRY B WHERE A.COUNTRYID=B.COUNTRYID ORDER BY B.COUNTRY";

    return DatabaseUtil.getData(sql, params);
  }


  public Document saveStopAddressInfo(Hashtable params) throws Exception
    {
        Document doc = null;

        if(params != null)
        {

        Vector rowVals = null;
      Enumeration checkBoxVals = params.keys();
      boolean firstTime = true;
      String allErrorMsgs = "";
      String issueVal = "";
      String itemVal = "";
      String authVal = "";
       while(checkBoxVals.hasMoreElements())
      {
        String checkBxVal = (String) checkBoxVals.nextElement();
        issueVal = "";
        itemVal = "";
        authVal = "";
        if(checkBxVal.startsWith("rowValueBox"))
        {
          StringTokenizer stnKeys = new StringTokenizer(checkBxVal, ";");
          String prfx=null;
          if(stnKeys.hasMoreElements())
            prfx = stnKeys.nextToken();
                    if(stnKeys.hasMoreElements())
                        issueVal = getStringValue(stnKeys.nextToken());
                    if(stnKeys.hasMoreElements())
                        itemVal = getIntValue(stnKeys.nextToken());
                    if(stnKeys.hasMoreElements())
                        authVal = getIntValue(stnKeys.nextToken());

          if(firstTime)
                       rowVals = new Vector();
                  firstTime = false;
                  rowVals.addElement(issueVal+";"+itemVal+";"+authVal);
        }
      }

      if(rowVals != null)
      {
        for(int i = 0; i < rowVals.size(); i++)
        {
          String rowKey = (String) rowVals.elementAt(i);
        issueVal = "";
                itemVal = "";
                authVal = "";
                StringTokenizer stnKeys = new StringTokenizer(rowKey, ";");
                if(stnKeys.hasMoreElements())
                    issueVal = stnKeys.nextToken();
                if(stnKeys.hasMoreElements())
                    itemVal = stnKeys.nextToken();
                if(stnKeys.hasMoreElements())
                    authVal = stnKeys.nextToken();
        String authorName = getStringValue((String) params.get(rowKey+";authorName"));
        String mainOrg = getStringValue((String) params.get(rowKey+";mainOrg"));
        String subOrg = getStringValue((String) params.get(rowKey+";subOrg"));
        String street = getStringValue((String) params.get(rowKey+";street"));
        String city = getStringValue((String) params.get(rowKey+";city"));
        String state = getStringValue((String) params.get(rowKey+";state"));
        String country = getStringValue((String) params.get(rowKey+";country"));
        String postalCode = getStringValue((String) params.get(rowKey+";postalCode"));

        String sql = "INSERT INTO LSTSALES.STOPADDR (AUTHORNAME, MAINORG, SUBORG, SUBORG1, SUBORG2, STREET, CITY, STATE, COUNTRY, POSTALCODE) ( SELECT A.AUTHORNAME, case when D.MAINORG is null then 'NO ORG' else D.MAINORG end, D.SUBORG, D.SUBORG1, D.SUBORG2, D.STREET, D.CITY, D.STATE, CHAR(D.COUNTRYID), D.POSTALCODE FROM LSTSALES.AUTHORS_ADDR D join LSTSALES.AUTHORS A on A.issueno = d.issueno and A.itemno = D.itemno and A.authseq = D.authseq WHERE D.ISSUENO=" + issueVal +  " AND D.ITEMNO=" + itemVal + " AND D.AUTHSEQ=" + authVal + ")";


               logger.debug("StopAddressBean : saveStopAddressInfo : the sql is " + sql);

               doc = DatabaseUtil.setData(sql, params);

        String errMsg = "";
        boolean isSuccess = true;
               if(doc != null)
               {
                 try {
                   NodeList ndl = doc.getElementsByTagName("ERROR");
                   errMsg = ndl.item(0).getFirstChild().getNodeValue();
                   if(errMsg.length() > 0)
                   {
            allErrorMsgs +=errMsg + " While inserting the row for ISSUENO=" + issueVal +  " AND ITEMNO=" + itemVal + "AND AUTHSEQ=" + authVal + ")";
                     logger.debug("OrderBean : errMsg is " + errMsg);
            isSuccess=false;
                   }
                 }catch(Exception e) {
                      logger.debug("OrderBean : Document error " + e);
                 }
               }

        if(isSuccess)
        {
          String sql2 = "DELETE FROM LSTSALES.AUTHORS WHERE ISSUENO=" + issueVal +  " AND ITEMNO=" + itemVal + " AND AUTHSEQ=" + authVal;
          doc = DatabaseUtil.setData(sql2, params);
        }

        errMsg = "";
                if(doc != null)
                {
                    try {
                    NodeList ndl = doc.getElementsByTagName("ERROR");
                    errMsg = ndl.item(0).getFirstChild().getNodeValue();
                    if(errMsg.length() > 0)
                    {
                        allErrorMsgs +=errMsg + " While deleting the row for ISSUENO=" + issueVal +  " AND ITEMNO=" + itemVal + "AND AUTHSEQ=" + authVal;
                        logger.debug("OrderBean : errMsg in deleting the row is " + errMsg);
                        isSuccess=false;
                    }
                    }catch(Exception e) {
                        logger.debug("OrderBean : Document error " + e);
                    }
                }




        }

      }



    }

    return doc;

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
