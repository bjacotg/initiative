/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package server;


import database.Messenger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author bastienjacot-guillarmod
 */
public class Initiative {
    private static final Logger log = Logger.getLogger(Initiative.class.getName());
    public final long id;
    public final String commitee;
    public final String salt;
    public final String name;
    private static Messenger msgr = Messenger.getInstance();
    
    
    public Initiative(long id) throws SQLException{
        this.id = id;        
        PreparedStatement stmt = msgr.prepare("SELECT ComiteeId, Salt, InitName FROM Initiative WHERE InitID = ?");
        stmt.setLong(1, id);
        ResultSet query = msgr.getInstance().query(stmt);
        if(query.next()){
            this.commitee = query.getString(1);
            this.salt = query.getString(2);
            this.name = query.getString(3);
            log.log(Level.FINE, "We found the good initiative.");
        }else{
            log.log(Level.WARNING, "We did not found the initiative.");
            throw new SQLException("Huho");
        }
    }
    
    public static boolean newInitiative(String comID, String name){
        try{
            PreparedStatement stmt = msgr.prepare("INSERT INTO Initiative (ComiteeID, InitName, Salt) VALUES (?, ?, ?)");
            stmt.setString(1, comID);
            stmt.setString(2, name);
            byte [] salt = new byte [16];
            new Random().nextBytes(salt);
            stmt.setString(3, new String(salt));
            msgr.update(stmt);
            msgr.commit();
            log.log(Level.FINE, "Initiative created.");    
            return true;
        }catch(SQLException e){
            log.log(Level.WARNING, "Could not create the initiative", e);
            return false;
        }                        
    }
    public static ResultSet getInitiative() throws SQLException{
        return msgr.query("SELECT Initiative.InitID, Initiative.InitName, Comitee.Id FROM Initiative INNER JOIN Comitee ON Initiative.ComiteeID = Comitee.Id");
    }
    public boolean hasVoted(User user){
        
        try { 
            MessageDigest md = null;
            try {
                md = MessageDigest.getInstance("SHA-256");
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
            }
            byte[] hash = md.digest((user.userid+salt).getBytes());
            PreparedStatement stmt = msgr.prepare("SELECT * FROM Vote WHERE Initiative=? AND HashId=?");
            stmt.setLong(1, id);
            stmt.setString(2, new String(hash));
            ResultSet result = msgr.query(stmt);
            return result.next();
        } catch (SQLException ex) {
            Logger.getLogger(Initiative.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public ResultSet getVote(){
        try {
            PreparedStatement stmt = msgr.prepare("SELECT HashId FROM Vote WHERE Initiative=?");
            stmt.setLong(1, id);
            return msgr.query(stmt);
        } catch (SQLException ex) {
            Logger.getLogger(Initiative.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
        
    }
}
