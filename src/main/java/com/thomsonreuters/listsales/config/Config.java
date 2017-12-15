package com.thomsonreuters.listsales.config;

import java.io.File;
import java.util.Hashtable;
import java.util.Vector;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomsonreuters.listsales.beans.Constants;

public class Config {
  static protected Logger logger=LogFactory.getLogger(Config.class);

  Document doc;

    String configFile;

  public Config() {
    configFile = Constants.CONFIG_FILE;
  }


  public Config(String configFile) {
    //create document object
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        try {
          DocumentBuilder builder = factory.newDocumentBuilder();
          doc = builder.parse(new File(configFile));
        }catch(Exception e) {
          if(logger.isErrorEnabled()) {
            logger.error("Found Error:", e);
          }
          e.printStackTrace();
        }

    if(logger.isDebugEnabled()) {
      logger.debug("Config class called...");
    }
  }

  public String[] getMenuNames() {
    NodeList menus = (NodeList) doc.getElementsByTagName("Menu");
    int len = menus.getLength();

    String[] menunames = new String[len];
    for (int i = 0; i < len; i++)
      menunames[i] = ((Element) menus.item(i)).getAttribute("name");

    return menunames;
  }

  public Hashtable getPageProp(String menu, String page) {
    Element pageNode = getPageNode(menu, page);

    if(logger.isDebugEnabled()) {
      logger.debug("Calling getPageNode in getPageProp. Menu and Page are " + menu + ", " + page);
      logger.debug("The page node in getPageProp is " + pageNode);
    }
    if (pageNode == null) return null;

    Hashtable ret = new Hashtable();

    NodeList page_props = pageNode.getChildNodes();
    for (int j = 0; j < page_props.getLength(); j++)
      if (page_props.item(j).getNodeType() == Node.ELEMENT_NODE
        && !page_props.item(j).getNodeName().equals("Page")) {

        Element element = (Element) page_props.item(j);
        if(logger.isDebugEnabled()) {
          logger.debug("The element in getPageProp is " + element);
        }

        String name = element.getNodeName();
        Hashtable attrs = null;

        if (element.hasAttributes()) {
          attrs = new Hashtable();
          int len = element.getAttributes().getLength();
          for (int i = 0; i < len; i++)
            attrs.put(element.getAttributes().item(i).getNodeName(), element.getAttributes().item(i).getNodeValue());
        }

        if (ret.containsKey(name)) {
          Vector values = new Vector();
          if (ret.get(name).getClass().getName().equals(Constants.VECTOR))
            values = (Vector) ret.get(name);
          else
            values.add(ret.get(name));

          if (attrs == null)  values.add(element.getFirstChild().getNodeValue());
          else values.add(attrs);

          ret.put(name, values);
        }
        else
          if (attrs == null)  ret.put(name, element.getFirstChild().getNodeValue());
          else ret.put(name, attrs);
      }
    return(ret);
  }

   //get all desendant page names of the page
  public String[] getChildPageNames(String menu, String page) {

    Element node = getPageNode(menu, page);

    if (node == null) return null;

    NodeList children = node.getElementsByTagName("Page");
    int len = children.getLength();
    if (len < 1) return null;

    String[] pagenames = new String[len];
    for (int i = 0; i < len; i++)
      pagenames[i] = ((Element) children.item(i)).getAttribute("name");

    return pagenames;
  }

  //the saved record name should be the closest page ancestor(include itself) which has WorkBean as a child
  public String getSavedRecPageName(String menu, String page) {
    Element node = getPageNode(menu, page);

    if (node == null) return null;

    if (hasChild(node, "WorkBean")) return page;

    Node parent = node.getParentNode();
    while (parent != null) {
      if (parent.getNodeType() == Node.ELEMENT_NODE && parent.getNodeName().equals("Page") && hasChild(parent, "WorkBean"))
        return (((Element) parent).getAttribute("name"));
      parent = parent.getParentNode();
    }
    return null;
  }

  //find out if the node has the specified child
  private boolean hasChild(Node node, String childName) {
    if (node.hasChildNodes()) {
      for(int i = 0; i < node.getChildNodes().getLength(); i ++) {
        Node child = node.getChildNodes().item(i);
        if (child.getNodeType() == Node.ELEMENT_NODE && child.getNodeName().equals(childName))
          return true;
      }
    }
    return false;
  }

  //get the parent page's name
  public String getParentPageName(String menu, String page) {
    Element node = getPageNode(menu, page);
    if (node == null) return null;

    Node parent = node.getParentNode();

    if(logger.isDebugEnabled()) {
      logger.debug("The parent Node is " + parent);
    }

    if(parent != null && parent.getNodeType() == Node.ELEMENT_NODE && parent.getNodeName().equals("Page"))
      return (((Element)parent).getAttribute("name"));

    return null;
  }

  //get the child page's name
  public String getFirstChildPageName(String menu, String page) {
    Element node = getPageNode(menu, page);

    if(logger.isDebugEnabled()) {
      logger.debug("The node in getFirstChildPageName is " + node);
    }
    if (node == null) return null;

    if(logger.isDebugEnabled()) {
      logger.debug("node.getElementsByTagName(Page) is " + node.getElementsByTagName("Page"));
    }
    NodeList tagNames = node.getElementsByTagName("Page");
    if(logger.isDebugEnabled()) {
      for(int i = 0; i < tagNames.getLength(); i++) {
        logger.debug("The item is " + tagNames.item(i).getNodeName());
      }
    }
    if (node.getElementsByTagName("Page").getLength() > 0)
      return ((Element) node.getElementsByTagName("Page").item(0)).getAttribute("name");

    if(logger.isDebugEnabled()) {
      logger.debug("got null here");
      logger.debug("so returning Cust Info Page in getFirstChildPageName");
    }
//    return "Cust Info Page";
    return null;
  }

  private Element getPageNode(String menu, String page) {
    NodeList pages = doc.getElementsByTagName("Page");

    if(logger.isDebugEnabled()) {
      logger.debug("getPageNode: the pages are " + pages);
    }

    for (int i = 0; i < pages.getLength(); i++ ){
      Element thePage = (Element) pages.item(i);

      if(logger.isDebugEnabled()) {
        logger.debug("getPageNode: thePage is " + thePage);
      }

      if (thePage.getAttribute("name").equals(page)) {
        String menuname = getParentMenu(thePage);

        if(logger.isDebugEnabled()) {
          logger.debug("getPageNode: menuname is " + menuname);
        }

        //independent page
        if (menu == null && menuname == null)
        {
          if(logger.isDebugEnabled()) {
            logger.debug("Returning thePage when menu is null " + thePage);
          }
          return thePage;
        }
        //page under a menu
        if (menu != null && menu.equals(menuname))
        {
          if(logger.isDebugEnabled()) {
            logger.debug("Returning thePage " + thePage);
          }
          return thePage;
        }
      }
    }

    return null;
  }

  private String getParentMenu(Element node) {
    Node parent = node.getParentNode();

    if(logger.isDebugEnabled()) {
      logger.debug("The parent is " + parent);
    }
    while (parent != null) {
      if (parent.getNodeType() == Node.ELEMENT_NODE && parent.getNodeName().equals("Menu"))
        return (((Element)parent).getAttribute("name"));

      parent = parent.getParentNode();

      if(logger.isDebugEnabled()) {
        logger.debug("The parent node in while is " + parent);
      }
    }
    return null;
  }

  //get data source constants
  public Hashtable getDataSrc(String srcname) {
    Hashtable ret = new Hashtable();

    NodeList srcs = null;

    try{
       srcs = doc.getDocumentElement().getElementsByTagName("DataSrc");
    }catch(Exception e){
      if(logger.isErrorEnabled()) {
        logger.error("Null here ", e);
      }
    }
    if(srcs != null)
    {
       for(int i = 0; i <  srcs.getLength(); i ++) {
      if (! srcs.item(i).getAttributes().getNamedItem("name").getNodeValue().equals(srcname)) continue;

      NodeList src_props = srcs.item(i).getChildNodes();
      for (int j = 0; j < src_props.getLength(); j++)
        if (src_props.item(j).getNodeType() == Node.ELEMENT_NODE)
          ret.put(src_props.item(j).getNodeName(), src_props.item(j).getFirstChild().getNodeValue());
      return(ret);
       }
    }
    return (null);
  }
}

