/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package server;


import database.Messenger;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    public Initiative(long id) throws SQLException{
        this.id = id;        
        PreparedStatement stmt = Messenger.getInstance().prepare("SELECT ComiteeId FROM Initiative WHERE InitID = ?");
        stmt.setLong(1, id);
        ResultSet query = Messenger.getInstance().query(stmt);
        if(query.next()){
            this.commitee = query.getString(1);
            log.log(Level.FINE, "We found the good initiative.");
        }else{
            log.log(Level.WARNING, "We did not found the initiative.");
            throw new SQLException("Huho");
        }
    }
    
    public static boolean newInitiative(long comID){
        try{
            PreparedStatement stmt = Messenger.getInstance().prepare("INSERT INTO Initiative (ComiteeID) VALUES (?)");
            stmt.setLong(1, comID);
            ResultSet query = Messenger.getInstance().query(stmt);
            Messenger.getInstance().commit();
            log.log(Level.FINE, "Initiative created.");    
            return true;
        }catch(SQLException e){
            log.log(Level.WARNING, "Could not create the initiative");
            return false;
        }                        
    }
    public static ResultSet getInitiative() throws SQLException{
        return Messenger.getInstance().query("SELECT Initiative.InitID, Initiative.InitName, Comitee.Id FROM Initiative INNER JOIN Comitee ON Initiative.ComiteeID = Comitee.Id");
    }
}
