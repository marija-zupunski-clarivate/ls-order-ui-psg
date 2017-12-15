package com.thomsonreuters.listsales.servlet;

import java.lang.reflect.Method;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomson.ts.framework.util.CollectionUtil;
import com.thomsonreuters.listsales.beans.Constants;
import com.thomsonreuters.listsales.beans.Record;

public class Driver extends BaseServlet {
  protected static Logger logger = LogFactory.getLogger(Driver.class);

  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
  throws javax.servlet.ServletException, java.io.IOException {

    logger.debug("Running the ListSales QC Driver\n");
    //Config objConfig = new Config();
    HttpSession session = request.getSession(true);
    if(session.isNew()) {
      logger.debug("The session is new " + session);
    } else {
      logger.debug("The session is old " + session);
    }
//    session.setMaxInactiveInterval(60);

    try {
    Map paramsMap = request.getParameterMap();
    if(CollectionUtil.isMapEmpty(paramsMap)) {
      if(!session.isNew()) {
        session.invalidate();
      }

      this.showDefaultView(request, response);

      return;
    }

    String menu = request.getParameter("Menu");
    String page = request.getParameter("Page");
    String editviewflag = request.getParameter("editviewflag");
    String co_showMenu = request.getParameter("co_showMenu");  //create order?
    if((menu!=null) && (page!=null))
      {
      if((menu.equals("View Order Info")) && (page.equals("Orders Page")))
      {
        if(!session.isNew())
         {
        if(session.getAttribute("co_showMenu")!=null)
        session.removeAttribute("co_showMenu");
        }
      }
      }
    //the begin page or logout
    if (menu == null && page == null) {
      if(!session.isNew()) {
        session.invalidate();
        session = request.getSession(true);
        logger.debug("Creating the new Session " + session);
      }

      page = "Begin Page";
    }
    //just log in as a new user, destroy old session if any, and create new session
    else if (menu == null && page != null) {
      if (!session.isNew()) {
        logger.debug(" In the If of menu = null and Page not null("+page+")\n");
        session.invalidate();
        session = request.getSession(true);
      }
      //login, authorize user
    }

    //calls under a menu, menu is not null
    else {
      //remove any session attributes belongs to other menus
        logger.debug("The Menu, Page, and objConfig here are " + menu + ", " + page + " and " + objConfig + " \n");
      String[] menus = objConfig.getMenuNames();

      Enumeration attrs = session.getAttributeNames();
      Vector ssnVals = new Vector();
      while (attrs.hasMoreElements()) {
        ssnVals.addElement(attrs.nextElement());
      }

//        while (attrs.hasMoreElements())
      try {
        for(int j = 0; j < ssnVals.size(); j++) {
//          logger.debug("Begin for...the size is :" + ssnVals.size() + " and j is :" + j);
          String key = "";
        try {
            key = (String) ssnVals.elementAt(j);
        }catch(Exception e) {
              if(logger.isErrorEnabled()) {
                logger.error("The error in getting elementAt ", e);
              }
          e.printStackTrace();

          break;
        }
        logger.debug("The key in session is " + key + " and the menu is " + menu);

        if (! key.startsWith(menu)) {
          for (int i = 0; i < menus.length; i++)
          {
              logger.debug("The menu val is " + menus[i]);
            //any session attribute saved under this menu has name start with the menu name
            if (key.startsWith(menus[i])) {
              logger.debug("Key Match...");
              session.removeAttribute(key);
              logger.debug("Key removed...");
              break;
             }

          }
        }
        }
      }catch(Exception e) {
        logger.error("The error in for loop is ", e);
        e.printStackTrace();
      }

      logger.debug("Tracking Path 1");
      //start page for each menu
      if (page == null) page = "Start Page";

      //remove possible child record from session
      String[] childPageNames = objConfig.getChildPageNames(menu, page);
      logger.debug("Tracking Path 2");
      if (childPageNames != null)
        for (int i = 0; i < childPageNames.length; i++)
        {
          logger.debug("The childPageNames are " + menu + childPageNames[i]);
          session.removeAttribute(menu + childPageNames[i]);
        }
    }

    // Would the following line figures out which menu and page?
    logger.debug("The Menu and Page are " + menu + " and " + page + " just before calling objConfig.getPageProp");
    Hashtable config = objConfig.getPageProp(menu, page);
    if(config == null) {
      if(logger.isDebugEnabled()) {
        logger.debug("No config is found for Menu("+menu+") and page("+page+")");
      }
      this.showDefaultView(request, response);

      return;
    }
    logger.debug("objConfig.getPageProp is com.thomsonreuters.listsales.config : " + config);

    //get return page, if can't find, use the default xsl file
    String retPage = (String) config.get("ReturnPage");
    /*
    if(retPage != null
        && !retPage.startsWith("../")
        && !retPage.startsWith("/")) {
      retPage = request.getServletContext().getRealPath("/")+File.separator+retPage;
    }
    */
    logger.debug("retPage before: " + retPage);
    if (retPage == null) retPage = Constants.DEFAULT_XSL;
    logger.debug("retPage again:" + retPage);
    //Start:
    if(co_showMenu!=null)
      {
      if(co_showMenu.equalsIgnoreCase("Y"))
        {
        session.setAttribute("co_showMenu","Y");
        }else
        {
          session.setAttribute("co_showMenu","N");
        }
      }
      //end
    //xsl has to have record
    if (retPage.endsWith(".xsl")) {
       logger.debug(" retPage in xsl " + retPage);
      String recPage = objConfig.getSavedRecPageName(menu, page);
      //error
      if (recPage == null) {
        session.setAttribute("ERROR", "Please specify Workbean for page " + page + " under menu " + menu + ". Or the return page need to be not a xsl file");
        //response.sendRedirect(response.encodeRedirectURL(Constants.ERROR_PAGE));
        showJspView(request, response, Constants.ERROR_PAGE);
        return;
      }

      String reload = request.getParameter("Reload");
      logger.debug("The reload is " + reload);

      // I have put this line for a reason ans testing.... check why again?
      // I guess to be able to enter the If condition (retObj == null || (reload != null && reload.equals("Y")))
      session.removeAttribute(menu + recPage);
      Record retObj = (Record) session.getAttribute(menu + recPage);
      logger.debug("The retObj, menu and recPage is " + retObj + ", and " + menu + " AND " + recPage);

      //get input from request
      Enumeration names = request.getParameterNames();
      Hashtable param = new Hashtable();

      while (names.hasMoreElements()) {
        String name = (String) names.nextElement();
        logger.debug("The name in the request.getParameterNames is " + name + " and the Value is " + request.getParameter(name));
        if (!name.equals("Menu") && !name.equals("Page") && !name.equals("Pageno") && !name.equals("Reload"))
        {
             String[] Vals = request.getParameterValues(name);
             String newVal = Vals[0];
             for(int i = 1; i<Vals.length; i++)
                        {
                            newVal = newVal + "," + Vals[i];
                            logger.debug("The newVal is " + newVal);
                        }
             if(newVal != null) {
               param.put(name, newVal);
             }

            // param.put(name, request.getParameter(name));
        }

      }

      logger.debug("These are the parameters... param :" + param);

      int pagenum = 1;
      //need to call work bean to get record for displaying
      if (retObj == null || (reload != null && reload.equals("Y"))) {
        logger.debug("In the If where the real processing goes on...");
        //get the workbean
        Hashtable[] workbeans;
        if (recPage.equals(page)) {
          if (config.get("WorkBean").getClass().getName().equals(Constants.HASHTABLE)) {

            workbeans = new Hashtable[1];
            workbeans[0] = (Hashtable) config.get("WorkBean");
            logger.debug("Singe Bean 1");
          }
          else {
            logger.debug("More Beans1 # ");
            Vector beanVec = (Vector) config.get("WorkBean");
            logger.debug("The Vec size is " + beanVec.size());
            workbeans = new Hashtable[beanVec.size()];
            for(int i = 0; i < beanVec.size(); i++)
              workbeans[i] = (Hashtable) beanVec.elementAt(i);
        //    workbeans = (Hashtable[]) com.thomsonreuters.listsales.config.get("WorkBean");
            logger.debug("The number of com.thomsonreuters.listsales.beans are" + workbeans.length);
          }
          for(int j = 0; j <workbeans.length; j++)
             logger.debug("The workbean inside if is " + workbeans[j]);
        }
        else {
          Hashtable thePage = objConfig.getPageProp(menu, recPage);
          if (thePage.get("WorkBean").getClass().getName().equals(Constants.HASHTABLE)) {
            workbeans = new Hashtable[1];
            workbeans[0] = (Hashtable) thePage.get("WorkBean");
            logger.debug("Singe Bean2");
          }
          else {
            logger.debug("More Beans2 # ");
            workbeans = (Hashtable[]) thePage.get("WorkBean");
            logger.debug("More Beans2 # " + workbeans.length);
          }
          logger.debug("The workbean inside else is " + workbeans[0]);
        }

        //Connection conn = this.getConnection();
        //param.put("Connection", conn);

        //call work com.thomsonreuters.listsales.beans, it would have an empty constructor,
        //and the method would accept a hashtable as parameter
        try {
          Class[] paramTypes = new Class[1];
          paramTypes[0] = Class.forName(Constants.HASHTABLE);

          Hashtable[] params = new Hashtable[1];
          params[0] = param;

          //clean up record
          retObj = null;

          for (int i = 0; i < workbeans.length; i++) {
            String beanName = (String) ((Hashtable)workbeans[i]).get("Bean");
            logger.debug("The beanName is " + beanName);
            String funcName = (String) ((Hashtable)workbeans[i]).get("Func");
            logger.debug("The funcName is " + funcName);

            Class bean = Class.forName(beanName);
            logger.debug("The bean is " + bean);
            Method func = bean.getDeclaredMethod(funcName, paramTypes);
            logger.debug("The func is " + func);
            Object retRec = func.invoke(bean.newInstance(), params);

            logger.debug("The retRec is " + retRec);
            if (retObj == null && retRec != null)
                retObj = new Record(retRec);
              else if (retObj != null && retRec != null)
                   retObj.addRec(retRec);
          }
          if(retObj == null)
          {
            logger.debug("retObj is still null. So setting it new Record");
            retObj = new Record();
          }
        }catch(Exception e) {
          logger.error("Error in invoking the function...", e);
          session.setAttribute("ERROR", e.toString());
          e.printStackTrace();
          //response.sendRedirect(response.encodeRedirectURL(Constants.ERROR_PAGE));
          showJspView(request, response, Constants.ERROR_PAGE);
          return;
        }
      }//end call work bean
      //no need to call work bean, but have to figure out which record to show
      else {
        logger.debug("In the else where the processing wasn't done...");
        if (request.getParameter("Pageno") != null && !request.getParameter("Pageno").equals(""))
          pagenum = (new Integer(request.getParameter("Pageno"))).intValue();
        else {
          pagenum = retObj.getRecID(param);
          if (pagenum == 0) pagenum = 1;
        }
      }

      logger.debug("Once again the objConfig is " + objConfig);
      logger.debug("The menu and page are " + menu + " and " + page);
      String parent = objConfig.getParentPageName(menu, page);
      String child = objConfig.getFirstChildPageName(menu, page);
      logger.debug("parent and child " + parent + ", " + child);
      int perpage;
      if (config.containsKey("RecPerPage"))
        perpage = (new Integer((String) config.get("RecPerPage"))).intValue();
      else if (request.getParameter("RecPerPage") != null)
        perpage = (new Integer(request.getParameter("RecPerPage"))).intValue();
      else perpage = 0; // show all record

      logger.debug("Step 6..");
      retObj.setDisplayInfo(menu, page, parent, child, pagenum, perpage);

      //save the record under the menu
      request.setAttribute(menu + recPage, retObj);
      request.setAttribute("CurrRecord", menu + recPage);
    }//end if (retPage.endsWith(".xsl"))

//    This is giving error in loading the login page, beacuse there is no session to remove an attribute..
/*
    else
      session.removeAttribute("CurrRecord");
*/

    //send cookie to browser about the return page
    Cookie cookie = new Cookie("RetPage", retPage);
    response.addCookie(cookie);
    session.setAttribute("RetPageSn", retPage);

    if(editviewflag == null)
      {
      if(!session.isNew())
         {
        if(session.getAttribute("co_showMenu")!=null)
        session.setAttribute("editviewflag", "Y");
        }else{
      session.setAttribute("editviewflag", "N");
        }
      }else
      {
      session.setAttribute("editviewflag", "Y");
      }
      logger.debug("The cookie is " + cookie);

    //redirect to jsp page
    String jspFile = (String) config.get("JspPage");

    //if didn't specify jsp page, than use the default one
        logger.debug("The jsp here is " + jspFile);

    if (jspFile == null) {
      this.showDefaultView(request, response);
    } else {
      showJspView(request, response, jspFile);
    }

    logger.debug("Ending the ListSales QC Driver\n");
    }catch(Exception e){
      logger.error("Error in Driver ", e);
      e.printStackTrace();
    //  Cookie cookie = new Cookie("RetPage", "../html/login.html");
     // response.addCookie(cookie);
//      session.setAttribute("RetPageSn", "../html/login.html");
      //response.sendRedirect(response.encodeRedirectURL(jspFile));
      try {
        this.showDefaultView(request, response);
      } catch(Exception e1) {
        logger.error("Error in Driver ", e1);
        e1.printStackTrace();
      }
    }
  }
}
