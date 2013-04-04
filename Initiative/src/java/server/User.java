package server;

import database.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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

    public static void newUser(String usr, String pass){
        try {
            PreparedStatement stmt = Messenger.getInstance().prepare("INSERT INTO Voter (Id, Password, Salt) VALUES (?, ?, ?);");
            stmt.setString(1, usr);
            stmt.setString(2, pass);
            stmt.setString(3, "Chris");
            Messenger.getInstance().update(stmt);
            Messenger.getInstance().commit();
                    
        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
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
            MessageDigest md = null;
            try {
                md = MessageDigest.getInstance("SHA-256");
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            }
            byte[] hash = md.digest((userid+init.salt).getBytes());
            PreparedStatement stmt = messenger.prepare("INSERT INTO Vote VALUES (?,?)");
            stmt.setLong(1, init.id);
            stmt.setString(2, new String(hash));
            messenger.update(stmt);
            messenger.commit();
            log.log(Level.INFO, "Voted!");
            return true;
        }catch(SQLException e){
            
            return false;
        }
        
    }

}
