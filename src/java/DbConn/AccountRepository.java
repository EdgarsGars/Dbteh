/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package DbConn;

import Entities.Employee;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Edgar
 */
public class AccountRepository {
   private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
   private static final String DB_URL = "jdbc:mysql://localhost:3306/mydb?user=root&password=parole";

   
   public static Employee login(String username,String password){
       Connection conn = null;
       Statement stmt;
       try{
              Class.forName(JDBC_DRIVER);
              conn = DriverManager.getConnection(DB_URL);
              Statement stms2 = conn.createStatement();
              stms2.execute("call accountLog('"+username+"','"+password+"');");
              stmt = conn.createStatement();
              ResultSet rs = stmt.executeQuery("select a.accountID,firstname,lastname,email from employee a JOIN account b on a.accountID = b.accountID where b.username='"+username+"' and b.password='"+password+"';");
              if(rs.next()){
                  int accountID = rs.getInt("accountID");
                  String firstname = rs.getString("firstname");
                  String lastname  = rs.getString("lastname");
                  String email     = rs.getString("email");
                  conn.close();
                  return new Employee(accountID, firstname, lastname, email);
                  
              }
              
           
       }catch(Exception ex){
           ex.printStackTrace();
       }finally{
           try{
           conn.close();  
           }catch(Exception ex){
               
           }
       }
          
       return null;
   }
    
   
   
    
    
    
    
    
}
