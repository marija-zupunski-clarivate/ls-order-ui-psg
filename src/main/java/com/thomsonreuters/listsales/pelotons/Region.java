package com.thomsonreuters.listsales.pelotons;

import java.util.Hashtable;

import org.w3c.dom.Document;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomsonreuters.listsales.beans.db2.RegionBean;

public class Region {
  static protected Logger logger=LogFactory.getLogger(Region.class);

  RegionBean rgn;

  public Region()
  {
    rgn = new RegionBean();
        logger.debug("Region Peloton called...");
  }

  public boolean validateData() {
    return (true);
  }

  public void setData(Hashtable paramValues) throws Exception {
        logger.debug("Region Peloton : setData called...");
        rgn.saveRegionInfo(paramValues);

    }

  public Document getCountryData(Hashtable paramValues) throws Exception {
        logger.debug("Region Peloton : getCountryData called...");
        Document doc =  rgn.getCountryInfo(paramValues);


        return doc; 
    }

  public Document getCountryAndRegionData(Hashtable paramValues) throws Exception {
        logger.debug("Region Peloton : getCountryData called...");
        Document doc =  rgn.getRegionCountryInfo(paramValues);


        return doc;
    }

  public Document getStatesData(Hashtable paramValues) throws Exception {
        logger.debug("Region Peloton : getStatesData called...");
        Document doc =  rgn.getStatesInfo(paramValues);       

        return doc;
    }

  public Document getRegionData(Hashtable paramValues) throws Exception {
        logger.debug("Region Peloton : getRegionData called...");
        Document doc =  rgn.getRegionInfo(paramValues);


        return doc; 
    }


    public void setRegionInfo(Hashtable param) throws Exception {
        setData(param);

    }

}
