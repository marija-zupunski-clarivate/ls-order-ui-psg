package com.thomsonreuters.listsales.utils;

import com.thomson.ts.framework.exception.BaseException;

public class DatabaseServiceException extends BaseException {

  public DatabaseServiceException() {
    super();
    // TODO Auto-generated constructor stub
  }

  public DatabaseServiceException(String msgKey, Object[] args) {
    super(msgKey, args);
    // TODO Auto-generated constructor stub
  }

  public DatabaseServiceException(String msgKey, String description, Object[] args) {
    super(msgKey, description, args);
    // TODO Auto-generated constructor stub
  }

  public DatabaseServiceException(String msgKey, String description,
      String[] subkeys, Object[] args) {
    super(msgKey, description, subkeys, args);
    // TODO Auto-generated constructor stub
  }

  public DatabaseServiceException(String msgKey, String description,
      String[] subkeys) {
    super(msgKey, description, subkeys);
    // TODO Auto-generated constructor stub
  }

  public DatabaseServiceException(String msgKey, String description) {
    super(msgKey, description);
    // TODO Auto-generated constructor stub
  }

  public DatabaseServiceException(String msgKey, String[] subkeys) {
    super(msgKey, subkeys);
    // TODO Auto-generated constructor stub
  }

  public DatabaseServiceException(String msgKey, Throwable cause) {
    super(msgKey, cause);
    // TODO Auto-generated constructor stub
  }

  public DatabaseServiceException(String msgKey) {
    super(msgKey);
    // TODO Auto-generated constructor stub
  }

  public DatabaseServiceException(Throwable cause) {
    super(cause);
    // TODO Auto-generated constructor stub
  }

}
