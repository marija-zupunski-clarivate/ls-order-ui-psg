package com.thomsonreuters.listsales.pool;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Vector;

import com.thomson.ts.framework.log.LogFactory;
import com.thomson.ts.framework.log.Logger;

/**
 * @deprecated replaced with standard DBCP
 * 
 *
 */
public class ConnectionPool implements Runnable {
  static protected Logger logger=LogFactory.getLogger(ConnectionPool.class);

    private String driver, url, username, password;
    private int maxConnections;
    private boolean waitIfBusy;
    private Vector availableConnections, busyConnections;
    private boolean connectionPending = false;

    public ConnectionPool(String driver, String url, String username, String password, 
            int initialConnections, int maxConnections, boolean waitIfBusy) throws SQLException {
       this.driver = driver;
       this.url = url;
       this.username = username;
       this.password = password;
       this.maxConnections = maxConnections;
       this.waitIfBusy = waitIfBusy;

       if (initialConnections > maxConnections)
           initialConnections = maxConnections;

       availableConnections = new Vector();
       busyConnections = new Vector();

       for (int i = 0; i < initialConnections; i++) 
           availableConnections.addElement(makeNewConnection());        
    }

    public synchronized Connection getConnection() throws SQLException {
        if (!availableConnections.isEmpty()) {
            Connection existingConnection = (Connection)availableConnections.lastElement();
            int  lastIndex = availableConnections.size() - 1;
            availableConnections.removeElementAt(lastIndex);

            if (existingConnection.isClosed()) {
                notifyAll(); //wake up threads that were waitng for a connection because maxConnections limit was reached.
                return(getConnection());
            }
            else {
                busyConnections.addElement(existingConnection);
                return existingConnection;
            }
        }
        //no available connections
        else {
            //if you haven't reached the max limit, and there isn't already one pending, establish one in the background
            if ((totalConnections() < maxConnections) && !connectionPending) 
                makeBackGroundConnection();

            //if reached limit, and the flag is false, throw an exception
            else if (!waitIfBusy) 
                throw new SQLException("Connection limit reached");

            //wait for either a new connection(if you called makeBackgroundConnection) or for an existing connection to be freed up
            try {
                wait();
            } catch(InterruptedException e) {}
            //Someone freed up a connection, so try again
            return (getConnection());
        }
    }

    //You can't just make a new connection in the foreground when onoe are available, since this can take several seconds with a slow network connection. Instead, start a thread that establishes a new connection, then wait. You get woken up either when the new connection is established or if someone finishes with an existing connection
    private void makeBackGroundConnection() {
        connectionPending = true;
        try {
            Thread connectionThread = new Thread(this);
            connectionThread.start();
        } catch (OutOfMemoryError e) {}
    }

    public void run() {
        try {
            Connection connection = makeNewConnection();
            synchronized (this) {
                availableConnections.addElement(connection);
                connectionPending = false;
                notifyAll();
            }
        } catch (Exception e) {} //SQLException or OutOfMemory
    }

    private Connection makeNewConnection() throws SQLException {
        try {
            Class.forName(driver); //load db com.thomsonreuters.listsales.servlet if not already loaded
            Connection connection = DriverManager.getConnection(url, username, password);
            logger.debug("Connect to db2");
            return (connection);
        } catch (ClassNotFoundException e) {
          //System.logger.debug(e);
            throw new SQLException("Can't find class for com.thomsonreuters.listsales.servlet: " + driver);
        }
    }

    public synchronized void free(Connection connection) {
        busyConnections.removeElement(connection);
        availableConnections.addElement(connection);
        //wake up threads that are waiting for connection
        notifyAll();
    }

    public synchronized int totalConnections() {
        return (availableConnections.size() + busyConnections.size());
    }

    public synchronized void closeAllConnections() {
        closeConnections(availableConnections);
        availableConnections = new Vector();
        closeConnections(busyConnections);
        busyConnections = new Vector();
    }

    private void closeConnections(Vector connections) {
        try {
            for (int i = 0; i < connections.size(); i++) {
                Connection connection = (Connection) connections.elementAt(i);
                if (!connection.isClosed()) {
                  connection.close();
                  logger.debug("Disconnect to db2");
                }
            }
        }catch (SQLException e) {}
    }

    public synchronized String toString() {
        String info = "ConnectionPool(" + url + "," + username + ")" + ", available=" +
            availableConnections.size() + ", busy=" + busyConnections.size() +
            ", max=" + maxConnections;
        return info;
    }
}
