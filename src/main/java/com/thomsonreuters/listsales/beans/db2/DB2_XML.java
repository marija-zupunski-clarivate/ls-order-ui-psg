package com.thomsonreuters.listsales.beans.db2;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomsonreuters.listsales.utils.DatabaseServiceException;
import com.thomsonreuters.listsales.utils.DatabaseUtil;

public class DB2_XML {
  static protected Logger logger=LogFactory.getLogger(DB2_XML.class);

  Connection conn;
  //PrintWriter pr = null;
    //PrintWriter out = null;
    //File aFile = new File("/trmtrack/LS/D2W/webApplication/logs/xmlDev.log");
  public DB2_XML() {
  }

  public DB2_XML(Connection conn) {
      logger.debug("DB2_XML: The conn is " + conn);
    this.conn = conn;

  }

  Connection getConnection() throws Exception {
    if(this.conn != null) {
      return this.conn;
    }

    try {
      conn = DatabaseUtil.getConnection();

      return conn;
    } catch(Exception e) {
      if(logger.isErrorEnabled()) {
        logger.error("Error to get connection:", e);
      }

      e.printStackTrace();

      throw e;
    }
  }

    public Document setData(String sql) throws DatabaseServiceException {
        Document doc = null;
    int code = 0;

        //create document object
    Connection conn = this.conn;
      try {
          DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
      DocumentBuilder builder = factory.newDocumentBuilder();
          doc = builder.newDocument();
      Element root = doc.createElement("Records");
      Element record = doc.createElement("Record");
          Element err = doc.createElement("ERROR");

          try {
          if(conn == null) {
            conn = this.getConnection();
          }

            Statement stmt = conn.createStatement();
            logger.debug("DB2_XML: the sql is " + sql);
            stmt.executeUpdate(sql);
      logger.debug("DB2_XML: executeUpdate processed.");
            err.appendChild(doc.createTextNode(""));
      record.appendChild(err);
      root.appendChild(record);
          doc.appendChild(root);

          stmt.close();
      }catch (SQLException  ex) {
      code  = ex.getErrorCode();
      logger.debug("DB2_XML setData : SQLException " + ex);
            err.appendChild(doc.createTextNode("Error in saving the data. SQL Code #: " + code));
            record.appendChild(err);
      root.appendChild(record);
          doc.appendChild(root);
      String errMsg = "";
            try {
               NodeList ndl = doc.getElementsByTagName("ERROR");
               errMsg = ndl.item(0).getFirstChild().getNodeValue();
               logger.debug("DB2_XML setData : errMsg is " + errMsg);
            }catch(Exception exp) {
               logger.debug("DB2_XML setData : the Document error " + exp);
            }

            throw new DatabaseServiceException(ex);
      }catch (Exception  e) {
            logger.debug("DB2_XML setData : Exception " + e);
            err.appendChild(doc.createTextNode("Error in saving the data."));
      record.appendChild(err);
      root.appendChild(record);
          doc.appendChild(root);
      String errMsg = "";
      try {
               NodeList ndl = doc.getElementsByTagName("ERROR");
               errMsg = ndl.item(0).getFirstChild().getNodeValue();
               logger.debug("DB2_XML setData : errMsg is " + errMsg);
            }catch(Exception exp) {
               logger.debug("DB2_XML setData : the Document error " + exp);
            }

      throw new DatabaseServiceException(e);
         }

          return doc;
     }catch (Exception  e) {
     logger.debug("DB2_XML setData : Document Exception ", e);

     throw new DatabaseServiceException(e);
    } finally {
      DatabaseUtil.closeConnection(conn);
      this.conn = null;
    }
    }


  public Document getData(String sql) throws DatabaseServiceException {
    Document doc = null;

    //create document object
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;
    int code = 0;

    Connection conn = this.conn;
        try {
          builder = factory.newDocumentBuilder();
           doc = builder.newDocument();
//      logger.debug("DB2_XML: The doc is " + doc);

          Element root = doc.createElement("Records");
//      logger.debug("DB2_XML: The root first is " + root);

          if(conn == null) {
            conn = getConnection();
          }
      Statement stmt = conn.createStatement();
      logger.debug("DB2_XML: the stmt is " + stmt);
      logger.debug("DB2_XML: the sql is " + sql);
      ResultSet rs = stmt.executeQuery(sql);
      logger.debug("DB2_XML: the rs is " + rs);
      ResultSetMetaData rsmd = rs.getMetaData();
//      logger.debug("DB2_XML: the rsmd is " + rsmd);

      int numberOfColumns = rsmd.getColumnCount();
      String[] colNames = new String[numberOfColumns];

         for (int i = 1; i <= numberOfColumns; i++)
      {
           colNames[i - 1] = rsmd.getColumnLabel(i);
        logger.debug("DB2_XML: The colName here is " + colNames[i - 1]);

      }

      while (rs.next()) {
        Element record = doc.createElement("Record");
//          logger.debug("DB2_XML: The record first is " + record);

        Hashtable elements = new Hashtable();
        for (int i = 1; i <= numberOfColumns; i++)  {
          Object obj = rs.getObject(i);
          String str = "";
          if (obj != null)
            str = obj.toString();

          if (elements.containsKey(colNames[i - 1]) && ((String)elements.get(colNames[i - 1])).equals(str)) continue;

          elements.put(colNames[i - 1], str);
          Element elm = doc.createElement(colNames[i - 1]);
              elm.appendChild( (Node)doc.createTextNode(str));
          record.appendChild(elm);
        }
        root.appendChild(record);
      }

            Element err = doc.createElement("ERROR");
      err.appendChild(doc.createTextNode(""));
      Element record = doc.createElement("Record");
            record.appendChild(err);
            root.appendChild(record);
      doc.appendChild(root);

      stmt.close();
    }catch (SQLException  ex) {
      if(logger.isErrorEnabled()) {
        logger.error("DB2_XML getData(sql:"+sql+") -- ", ex);
      }
      ex.printStackTrace();

      code  = ex.getErrorCode();
      Element root = doc.createElement("Records");
            Element record = doc.createElement("Record");
            Element err = doc.createElement("ERROR");
            err.appendChild(doc.createTextNode("Error retrieving the data. SQL Code #: " + code));
            record.appendChild(err);
            root.appendChild(record);
            doc.appendChild(root);
      String errMsg = "";
            try {
               NodeList ndl = doc.getElementsByTagName("ERROR");
               errMsg = ndl.item(0).getFirstChild().getNodeValue();
               logger.debug("DB2_XML getData(sql:"+sql+"), errMsg is " + errMsg);
            }catch(Exception exp) {
               logger.debug("DB2_XML getData(sql:"+sql+"),the Document error " + exp);
            }

            throw new DatabaseServiceException(ex);
    }catch (Exception  e) {
      if(logger.isErrorEnabled()) {
        logger.error("DB2_XML getData(sql:"+sql+") --", e);
      }

      e.printStackTrace();

          Element root = doc.createElement("Records");
      Element record = doc.createElement("Record");
            Element err = doc.createElement("ERROR");
            err.appendChild(doc.createTextNode("Error retrieving the data."));
      record.appendChild(err);
      root.appendChild(record);
            doc.appendChild(root);
      String errMsg = "";
            try {
               NodeList ndl = doc.getElementsByTagName("ERROR");
               errMsg = ndl.item(0).getFirstChild().getNodeValue();
               logger.error("DB2_XML getData(sql:"+sql+")  : errMsg is " + errMsg);
            }catch(Exception exp) {
               logger.error("DB2_XML getData(sql:"+sql+")  : the Document error ", exp);
            }

            throw new DatabaseServiceException(e);
    } finally {
      DatabaseUtil.closeConnection(conn);
      this.conn = null;
    }
    //System.logger.debug(doc.getDocumentElement().getChildNodes().getLength());
    logger.debug("DB2_XML(sql:"+sql+") : The doc is " + doc);

    return doc;
  }

  public Element getRecElm(Document doc, String name, String value) {
    for (int i = 0; i < doc.getElementsByTagName("Record").getLength(); i++) {
      Node rec = doc.getElementsByTagName("Record").item(i);
      if (rec.getNodeType() == Node.ELEMENT_NODE && rec.hasChildNodes()) {
        NodeList elements = rec.getChildNodes();
        for (int j = 0; j < elements.getLength(); j++) {
          Node element = elements.item(j);
          if (element.getNodeType() == Node.ELEMENT_NODE && element.getNodeName().equals(name) && element.getFirstChild().getNodeValue().equals(value))
            return (Element) rec;
        }
      }
    }

    return null;
  }
}

