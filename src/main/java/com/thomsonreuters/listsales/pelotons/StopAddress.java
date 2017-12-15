package com.thomsonreuters.listsales.pelotons;

import java.util.Hashtable;

import org.w3c.dom.Document;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomsonreuters.listsales.beans.db2.StopAddressBean;

public class StopAddress {
  static protected Logger logger=LogFactory.getLogger(StopAddress.class);

  StopAddressBean stopBn;
  boolean debug=true;

  public StopAddress()
  {
     stopBn = new StopAddressBean();
       logger.debug("StopAddress Peloton called...");
  }

  public Document getCountriesData(Hashtable paramValues) throws Exception {
        logger.debug("StopAddress Peloton : getCountriesData called...");
    Document resDoc = stopBn.getCountriesInfo(paramValues);

    return resDoc;
  }


  public Document getAddressData(Hashtable paramValues) throws Exception{
        logger.debug("StopAddress Peloton : getOrderData called...");
    Document resDoc = stopBn.getAddressInfo(paramValues);

    return resDoc;
  }

  public Document saveStopAddressData(Hashtable paramValues) throws Exception {
        logger.debug("StopAddress Peloton : saveStopAddressData called...");
    Document resDoc = stopBn.saveStopAddressInfo(paramValues);

    return resDoc;
  }



}



