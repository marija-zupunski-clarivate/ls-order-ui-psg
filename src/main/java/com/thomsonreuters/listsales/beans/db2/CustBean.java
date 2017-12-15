package com.thomsonreuters.listsales.beans.db2;

import java.sql.Connection;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.StringTokenizer;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomsonreuters.listsales.utils.DatabaseUtil;

public class CustBean
{
  static protected Logger logger=LogFactory.getLogger(CustBean.class);

   public Document saveCustomerInfo(Hashtable params) throws Exception
  {
    Document doc = null;

      try
    {

      if(params != null)
      {
       String customerId = getIntValue((String) params.get("customerId"));
       String companyName = getStringValue((String) params.get("companyName"));
       String qFlag = getStringValue((String) params.get("qFlag"));
       String department = getStringValue((String) params.get("department"));
       String fax = getStringValue((String) params.get("fax"));
       String billingAddress = (String) params.get("billingAddress");
        if(billingAddress != null && billingAddress.equals("on")) billingAddress = "'Y'";
        else billingAddress = "'N'";
       String street = getStringValue((String) params.get("street"));
       String city = getStringValue((String) params.get("city"));
       String state = getStringValue((String) params.get("state"));
       String countryId = getIntValue((String) params.get("countryId"));
       String postalCode = getStringValue((String) params.get("postalCode"));
       String notes = (String) params.get("notes");
       notes = getStringValue(modifyNameForSql(notes));
       String status = getStringValue((String) params.get("status"));



       String sql = "INSERT INTO LSTSALES.CUSTOMER (CUSTOMERID, COMPANYNAME, DEPARTMENT, FAX, BILLINGADDRESS, STREET, CITY, STATE, COUNTRYID, POSTALCODE, NOTES, STATUS) VALUES (" + customerId + ", "  + companyName + ", " + department + ", " + fax + ", " + billingAddress + ", " + street + ", " + city + ", " + state + ", " + countryId + ", " + postalCode + ", " + notes + ", " + status + ")";

       logger.debug("CustBean : saveCustomerInfo : the sql is " + sql);


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

       doc = saveContactInfo(params);

        }
      return doc;
    }catch(Exception e) {
      return null;
    }
  }



  public Document saveContactInfo(Hashtable params) throws Exception
  {

    Document doc = null;

        try
        {

          if(params != null)
          {
           String customerId = getIntValue((String) params.get("customerId"));
       String contactFirstname = getStringValue((String) params.get("contactFirstnameNew1"));
           String contactLastname = getStringValue((String) params.get("contactLastnameNew1"));
           String phone = getStringValue((String) params.get("phoneNew1"));
           String emailAddress = getStringValue((String) params.get("emailAddressNew1"));

           String sql = "INSERT INTO LSTSALES.CONTACT (CONTACTID, CUSTOMERID, CONTACTFIRSTNAME, CONTACTLASTNAME, PHONE, EMAILADDRESS) VALUES ";

           if((!contactFirstname.equals("NULL")) && (!contactLastname.equals("NULL")))
           {
                sql += "(";
                sql += "(SELECT MAX(CONTACTID) + 1 FROM LSTSALES.CONTACT), ";
                sql += customerId + ", "  + contactFirstname + ", " + contactLastname + ", " + phone + ", " + emailAddress;
                sql += ")";

                logger.debug("CustBean : saveContactInfo1 : the sql is " + sql);

                doc = DatabaseUtil.setData(sql, params);
           }

       customerId = getIntValue((String) params.get("customerId"));
           contactFirstname = getStringValue((String) params.get("contactFirstnameNew2"));
           contactLastname = getStringValue((String) params.get("contactLastnameNew2"));
           phone = getStringValue((String) params.get("phoneNew2"));
           emailAddress = getStringValue((String) params.get("emailAddressNew2"));

           sql = "INSERT INTO LSTSALES.CONTACT (CONTACTID, CUSTOMERID, CONTACTFIRSTNAME, CONTACTLASTNAME, PHONE, EMAILADDRESS) VALUES ";

           if(!contactFirstname.equals("NULL") && (!contactLastname.equals("NULL")))
           {
                sql += "(";
                sql += "(SELECT MAX(CONTACTID) + 1 FROM LSTSALES.CONTACT), ";
                sql += customerId + ", "  + contactFirstname + ", " + contactLastname + ", " + phone + ", " + emailAddress;
                sql += ")";

                logger.debug("CustBean : saveContactInfo2: the sql is " + sql);


                doc = DatabaseUtil.setData(sql, params);
           }


       Enumeration contactIds = params.keys();
       while(contactIds.hasMoreElements())
           {
       String contactID = (String) contactIds.nextElement();
       String cntId = "";
       if(contactID.startsWith("CNTID"))
             {

        String fnameStr="", lnameStr="", phoneStr="", emailStr="";

               cntId = (String) params.get(contactID);
        logger.debug("The cntId is " + cntId);
        fnameStr="contactFirstname"+cntId;
        logger.debug("The fnameStr is" + fnameStr);
               contactFirstname = getStringValue((String) params.get(fnameStr));
               contactLastname = getStringValue((String) params.get("contactLastname"+cntId));
               phone = getStringValue((String) params.get("phone"+cntId));
               emailAddress = getStringValue((String) params.get("emailAddress"+cntId));

           sql = "UPDATE LSTSALES.CONTACT SET  CONTACTFIRSTNAME="+contactFirstname+", CONTACTLASTNAME="+contactLastname+", PHONE="+phone+", EMAILADDRESS="+emailAddress+" WHERE CONTACTID=" +cntId;
        logger.debug("CustBean : saveContactInfo : the sql is " + sql);


                DB2_XML db2 = new DB2_XML((Connection) params.get("Connection"));
                try {
                    doc = db2.setData(sql);
                }catch(Exception e) {
                    logger.debug("CustBean : saveContactInfo : Error in inserting the data " + e);

                }

       }

       }// end while

        }
          return doc;
        }catch(Exception e) {
          return null;
        }

  }



   public Document updateCustomerInfo(Hashtable params) throws Exception
  {
    Document doc = null;
    if(params != null)
    {
       String customerId = getIntValue((String) params.get("customerId"));
       String companyName = getStringValue((String) params.get("companyName"));
       String qFlag = getStringValue((String) params.get("qFlag"));
       String department = getStringValue((String) params.get("department"));
       String fax = getStringValue((String) params.get("fax"));
       String billingAddress = (String) params.get("billingAddress");
        if(billingAddress != null && billingAddress.equals("on")) billingAddress = "'Y'";
        else billingAddress = "'N'";
       String street = getStringValue((String) params.get("street"));
       String city = getStringValue((String) params.get("city"));
       String state = getStringValue((String) params.get("state"));
       String countryId = getIntValue((String) params.get("countryId"));
       String postalCode = getStringValue((String) params.get("postalCode"));
       String notes = (String) params.get("notes");
       notes = getStringValue(modifyNameForSql(notes));

       String status = getStringValue((String) params.get("status"));

       String sql = "UPDATE LSTSALES.CUSTOMER SET COMPANYNAME="+companyName+", DEPARTMENT="+department+", FAX="+fax+", BILLINGADDRESS="+billingAddress+", STREET="+street+", CITY="+city+", STATE="+state+", COUNTRYID="+countryId+", POSTALCODE="+postalCode+", NOTES="+notes+", STATUS="+status+" WHERE CUSTOMERID=" + customerId;



       DB2_XML db2 = new DB2_XML((Connection) params.get("Connection"));
       try {
          logger.debug("CustBean : updateCustomerInfo : the sql is " + sql);
              doc = db2.setData(sql);
       }catch(Exception e) {
          logger.debug("CustBean : updateCustomerInfo : Error in updating the data " + e);

       }
       doc = saveContactInfo(params);
    }
    return doc;
  }

   public Document getCustomerInfo(Hashtable params) throws Exception
  {
    String customerId = getIntValue((String) params.get("customerId"));
//      String sql = "SELECT A.*, B.*, A.COUNTRYID as CUSTCOUNTRYID, 'Q' as QFLAG from LSTSALES.CUSTOMER A, LSTSALES.CONTACT B";
      String sql = "SELECT A.*, A.COUNTRYID as CUSTCOUNTRYID, 'Q' as QFLAG from LSTSALES.CUSTOMER A";

    if(customerId != null && (!customerId.equals("")))
      {
      sql += " WHERE A.CUSTOMERID=" + customerId + "";
    }

    return DatabaseUtil.getData(sql, params);
  }

  public Document getContactInfo(Hashtable params) throws Exception
    {
        String customerId = getIntValue((String) params.get("customerId"));
        String sql = "SELECT * from LSTSALES.CONTACT";

        logger.debug("CustBean : getContactInfo : the sql is,  " + sql);
        if(customerId != null && (!customerId.equals("") && !customerId.equals("NULL")))
    {
          sql += " WHERE CUSTOMERID=" + customerId + "";

          return DatabaseUtil.getData(sql, params);
        }
        return (null);
    }

  public Document getMaxCustomerId(Hashtable params) throws Exception
    {
    //    String customerId = (String) params.get("customerId");
        String sql = "SELECT  MAX(CUSTOMERID) + 1 as CUSTOMERID, 'N' as QFLAG from LSTSALES.CUSTOMER";

        logger.debug("CustBean : getMaxCustomerId : the sql is,  " + sql);

        return DatabaseUtil.getData(sql, params);
    }


    public Document getCustomerNameValue(Hashtable params) throws Exception
    {
        String customerId = getIntValue((String) params.get("customerId"));
        String sql = "SELECT CUSTOMERID, COMPANYNAME from LSTSALES.CUSTOMER";

    if(!customerId.equals("NULL"))
      sql += " WHERE CUSTOMERID=" + customerId;
       sql += " ORDER BY COMPANYNAME";
        logger.debug("CustBean : getCustomerNameValue : the sql is,  " + sql);
        DB2_XML db2 = new DB2_XML((Connection) params.get("Connection"));

    if(!customerId.equals("NULL"))
    {
      return DatabaseUtil.getData(sql, params);
    }
    else
       return (null);

    }

    public Document getCustIdAndCompanyInfo(Hashtable params) throws Exception
    {
      String sql = "SELECT  CUSTOMERID as CID, COMPANYNAME as CNAME from LSTSALES.CUSTOMER ORDER BY COMPANYNAME";

        logger.debug("CustBean : getCustIdAndCompanyInfo : the sql is,  " + sql);

        return DatabaseUtil.getData(sql, params);
    }


  public Document getActiveCustIdAndCompanyInfo(Hashtable params) throws Exception
    {
        String sql = "SELECT  CUSTOMERID as CID, COMPANYNAME as CNAME from LSTSALES.CUSTOMER WHERE STATUS='Y' ORDER BY COMPANYNAME";

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

