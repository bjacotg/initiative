package database;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import server.User;

public final class Messenger {

    private static final Logger log = Logger.getLogger(Messenger.class.getName());
    
    private Connection conn;
    private static class Holder{
        public static final Messenger instance = new Messenger();
    }
    private Messenger() {
        try {
            Class.forName(DBProperties.DRIVER).newInstance();
            log.info("DBMS driver registered");
        } catch (InstantiationException ex) {
            log.log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            log.log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            log.log(Level.SEVERE, null, ex);
        }
        conn = connect();
    }
    public static Messenger getInstance(){        
        return Holder.instance;      
    }
    
    public boolean commit() {
        try {
            update("COMMIT");
            log.fine("Transaction commited");
            return true;
        } catch (SQLException ex) {
            log.log(Level.SEVERE, "Commit failed", ex);
            return false;
        }
    }

    boolean rollback() {
        try {
            update("ROLLBACK");
            log.fine("Transaction canceled");
            return true;
        } catch (SQLException ex) {
            log.log(Level.SEVERE, "Rollback failed", ex);
            return false;
        }
    }
    
    private void checkConnection() throws SQLException {
        if (conn == null) {
            throw new SQLException("No connection to database");
        }
    }

    public PreparedStatement prepare(String req) throws SQLException {
        checkConnection();
        return conn.prepareStatement(req);
    }

    public ResultSet query(String req) throws SQLException {
        checkConnection();
        ResultSet rs = conn.createStatement().executeQuery(req);
        return rs;
    }

    public ResultSet query(PreparedStatement stmt) throws SQLException {
        ResultSet rs = stmt.executeQuery();
        log.finer(stmt.toString());
        return rs;
    }

    public int update(String req) throws SQLException {
        checkConnection();
        Statement stmt = conn.createStatement();
        int res = stmt.executeUpdate(req);
        log.finer(req);
        return res;
    }

    public int update(PreparedStatement stmt) throws SQLException {
        int res = stmt.executeUpdate();
        log.finer(stmt.toString());
        return res;
    }

    private Connection connect() {
        try {
            // Connection to database
            //conn = datasource.getConnection(USER, PASSWORD);
            conn = DriverManager.getConnection(DBProperties.DB_NAME, DBProperties.ADMIN_LOGIN, DBProperties.ADMIN_PASSWORD);
            log.fine("Connection to database successful");
            return conn;
        } catch (SQLException e) {
            log.log(Level.SEVERE, "Connection to database failed", e);
            return null;
        }
    }

    void close() {
        try {
            if (conn != null) {
                conn.close();
            }
            log.fine("Connection closed");
        } catch (SQLException e) {
            log.log(Level.WARNING, "Connection closing failed", e);
        }
    }
}
