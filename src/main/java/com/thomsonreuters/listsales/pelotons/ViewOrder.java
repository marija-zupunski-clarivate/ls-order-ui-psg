package com.thomsonreuters.listsales.pelotons;

import java.util.Hashtable;

import org.w3c.dom.Document;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomsonreuters.listsales.beans.db2.OrderBean;

public class ViewOrder {
  static protected Logger logger=LogFactory.getLogger(ViewOrder.class);

  OrderBean orderBn;
  public ViewOrder()
  {
     orderBn = new OrderBean();
       logger.debug("ViewOrder Peloton called...");
  }

  public boolean validateData() {
    return (true);
  }

  public Document getOrderData(Hashtable paramValues) throws Exception {
        logger.debug("ViewOrder Peloton : getData called...");
    Document doc = orderBn.getOrderInfo(paramValues);

    return doc;
  }


  public void setData(Hashtable paramValues) {
        logger.debug("ViewOrder Peloton : setData called...");
  }
}
