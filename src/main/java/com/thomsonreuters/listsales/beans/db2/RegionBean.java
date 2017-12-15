package com.thomsonreuters.listsales.beans.db2;

import java.sql.Connection;
import java.util.Hashtable;
import java.util.StringTokenizer;
import java.util.Vector;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomsonreuters.listsales.utils.DatabaseUtil;

public class RegionBean
{
  static protected Logger logger=LogFactory.getLogger(RegionBean.class);

   public void saveRegionInfo(Hashtable params) throws Exception
  {
     Document doc = null;
    if(params != null)
    {
       String countryId = "";
       String countries = (String) params.get("country");
       Vector allCountries = null;
       Vector newCountries = new Vector();
       if(countries == null)
       countries = "";
       StringTokenizer stn = new StringTokenizer(countries, ",");
       String countriesInfo = "";
       String region = (String) params.get("region");
       boolean proceed = false;
       boolean firstTime = true;
       boolean isThereNewCountry = false;
       boolean newRegion = false;


       String newRgn = "";
       if(region.startsWith("ID;"))
       {
          String IDStr = "";
        newRegion=true;
        StringTokenizer rgnStn = new StringTokenizer(region, ";");
        if(rgnStn.hasMoreTokens()) IDStr = rgnStn.nextToken();
        if(rgnStn.hasMoreTokens()) newRgn = rgnStn.nextToken();
       }
       newRgn = getStringValue(newRgn);

       while(stn.hasMoreTokens())
       {
        String IDStr = "";
        String newCtr = "";
        String ctrVal = "";
        String ctrStr = stn.nextToken();
        if(ctrStr.startsWith("ID;"))
        {
         isThereNewCountry = true;
        StringTokenizer ctrStn = new StringTokenizer(ctrStr, ";");
        if(ctrStn.hasMoreTokens()) IDStr = ctrStn.nextToken();
        if(ctrStn.hasMoreTokens()) newCtr = ctrStn.nextToken();

        StringTokenizer ctrVals = new StringTokenizer(newCtr, "|");
        ctrVal = "";
                if(ctrVals.hasMoreTokens()) ctrVal = ctrVals.nextToken();
        newCountries.addElement(ctrVal);
        }
        else
        {
        if(firstTime)
               allCountries = new Vector();
        firstTime = false;
        logger.debug("The ctrStr is " + ctrStr);
        StringTokenizer ctrVals = new StringTokenizer(ctrStr, "|");
        ctrVal = "";
                if(ctrVals.hasMoreTokens()) ctrVal = ctrVals.nextToken();
        logger.debug("The ctrVal is " + ctrVal);
          allCountries.addElement(ctrVal);
        }
       }

       DB2_XML db2;

       if(newRegion)
       {

         String sql = "INSERT INTO LSTSALES.REGION (REGIONID, REGION) VALUES ((SELECT MAX(REGIONID) + 1 FROM LSTSALES.REGION), " + newRgn + ")";
       logger.debug("RegionBean : saveRegionInfo : the sql is, " + sql);

       doc = DatabaseUtil.setData(sql, params);
       }

       if(isThereNewCountry)
       {

      String rgnId="";
            if(newRegion)
              rgnId="(SELECT REGIONID FROM LSTSALES.REGION WHERE REGION="+newRgn+")";
            else
              rgnId=region;
        rgnId = getIntValue(rgnId);

        for(int i = 0; i < newCountries.size(); i++)
        {
            db2 = new DB2_XML((Connection) params.get("Connection"));
         String newCtrVal = getStringValue((String) newCountries.elementAt(i));
             String sqlInsert = "INSERT INTO LSTSALES.COUNTRY (COUNTRYID, COUNTRY, REGIONID) VALUES ((SELECT MAX(COUNTRYID) + 1 FROM LSTSALES.COUNTRY), " + newCtrVal + ", " + rgnId + ")";
             logger.debug("RegionBean : saveRegionInfo : the sql is, " + sqlInsert);
         try {
                   db2.setData(sqlInsert);

         }catch(Exception e) {
          logger.debug("RegionBean : Error Inserting the data " + e);
         }
        }

       }

       if(allCountries != null && region != null && allCountries != null)
          {
         String rgnId="";
           if(newRegion)
           rgnId="(SELECT REGIONID FROM LSTSALES.REGION WHERE REGION="+newRgn+")";
         else
          rgnId=region;
         rgnId = getIntValue(rgnId);


        String sqlTemp = "UPDATE LSTSALES.COUNTRY SET REGIONID=NULL WHERE REGIONID=" + rgnId;
            logger.debug("RegionBean : saveRegionInfo : the sqlTemp is, " + sqlTemp);
        try {
                   db2 = new DB2_XML((Connection) params.get("Connection"));
                   doc = db2.setData(sqlTemp);

                 }catch(Exception e) {
                    logger.debug("RegionBean : Error updating the data " + e);
                 }
        String errMsg = "";
                if(doc != null)
                {
                   try {
                   NodeList ndl = doc.getElementsByTagName("ERROR");
                   errMsg = ndl.item(0).getFirstChild().getNodeValue();
                   if(errMsg.length() > 0)
                   {
                     logger.debug("RegionBean : errMsg is " + errMsg);
                     return;
                   }
                 }catch(Exception e) {
                   logger.debug("RegionBean : Document error " + e);
                 }
               }


           String sql = "UPDATE LSTSALES.COUNTRY SET REGIONID=" + rgnId + " WHERE COUNTRYID IN ";
         if(allCountries.size() > 0)
              countriesInfo = (String) allCountries.elementAt(0);
           for(int i = 1; i < allCountries.size(); i++)
               countriesInfo = countriesInfo + ", " + allCountries.elementAt(i) + "";

           sql += "(" + countriesInfo + ")";
             logger.debug("RegionBean : saveRegionInfo : the sql is, " + sql);

         try {
              db2 = new DB2_XML((Connection) params.get("Connection"));
                   db2.setData(sql);

         }catch(Exception e) {
          logger.debug("RegionBean : Error updating the data " + e);
         }
       }
    }
  }


  public Document getCountryInfo(Hashtable params) throws Exception
    {
        String sql = "SELECT COUNTRYID, COUNTRY from LSTSALES.COUNTRY ORDER BY COUNTRY";

        return DatabaseUtil.getData(sql, params);
    }

  public Document getStatesInfo(Hashtable params) throws Exception
    {
        String sql = "SELECT STATEID, STATE from LSTSALES.STATES ORDER BY STATE";

        logger.debug("RegionBean : getStatesInfo : the sql is,  " + sql);

        return DatabaseUtil.getData(sql, params);
    }

   public Document getRegionInfo(Hashtable params) throws Exception
  {
      String sql = "SELECT * from LSTSALES.REGION ORDER BY REGION";

    logger.debug("RegionBean : getRegionInfo : the sql is,  " + sql);

      return DatabaseUtil.getData(sql, params);
  }

  public Document getRegionCountryInfo(Hashtable params) throws Exception
    {
        String sql = "SELECT COUNTRYID as CNTID, COUNTRY as CNTR, REGIONID as REGID from LSTSALES.COUNTRY ORDER BY COUNTRY";

        logger.debug("RegionBean : getRegionInfo : the sql is,  " + sql);

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


}
