package com.thomsonreuters.listsales.utils;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.commons.lang.StringUtils;
import org.w3c.dom.Document;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;
import com.thomson.ts.framework.util.StringUtil;
import com.thomsonreuters.listsales.beans.db2.DB2_XML;

public class DatabaseUtil {
  static protected Logger logger=LogFactory.getLogger(DatabaseUtil.class);

  static String LIST_DB_DS_NAME  = "java:/comp/env/jdbc/listDB";
  static DataSource listDBDS = null;

  public static void initDataSource() {
    initDataSource(LIST_DB_DS_NAME);
  }

  public static void initDataSource(String jndiName) {
    if(listDBDS != null) {
      return;
    }

    try {
      Context initContext = new InitialContext();
      listDBDS = (DataSource)initContext.lookup(jndiName);
    } catch(Exception e) {
      logger.error("Error to initialize DS ("+LIST_DB_DS_NAME+") -- "+e);
      e.printStackTrace();
    }
  }


  public static Connection getConnection() throws DatabaseServiceException {
    try {
      initDataSource();

      return listDBDS.getConnection();
    } catch(Exception e) {
      throw new DatabaseServiceException(e);
    }
  }

  public static Document getData(String sql, Map params) throws DatabaseServiceException {
    Connection conn = (Connection) params.get("Connection");
    try {
      if(conn == null) {
        conn = getConnection();
      }
      DB2_XML db2 = new DB2_XML(conn);
      logger.debug("The db2 is " + db2);

      Document dcm = db2.getData(sql);
      if(logger.isDebugEnabled()) {
        logger.debug("SQL  is " + sql);
        logger.debug("The Document  is " + dcm);
      }

      return dcm;
    } catch(Exception e) {
      if(logger.isErrorEnabled()) {
        logger.error("Error to get data. sql is "+sql+" params are "+params, e);
      }

      throw new DatabaseServiceException(e);
    } finally {
      closeConnection(conn);
    }

  }

  public static Document setData(String sql, Map params) throws DatabaseServiceException {
    Connection conn = (Connection) params.get("Connection");
    try {
      if(conn == null) {
        conn = getConnection();
      }
      DB2_XML db2 = new DB2_XML(conn);

      logger.debug("The db2 is " + db2);

      Document dcm = db2.setData(sql);
      if(logger.isDebugEnabled()) {
        logger.debug("SQL  is " + sql);
        logger.debug("The Document  is " + dcm);
      }

      return dcm;
    } catch(Exception e) {
      if(logger.isErrorEnabled()) {
        logger.error("Error to set data. sql is "+sql+" params are "+params, e);
      }

      throw new DatabaseServiceException(e);
    } finally {
      closeConnection(conn);
    }

  }

  public static void closeConnection(Connection conn) {
    if(conn != null) {
      try {
        if(!conn.isClosed()) {
          conn.close();
        }
      } catch(SQLException e) {
        if(logger.isErrorEnabled()) {
          logger.error("Error to close jdbc connection.", e);
        }

      }
    }
  }

  public static String normalizeSqlDate(String sqlDateInfo) {
    if(StringUtil.isEmpty(sqlDateInfo)) {
      return sqlDateInfo;
    }

    String[] dateParts = StringUtils.split(sqlDateInfo, "-");

    return  StringUtils.leftPad(dateParts[0], 4, '0')
              +"-"
              +StringUtils.leftPad(dateParts[1], 2, '0')
              +"-"
              +StringUtils.leftPad(dateParts[2], 2, '0')
              ;
  }

}
