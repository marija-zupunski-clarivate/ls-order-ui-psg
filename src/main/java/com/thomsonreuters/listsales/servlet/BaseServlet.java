package com.thomsonreuters.listsales.servlet;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomsonreuters.listsales.beans.Constants;
import com.thomsonreuters.listsales.config.Config;
import com.thomsonreuters.listsales.utils.DatabaseUtil;

public abstract class BaseServlet extends HttpServlet {
  protected static Logger logger = LogFactory.getLogger(BaseServlet.class);
  protected static String LIST_DB_DS_NAME = "java:/comp/env/jdbc/listDB";
  protected static Config objConfig;

  public BaseServlet() {
    super();
  }

  public void init() throws javax.servlet.ServletException {
    if(objConfig == null) {
      String configFile = this.getServletContext().getInitParameter(Constants.PARAM_CONFIG_FILE);
      configFile = this.getRealPath(this.getServletContext(), configFile);

      objConfig = new Config(configFile);
    }

    logger.debug("Starting the ListSales QC Driver\n");

    logger.debug("In the Init of Driver Servlet\n");
    //if(isDebug) logger.debug("The com.thomsonreuters.listsales.config datasrc is : " + config);

    DatabaseUtil.initDataSource (LIST_DB_DS_NAME);
  }

  public void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response)
      throws javax.servlet.ServletException, java.io.IOException {
            processRequest(request, response);
      }

  public void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response)
      throws javax.servlet.ServletException, java.io.IOException {
            processRequest(request, response);
      }

  public void destroy() {
    super.destroy();
    //com.thomsonreuters.listsales.pool.closeAllConnections();
    //com.thomsonreuters.listsales.pool = null;
  }

  protected void showJspView(HttpServletRequest request, HttpServletResponse response, String jspView)
      throws Exception {
        //response.sendRedirect(response.encodeRedirectURL(jspView));
        request.getRequestDispatcher(jspView).forward(request, response);
      }

  protected void showDefaultView(HttpServletRequest request, HttpServletResponse response)
      throws Exception {
        showJspView(request, response, Constants.DEFAULT_JSP);
      }

  protected String getRealPath(ServletContext servletContext, String path) {
    if(path != null
        && !path.startsWith("../")
        && !path.startsWith("/")) {
      path = servletContext.getRealPath(path);
    }

    return path;
  }

  abstract protected void processRequest(HttpServletRequest request, HttpServletResponse response)
      throws javax.servlet.ServletException, java.io.IOException;

}
