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
import com.thomsonreuters.listsales.beans.db2.CustBean;

public class Customer {
  static protected Logger logger=LogFactory.getLogger(Customer.class);
  static protected ServiceFactory serviceFactory = ServiceFactory.getInstance();
  static protected EmailHandler emailHandler = (EmailHandler) serviceFactory.getService(EmailHandler.class.getName());

  CustBean custBn;
  boolean debug=true;
  //PrintWriter pr = null;
  //PrintWriter out = null;
 //   File aFile = new File("/trmtrack/LS/D2W/webApplication/logs/cust.log");

  public Customer()
  {
     custBn = new CustBean();
       logger.debug("Customer Peloton called...");
  }

  public boolean validateData() {
    return (true);
  }

  public Document getCustData(Hashtable paramValues) throws Exception {
        logger.debug("Customer Peloton : getData called...");
        return custBn.getCustomerInfo(paramValues);
  }

  public Document getContactData(Hashtable paramValues) throws Exception{
        logger.debug("Customer Peloton : getContactData called...");
        return custBn.getContactInfo(paramValues);
  }


  public Document setCustData(Hashtable paramValues) throws Exception {
        logger.debug("Customer Peloton : setCustData called...");
        return custBn.saveCustomerInfo(paramValues);
  }

  public Document updateCustData(Hashtable paramValues) throws Exception {
        logger.debug("Customer Peloton : updateCustData called...");
        return custBn.updateCustomerInfo(paramValues);
  }



  public Document getCustIdAndCompanyData(Hashtable paramValues) throws Exception{
        logger.debug("Customer Peloton : getCustIdAndCompanyData called...");
        return custBn.getCustIdAndCompanyInfo(paramValues);
  }

  public Document getActiveCustIdAndCompanyData(Hashtable paramValues) throws Exception {
        logger.debug("Customer Peloton : getActiveCustIdAndCompanyData called...");
    return custBn.getActiveCustIdAndCompanyInfo(paramValues);
  }


  public Document getMaxCustomerIdData(Hashtable paramValues) throws Exception {
        logger.debug("Customer Peloton : getMaxCustomerIdData called...");
        return custBn.getMaxCustomerId(paramValues);    
    }

  public Document getCustomerName(Hashtable paramValues) throws Exception {
        logger.debug("Customer Peloton : getCustomerName called...");
        Document doc = custBn.getCustomerNameValue(paramValues);
        return doc;
    }


    public Document setCustInfo(Hashtable param) throws Exception {

    Document dcmnt = null;
        logger.debug("Customer Peloton : setCustInfo  called...");


      String debugStr = (String) param.get("DEBUGSTR");
    if(debugStr != null && debugStr.equals("TRUE")) debug=true;
    debug=true;
      String customerId = (String) param.get("customerId");
        String companyName = (String) param.get("companyName");
        String qFlag = (String) param.get("qFlag");

    if(debug) logger.debug("Customer Peloton : The company name and ID is : " + companyName + ", " + customerId);
    if(debug)logger.debug("Customer Peloton : the qFlag is " + qFlag);
    boolean isInsert=true;
    if(qFlag.equals("N"))
    {
      if(debug) logger.debug("Calling Insert..."); 
      dcmnt = setCustData(param);
      String errMsg = "";
      if(dcmnt != null)
      {
       try {
               NodeList ndl = dcmnt.getElementsByTagName("ERROR");
               errMsg = ndl.item(0).getFirstChild().getNodeValue();
         if(errMsg.length() > 0)
         {
          isInsert = false;
                 logger.debug("Customer Peloton : errMsg is " + errMsg);
         }
         else
         {
            sendEMail("txtsrch", "ts957", "jeffrey.cruz@thomsonreuters.com", customerId, companyName);
         }
             }catch(Exception e) {
               logger.debug("Customer Peloton : Document error " + e);
             }
      }else
      {
       isInsert = false;
          logger.debug("Customer Peloton Error : Document is null."); 
      }
    }
    else if(qFlag.equals("U"))
    {
      if(debug) logger.debug("Calling Update..."); 
        dcmnt = updateCustData(param);
      String errMsg = "";
          if(dcmnt != null)
          { 
             try {
               NodeList ndl = dcmnt.getElementsByTagName("ERROR");
               errMsg = ndl.item(0).getFirstChild().getNodeValue();
               if(errMsg.length() > 0)
         {
                 isInsert = false;
                 logger.debug("Customer Peloton : errMsg is " + errMsg);
         }
             }catch(Exception e) {
               logger.debug("Customer Peloton : Document error " + e);
             }
          }else
          { 
             isInsert = false;
             logger.debug("Customer Peloton Error : Document is null.");
          }
    }

    if(isInsert)
    {
        if(debug) logger.debug("Calling getCustData..."); 
          dcmnt =  getCustData(param);
    }
    else 
    {
        if(debug) logger.debug("Insert not Successful....."); 
    //  dcmnt = getMaxCustomerIdData(param);
    }
        return dcmnt; 

  }

/*
       try {
           NodeList ndl = tempDoc.getElementsByTagName("CUSTOMERID");
           elmItem = ndl.item(0).getFirstChild().getNodeValue();
         logger.debug("Customer Peloton : elmItem is " + elmItem);
           }catch(Exception e) {
           logger.debug("Customer Peloton : the elmItem error " + e);
       }
*/


public void sendEMail (String userName, String passWord, String emailAddy, String custId, String comNm) {
  String subject = "New Customer Name " + comNm;

  String messageText = "A new customer has been submitted.\n";
      messageText += "Customer ID: " + custId + "\n"; 
      messageText += "Company Name: " + comNm + "\n"; 

  emailHandler.sendEmail("newCustomerEmail", subject, messageText);
}


public void sendEMail_ReplacedByEmailHandler (String userName, String passWord, String emailAddy, String custId, String comNm) {

String host = "localhost";
String from = "jeffrey.cruz@thomsonreuters.com";
String to = "jeffrey.cruz@thomsonreuters.com";
String subject = "List Sales: New Customer Name " + comNm;

String messageText = "A new customer has been submitted.\n";
    messageText += "Customer ID: " + custId + "\n"; 
    messageText += "Company Name: " + comNm + "\n"; 
boolean sessionDebug = false;

Properties props = System.getProperties();
props.put("mail.smtp.host", host);
props.put("mail.transport.protocol", "smtp");
Session session = Session.getDefaultInstance(props, null);
session.setDebug(sessionDebug);

try {
Message msg = new MimeMessage(session);
msg.setFrom(new InternetAddress(from));
InternetAddress[] address = {new InternetAddress(to)};
msg.setRecipients(Message.RecipientType.TO, address);
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

