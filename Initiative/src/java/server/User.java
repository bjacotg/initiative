package server;

import database.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class User {

    public static final String CREDENTIAL_ADMIN = "Admin";
    private static final Logger log = Logger.getLogger(User.class.getName());
    private static final String ADMIN_PASSWORD = "ece356";
    private static final String ADMIN_ID = "admin";
    private static User superuser = null;
    public final String userid;
    public final String password;
//    private Creator creator;
//    private Updater updater;
//    private Reader reader;
    private Messenger messenger;

    
    private User(String userid, String password) {
        this.userid = userid;
        this.password = password;
        this.messenger = Messenger.getInstance();

    }




    public String getLogin() {
        return userid;
    }

    public int getId() {
        return Integer.parseInt(userid);
    }

    public String getPassword() {
        return password;
    }


/*    public Creator getCreator() {
        if (creator == null) {
            creator = new Creator(this);
        }
        return creator;
    }

    public Updater getUpdater() {
        if (updater == null) {
            updater = new Updater(this);
        }
        return updater;
    }

    public Reader getReader() {
        if (reader == null) {
            reader = new Reader(this);
        }
        return reader;
    }
*/
    public static User login(String userid, String password) {

        Messenger msgr = Messenger.getInstance();
        try {
            PreparedStatement stmt;            
            stmt = msgr.prepare("SELECT Password FROM Voter WHERE ID=?");
         
            stmt.setString(1, userid);
            ResultSet rs = msgr.query(stmt);
            if (!rs.next()) {
                log.log(Level.WARNING,
                        "Login failed for user {0}: unknown voter",
                        new Object[]{userid});
            } else if (password.equals(rs.getString(1))) {
                log.log(Level.INFO, "Login successful for user {0}",
                        new Object[]{userid});
                return new User(userid, password);
            }
            log.log(Level.WARNING,
                    "Login failed for user {0} : password did not match",
                    new Object[]{userid});
        } catch (SQLException ex) {
            log.log(Level.SEVERE, "Password unchecked due to database error", ex);
        }
        return null;
    }
    public boolean sign(Initiative init){
        try{
            PreparedStatement stmt = messenger.prepare("INSERT INTO Vote VALUES (?,?)");
            stmt.setLong(1, init.id);
            stmt.setString(2, userid);
            messenger.query(stmt);
            messenger.commit();
            log.log(Level.FINE, "Voted!");
            return true;
        }catch(SQLException e){
            return false;
        }
        
    }

}
