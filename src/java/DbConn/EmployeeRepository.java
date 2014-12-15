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
import java.util.ArrayList;

/**
 *
 * @author Edgar
 */
public class EmployeeRepository {
    
    
   private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
   private static final String DB_URL = "jdbc:mysql://localhost:3306/mydb?user=root&password=parole";
    
    
    public static Employee getEmployeeByID(int accountID){
       Connection conn = null;
       Statement stmt;
       try{
              Class.forName(JDBC_DRIVER);
              conn = DriverManager.getConnection(DB_URL);
              
              stmt = conn.createStatement();
              ResultSet rs = stmt.executeQuery("select firstname,lastname,email from employee where accountID = "+accountID+"");
              if(rs.next()){
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
    
    
   public static ArrayList<Employee> getProjectEmployees(int projectID){
       ArrayList<Employee> list = new ArrayList<Employee>();
       Connection conn = null;
       Statement stmt;
       try{
              Class.forName(JDBC_DRIVER);
              conn = DriverManager.getConnection(DB_URL);
              
              stmt = conn.createStatement();
              ResultSet rs = stmt.executeQuery("select accountID,firstname,lastname,email,role from employeeinproject where projectID  = "+projectID);
              while(rs.next()){
                  
                  Employee e = new Employee();
                  e.accountID = rs.getInt("accountID");
                  e.firstname = rs.getString("firstname");
                  e.lastname  = rs.getString("lastname");
                  e.email     = rs.getString("email");
                  e.role      = rs.getString("role");
                  
                  list.add(e);
                  
              }
             
       }catch(Exception ex){
           ex.printStackTrace();
       }finally{
           try{
           conn.close();  
           }catch(Exception ex){
               
           }
       }
          
       return list;       
   } 
    
    
    public static ArrayList<Employee> getAllEmployees(){
       ArrayList<Employee> list = new ArrayList<Employee>();
       Connection conn = null;
       Statement stmt;
       try{
              Class.forName(JDBC_DRIVER);
              conn = DriverManager.getConnection(DB_URL);
              
              stmt = conn.createStatement();
              ResultSet rs = stmt.executeQuery("select ep.accountID,ep.firstname,ep.lastname,sum((select count(*) from task t where ep.accountID = t.assignee and t.projectID=ep.projectID and t.status=8)) as completedTasks,sum((select count(*) from task t where ep.accountID = t.assignee and t.projectID=ep.projectID)) as totalTasks , sum((select count(*) from task t where ep.accountID = t.assignee and t.projectID=ep.projectID and t.status=8))/sum((select count(*) from task t where ep.accountID = t.assignee and t.projectID=ep.projectID))*100 as completionRate from employeeinproject ep group by ep.accountID");
              while(rs.next()){
                  Employee e = new Employee();
                  e.accountID=rs.getInt("accountID");
                  e.firstname=rs.getString("firstname");
                  e.lastname= rs.getString("lastname");
                  e.completedTasks=rs.getInt("completedTasks");
                  e.totalTasks=rs.getInt("totalTasks");
                  e.completionRate=rs.getDouble("completionRate");
                  list.add(e);
                  
              }
             
       }catch(Exception ex){
           ex.printStackTrace();
       }finally{
           try{
           conn.close();  
           }catch(Exception ex){
               
           }
       }
          
       return list;       
   } 
   
   
}
