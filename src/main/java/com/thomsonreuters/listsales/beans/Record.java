package com.thomsonreuters.listsales.beans;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;

public class Record {
  static protected Logger logger=LogFactory.getLogger(Record.class);

  private String menu;
  private String page;
  private Document records;
  private int start;
  private int end;
  private String parent;
  private String child;
  private String title;
  private int size;
  private String err = null;
  private int pageno = 0;
  //File aFile = new File("/trmtrack/LS/D2W/webApplication/logs/rec.log");
  //PrintWriter out = null;

  public Record(Object records) {
        logger.debug("Record called...");

    if (records.getClass().getName().equals(Constants.VECTOR))
      size = ((Vector) records).size();
    else
      size = ((Document) records).getElementsByTagName("Record").getLength();

    this.records = getDomRecord(records);
  }

  public Record() {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;
        Document dcm;
    try {
               builder = factory.newDocumentBuilder();
               dcm = builder.newDocument();
        }catch(Exception e){
         dcm = null;
      // do something later....
        }

    size = 0;
    this.records = dcm;
//    this.records = getDomRecord(new Vector());

  }


  public void addRec(Object recs) {
      logger.debug("Record : calling addRec ");
            int rec_len = 0;
            //xml dom object
            if (!recs.getClass().getName().equals(Constants.VECTOR)) {
                  if (((Document) recs).getDocumentElement().getNodeName().equals("ERROR")) {
                        err = ((Document) recs).getDocumentElement().getFirstChild().getNodeValue();
                        return;
                  }
                  if (((Document) recs).getElementsByTagName("Record") != null)
                        rec_len = ((Document) recs).getElementsByTagName("Record").getLength();
                  for (int i = 0; i < rec_len; i++) {
                        Element rec = (Element) ((Document) recs).getElementsByTagName("Record").item(i);
                        rec.setAttribute("ID", (size + i + 1) + "");
                        records.getDocumentElement().appendChild(records.importNode(rec,true));
                  }
                  return;
            }
            //vector record
            rec_len = ((Vector) recs).size();
            if (rec_len > 0) {
                  if (((Hashtable) ((Vector) recs).elementAt(0)).get("ERROR") != null) {
                        err = (String) ((Hashtable) ((Vector) recs).elementAt(0)).get("ERROR");
                        return;
                  }
                  for(int i = 0; i < rec_len; i++) {
                        Hashtable record = (Hashtable) ((Vector)recs).elementAt(i);
                        Element rec = records.createElement("Record");
                        rec.setAttribute("ID", (size + i + 1) + "");
                        convertToDom(record, rec);
                        records.getDocumentElement().appendChild(rec);
                  }
            }
            size += rec_len;
      }



  public int getPageno() {
    return pageno;
  }

  public void setDisplayInfo(String menu, String page, String parent, String child, int pageno, int perpage) {
    this.menu = menu;
    this.page = page;
    this.parent = parent;
    this.child = child;
    this.title = menu + " -- " + page;
    this.pageno = pageno;

    if (records.getClass().getName().equals(Constants.VECTOR))
            size = ((Vector) records).size();
        else
            size = ((Document) records).getElementsByTagName("Record").getLength();
    logger.debug("Record: the size is " + size);

    start = perpage * (pageno - 1) + 1;
    end = perpage * pageno;
    if (end > size) end = size;

    if (size == 0) start = 0;
    if (perpage > size || perpage == 0) end = size;
  }

  public Document getDisplayRecord() {
    //create document object
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;
        try {
          builder = factory.newDocumentBuilder();
        } catch (ParserConfigurationException e) {
          err = e.toString();
          return null;
        }
        Document doc = builder.newDocument();

    Node root = doc.createElement("Records");

    //add Title
    Element elm = doc.createElement("Title");
         elm.appendChild(doc.createTextNode(title));
         root.appendChild(elm);

    //add Parent
    elm = doc.createElement("Parent");
         elm.appendChild(doc.createTextNode(parent));
         root.appendChild(elm);

         //add child
         elm = doc.createElement("Child");
         elm.appendChild(doc.createTextNode(child));
         root.appendChild(elm);

    //add Menu
    elm = doc.createElement("Menu");
         elm.appendChild(doc.createTextNode(menu));
         root.appendChild(elm);

    //add Page
    elm = doc.createElement("Page");
         elm.appendChild(doc.createTextNode(page));
         root.appendChild(elm);

    //add Size
    elm = doc.createElement("Size");
         elm.appendChild(doc.createTextNode("" + size));
         root.appendChild(elm);

    //add Start and end
    elm = doc.createElement("Start");
        elm.appendChild(doc.createTextNode("" + start));
    root.appendChild(elm);

    elm = doc.createElement("End");
        elm.appendChild(doc.createTextNode("" + end));
    root.appendChild(elm);

    //add pageno
    elm = doc.createElement("Pageno");
        elm.appendChild(doc.createTextNode("" + pageno));
    root.appendChild(elm);

    //get records
    NodeList recs = records.getElementsByTagName("Record");
    if (size > 0)
      for(int i = start - 1; i < end; i++)
        root.appendChild(doc.importNode(records.getElementsByTagName("Record").item(i), true));

    doc.appendChild(root);

    return doc;
  }

  public int getRecID(Hashtable param) {
    NodeList recs = records.getElementsByTagName("Record");
    for (int i = 0; i < recs.getLength(); i++) {
      Element rec = (Element) recs.item(i);

      Enumeration keys = param.keys();

      boolean found = false;
      while (keys.hasMoreElements()) {
        String key = (String) keys.nextElement();

        found = hasChild(rec, key, (String) param.get(key));
      }
      if (found) return (new Integer(rec.getAttribute("ID"))).intValue();
    }
    return 0;
  }

  //find out if the node has the specified child
  private boolean hasChild(Element node, String childName, String value) {
    if (node.hasChildNodes()) {
      for(int i = 0; i < node.getChildNodes().getLength(); i ++) {
        Node child = node.getChildNodes().item(i);
        if (child.getNodeType() == Node.ELEMENT_NODE
          && child.getNodeName().equals(childName)
          && child.getFirstChild().getNodeValue().equals(value))
          return true;
      }
    }
    return false;
  }

  private Document getDomRecord(Object recs) {
    if (!recs.getClass().getName().equals(Constants.VECTOR)) {
      for (int i = 0; i < size; i++) {
        Element rec = (Element) ((Document) recs).getElementsByTagName("Record").item(i);
        rec.setAttribute("ID", (i+1) + "");
      }
      return (Document)recs;
    }

    //create document object
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder;
        try {
          builder = factory.newDocumentBuilder();
        } catch (ParserConfigurationException e) {
          err = e.toString();
          return null;
        }
        Document doc = builder.newDocument();

    Element root = doc.createElement("Records");

    if (size > 0) {
      if (((Hashtable) ((Vector) recs).elementAt(0)).get("ERROR") != null) {
        Node err = doc.createElement("ERROR");
        err.appendChild(doc.createTextNode((String) ((Hashtable) ((Vector) recs).elementAt(0)).get("ERROR")));
        doc.appendChild(err);
        return doc;
      }

      for(int i = 0; i < size; i++) {
        Hashtable record = (Hashtable) ((Vector)recs).elementAt(i);
        Element rec = doc.createElement("Record");
        rec.setAttribute("ID", (i+1) + "");
        convertToDom(record, rec);
        root.appendChild(rec);
      }
    }

    doc.appendChild(root);

    return doc;
  }

  private void convertToDom(Hashtable hash, Element node) {

    Enumeration en = hash.keys();
       while (en.hasMoreElements()) {
           String elmName = (String)en.nextElement();
          Element elm = node.getOwnerDocument().createElement(elmName);
          Object data = hash.get(elmName);

          if (data.getClass().getName().equals(Constants.STRING)) {
            elm.appendChild(node.getOwnerDocument().createTextNode((String)data));
        node.appendChild(elm);
          }

          else if (data.getClass().getName().equals(Constants.VECTOR)) {
            for (int i = 0; i < ((Vector) data).size(); i++) {
              Object childData = ((Vector) data).elementAt(i);
              if (childData.getClass().getName().equals(Constants.STRING)) {
                elm.appendChild(node.getOwnerDocument().createTextNode((String)childData));
                node.appendChild(elm);
                elm = node.getOwnerDocument().createElement(elmName);
              }
              //hash table
              else if (childData.getClass().getName().equals(Constants.HASHTABLE)) {
                convertToDom((Hashtable)childData, elm);
              }
            }
          }
       }
  }

  public String getErrMsg() {
    return err;
  }
}

