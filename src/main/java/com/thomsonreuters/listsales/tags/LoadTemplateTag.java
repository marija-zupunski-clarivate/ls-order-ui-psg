package com.thomsonreuters.listsales.tags;

import java.io.File;
import java.util.Enumeration;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import net.sf.saxon.TransformerFactoryImpl;
import net.sf.saxon.om.NamePool;

import org.w3c.dom.Document;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomsonreuters.listsales.beans.Record;


public class LoadTemplateTag extends TagSupport {
  static protected Logger logger=LogFactory.getLogger(LoadTemplateTag.class);

   private String name;
   private Record record;

  // PrintWriter pr = null;
  //PrintWriter out = null;
  // File aFile = new File("/trmtrack/LS/D2W/webApplication/logs/ltt.log");

   public LoadTemplateTag() {
     logger.debug("LoadTemplateTag called...");
   }

   public void setName(String name) {
      this.name = name;
   }

   public void setRecord(Record record) {
      this.record = record;
   }

   public int doStartTag() throws JspException {
    try {
      //document object
      Document doc = record.getDisplayRecord();

      //name is relative path is the config.xml because it's also used in <jsp:include
      String realPath = pageContext.getServletContext().getRealPath(name);
          File stylesheet = new File(realPath);
      logger.debug("The name is " + name);
      logger.debug("The stylesheet.getAbsolutePath is " + stylesheet.getAbsolutePath());
      logger.debug("The stylesheet.getPath is " + stylesheet.getPath());
      logger.debug("The stylesheet.isFile is " + stylesheet.isFile());

          //create transformer
      TransformerFactory tFactory = TransformerFactory.newInstance();
      if(tFactory instanceof TransformerFactoryImpl) {
        ((TransformerFactoryImpl)tFactory).getConfiguration().setNamePool(new NamePool());
        logger.debug("Creating new name pool for saxon");
      }

             StreamSource stylesource = new StreamSource(stylesheet);

             Transformer transformer = tFactory.newTransformer(stylesource);

             ServletRequest request = this.pageContext.getRequest();
             Enumeration parameters = request.getParameterNames();

             String paramName;
             while(parameters.hasMoreElements()) {
               paramName = (String) parameters.nextElement();
               transformer.setParameter(paramName, request.getParameter(paramName));
             }


      //use xsl file to transfer
      transformer.transform(new DOMSource(doc), new StreamResult(pageContext.getOut()));
      logger.debug("TEMPLATE : end");
    }catch (Exception e) {
      if(logger.isErrorEnabled()) {
        logger.error("TEMPLATE("+name+"): ERROR ", e);
      }

      throw new JspException(e.toString());
    }


    return SKIP_BODY;
  }

  public int doEndTag() throws JspException {
    return SKIP_PAGE;
  }
}
