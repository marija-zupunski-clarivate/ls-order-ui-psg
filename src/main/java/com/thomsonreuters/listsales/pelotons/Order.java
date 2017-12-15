package com.thomsonreuters.listsales.pelotons;

import java.util.Hashtable;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomson.ts.framework.service.ServiceFactory;
import com.thomson.ts.framework.service.net.EmailHandler;
import com.thomsonreuters.listsales.beans.db2.OrderBean;

public class Order {
  static protected Logger logger=LogFactory.getLogger(Order.class);
  static protected ServiceFactory serviceFactory = ServiceFactory.getInstance();
  static protected EmailHandler emailHandler = (EmailHandler) serviceFactory.getService(EmailHandler.class.getName());

  OrderBean orderBn;
  //PrintWriter pr = null;
  //PrintWriter out = null;
  //  File aFile = new File("/trmtrack/LS/D2W/webApplication/logs/order.log");

  public Order()
  {
     orderBn = new OrderBean();
       logger.debug("Order Peloton called...");
  }

  public boolean validateData() {
    return (true);
  }

  public Document getOrderIdData(Hashtable paramValues) throws Exception {
        logger.debug("Order Peloton : getOrderIdData called...");
    Document doc =  orderBn.getOrderIdInfo(paramValues);


    return doc;
  }

  public Document getShipMethodData(Hashtable paramValues) throws Exception {
        logger.debug("Order Peloton : getShipMethodData called...");
    Document doc =  orderBn.getShipMethodInfo(paramValues);


    return doc;
  }

  public Document getMaxOrderIdData(Hashtable paramValues) throws Exception {
        logger.debug("Order Peloton : getMaxOrderIdData called...");
        Document doc =  orderBn.getMaxOrderIdDocument(paramValues);


        return doc;
    }

  public Document getAllOrderIdsData(Hashtable paramValues) throws Exception{
        logger.debug("Order Peloton : getAllOrderIdsData called...");
        Document doc =  orderBn.getAllOrderIds(paramValues);


        return doc;
    }


  public Document setOrderData(Hashtable paramValues)  throws Exception{
        logger.debug("Order Peloton : setData called...");
    Document rtn = orderBn.saveOrderInfo(paramValues);

    return rtn;
  }

  public Document updateOrderData(Hashtable paramValues)  throws Exception{
        logger.debug("Order Peloton : updateOrderData called...");
        Document rtn = orderBn.updateOrderInfo(paramValues);

        return rtn;
    }

  public Document getPreferencesData(Hashtable paramValues)  throws Exception{
      logger.debug("Order Peloton : getPreferencesInfo : called...");
    Document doc = orderBn.getPreferencesInfo(paramValues);

    return doc;
  }



  public Document getSearchIdData(Hashtable paramValues)  throws Exception{
        logger.debug("Order Peloton : getSearchIdData : called...");
        Document doc = orderBn.getSearchIdInfo(paramValues);

        return doc;
    }


    public Document setOrderInfo(Hashtable param) throws Exception {

    Document dcmnt = null;
    boolean debug;
    String debugStr = (String) param.get("DEBUGSTR");
        if(debugStr != null && debugStr.equals("TRUE")) debug=true;
        debug=true;
        String qFlag = (String) param.get("qFlag");
        String customerId = (String) param.get("customerId");
        String orderId = "";
        String orderName = (String) param.get("orderName");
    if(qFlag == null) qFlag="Q";

        if(debug)logger.debug("Order Peloton : the qFlag is " + qFlag);
        boolean isInsert=true;


        if(qFlag.equals("N"))
        {
          if(debug) logger.debug("Calling Insert...");
      dcmnt = setOrderData(param);
      orderId = (String) param.get("orderId");
          String errMsg = "";
          if(dcmnt != null)
          {
             try {
               NodeList ndl = dcmnt.getElementsByTagName("ERROR");
               errMsg = ndl.item(0).getFirstChild().getNodeValue();
               if(errMsg.length() > 0)
               {
                 isInsert = false;
                 logger.debug("Order Peloton : errMsg is " + errMsg);
               }
         else
           sendEMail("txtsrch", "ts957", "indu.mudigonda@isinet.com", customerId, orderId, orderName);
             }catch(Exception e) {
               logger.debug("Order Peloton : Document error " + e);
             }
          }else
          {
             isInsert = false;
             logger.debug("Order Peloton Error : Document is null.");
          }
        }
        else if(qFlag.equals("U"))
        {
      if(debug) logger.debug("Calling Update...");
          dcmnt = updateOrderData(param);
          String errMsg = "";
          if(dcmnt != null)
          {
             try {
               NodeList ndl = dcmnt.getElementsByTagName("ERROR");
               errMsg = ndl.item(0).getFirstChild().getNodeValue();
               if(errMsg.length() > 0)
               {
                 isInsert = false;
                 logger.debug("Order Peloton : errMsg is " + errMsg);
               }
             }catch(Exception e) {
               logger.debug("Order Peloton : Document error " + e);
             }
          }else
          {
             isInsert = false;
             logger.debug("Order Peloton Error : Document is null.");
          }
        }

    if(isInsert)
        {
          if(debug) logger.debug("Calling getOrderIdData...");
          dcmnt =  getOrderIdData(param);
        }
        else
        {
          if(debug) logger.debug("Insert not Successful...");
          // dcmnt = getMaxOrderIdData(param);
        }
        return dcmnt; 

  }

    public void sendEMail (String userName, String passWord, String emailAddy, String cusId, String ordId, String ordNm) {
      String subject = "New Order Name " + ordNm;

      String messageText = "A New Order has been submitted.\n";
          messageText +="Customer Id: " + cusId + "\n";
          messageText +="Order Id: " + ordId + "\n";
          messageText +="OrderName: " + ordNm + "\n";

      emailHandler.sendEmail("newOrderEmail", subject, messageText);
    }

public void sendEMail_ReplacedByEmailHandler (String userName, String passWord, String emailAddy, String cusId, String ordId, String ordNm) {

String host = "localhost";
String to1 = "indu.mudigonda@isinet.com";
String to2 = "gopala.kuntamukkula@isinet.com";
String to3 = "lsdev@isinet.com"; 
String from = "indu.mudigonda@isinet.com";
// String to = "gopala.kuntamukkula@isinet.com";
String subject = "List Mail: New Order Name " + ordNm;

String messageText = "A New Order has been submitted.\n";
    messageText +="Customer Id: " + cusId + "\n";
    messageText +="Order Id: " + ordId + "\n";
    messageText +="OrderName: " + ordNm + "\n";
boolean sessionDebug = false;

Properties props = System.getProperties();
props.put("mail.smtp.host", host);
props.put("mail.transport.protocol", "smtp");
Session session = Session.getDefaultInstance(props, null);
session.setDebug(sessionDebug);

try {
Message msg = new MimeMessage(session);
msg.setFrom(new InternetAddress(from));
InternetAddress[] address = {new InternetAddress(to1), new InternetAddress(to2), new InternetAddress(to3)};
msg.setRecipients(Message.RecipientType.TO, address);

//InternetAddress to = new InternetAddress("you@example.com");
//message.addRecipient(Message.RecipientType.TO, to);



msg.setSubject(subject);
msg.setSentDate(new java.util.Date());
msg.setText(messageText);
Transport.send(msg);
}
catch (MessagingException mex) {
mex.printStackTrace();
}

}



}
