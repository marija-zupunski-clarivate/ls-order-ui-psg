package com.thomsonreuters.listsales.pelotons;

import java.util.Hashtable;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomsonreuters.listsales.beans.db2.ResultsBean;

public class Results {
  static protected Logger logger=LogFactory.getLogger(Results.class);

  ResultsBean resultBn;

  public Results()
  {
     resultBn = new ResultsBean();
       logger.debug("Results Peloton called...");
  }

  public boolean validateData() {
    return (true);
  }

  public Document setResultsData(Hashtable paramValues) throws Exception {
        logger.debug("Results Peloton : setResultsData called...");
        Document doc = resultBn.saveOrderResultsInfo(paramValues);
        return doc;
    }

  public Document getOrderData(Hashtable paramValues) throws Exception {
        logger.debug("Results Peloton : getOrderData called...");
    Document doc = resultBn.getOrderInfo(paramValues);

    return doc;
  }

  public Document getCompanyContactData(Hashtable paramValues) throws Exception {
        logger.debug("Results Peloton : getCompanyContactData called...");
        Document doc = resultBn.getCompanyContactInfo(paramValues);

        return doc;
    }


  public Document getSearchData(Hashtable paramValues) throws Exception {
        logger.debug("Results Peloton : getSearchData called...");
    Document doc = resultBn.getSearchInfo(paramValues);

    return doc;
  }

  public Document getProfileData(Hashtable paramValues) throws Exception {
        logger.debug("Results Peloton : getProfileData called...");
    Document doc = resultBn.getProfileInfo(paramValues);

    return doc;
  }


  public Document getOrderResultsData(Hashtable paramValues) throws Exception {
        logger.debug("Results Peloton : getOrderResultsData called...");
    Document doc = resultBn.getOrderResultsInfo(paramValues);

    return doc;
  }

  public Document getExtractData(Hashtable paramValues) throws Exception {
        logger.debug("Results Peloton : getExtractData called...");
        Document doc = resultBn.getExtractInfo(paramValues);

        return doc;
    }

  public Document getPreferencesData(Hashtable paramValues) throws Exception {
        logger.debug("Results Peloton : getPreferencesData called...");
        Document doc = resultBn.getPreferencesInfo(paramValues);

        return doc;
    }

  public Document setResultsInfo(Hashtable paramValues) throws Exception {
    Document dcmnt;
    boolean isInsert=true;
    String qFlag = (String) paramValues.get("qFlag");
    if(qFlag == null)
      qFlag = "Q";

    if(qFlag.equals("U"))
    {
       dcmnt = setResultsData(paramValues);
       String errMsg = "";
           if(dcmnt != null)
           {
             try {
               NodeList ndl = dcmnt.getElementsByTagName("ERROR");
               errMsg = ndl.item(0).getFirstChild().getNodeValue();
               if(errMsg.length() > 0)
               {
                 isInsert = false;
                 logger.debug("Results Peloton : errMsg is " + errMsg);
               }
             }catch(Exception e) {
               logger.debug("Results Peloton : Document error " + e);
             }
           }
       else
          isInsert = false;

       if(isInsert)
           {
             logger.debug("Calling getOrderResultsData...");
             dcmnt =  getOrderResultsData(paramValues);
           }
           else
           {
             logger.debug("Insert not Successful...");
           }
    }
    else
      dcmnt =  getOrderResultsData(paramValues);


    return dcmnt;
  }




}
