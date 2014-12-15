/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DbConn;

import Entities.Employee;
import Entities.Project;
import Entities.Task;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Edgar
 */
public class ProjectRepository {

    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydb?user=newuser&password=abcd123";

    public static ArrayList<Project> getEmployeeProjects(int employeeID) {
        //select e.accountID,e.firstname,e.lastname,e.email from project_roles pr join employee e on pr.accountID = e.accountID where projectID = 2;
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select p.projectID,p.name,p.description from project p join project_roles pr on p.projectID = pr.projectID join employee e on e.accountID = pr.accountID where e.accountID =" + employeeID);
            ArrayList<Project> projects = new ArrayList<>();
            while (rs.next()) {
                Project p = new Project();
                p.projectID = rs.getInt("projectID");
                p.projectName = rs.getString("name");
                p.description = rs.getString("description");
                projects.add(p);
            }
            conn.close();
            return projects;

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (Exception ex) {

            }
        }

        return null;

    }

    public static boolean createProject(String name, String description, Employee e) {
        //select e.accountID,e.firstname,e.lastname,e.email from project_roles pr join employee e on pr.accountID = e.accountID where projectID = 2;
        Connection conn = null;
        Statement stmt, stmt2;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            conn.setAutoCommit(false);
            stmt.execute("insert into project(name,description) values('" + name + "','" + description + "');");
            stmt2 = conn.createStatement();
            stmt2.execute("insert into project_roles(projectID,accountID,roleID) values((select projectID from project where name='" + name + "' and description='" + description + "')," + e.getAccountID() + ",1)");

            conn.commit();
            conn.close();
            return true;

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                conn.rollback();
                conn.close();
            } catch (Exception ex) {

            }
        }

        return false;

    }

    public static Project getProjectByID(int id, Employee e) {
        //select e.accountID,e.firstname,e.lastname,e.email from project_roles pr join employee e on pr.accountID = e.accountID where projectID = 2;
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select p.projectID,p.name,p.description from project p where p.projectID = " + id + " and (select count(*) from project_roles pr where p.projectID = pr.projectID and pr.accountID = " + e.getAccountID() + ") > 0");
            Project p = null;
            if (rs.next()) {
                p = new Project();
                p.projectID = rs.getInt("projectID");
                p.projectName = rs.getString("name");
                p.description = rs.getString("description");
            }
            conn.close();
            return p;

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (Exception ex) {

            }
        }

        return null;

    }

    public static Project getProjectByTask(int taskID) {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select p.projectID,name,p.description from task t join project p on t.projectID=p.projectID where taskID = " + taskID);
            Project p = null;
            if (rs.next()) {
                p = new Project();
                p.projectID = rs.getInt("projectID");
                p.projectName = rs.getString("name");
                p.description = rs.getString("description");
            }
            conn.close();
            return p;

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (Exception ex) {

            }
        }

        return null;
    }

    public static ArrayList<String> getAllRoles() {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select role from roles;");
            ArrayList<String> roles = new ArrayList<>();
            while (rs.next()) {
                roles.add(rs.getString("role"));
            }
            conn.close();
            return roles;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (Exception ex) {

            }
        }

        return null;

    }

    public static boolean addMember(int accountID, int projectID, String role) {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            stmt.execute("INSERT INTO project_roles (projectID, accountID, roleID) VALUES("+projectID+","+accountID+", (select roleID from roles where role = '"+role+"')) ON DUPLICATE KEY UPDATE roleID = (select roleID from roles where role='"+role+"')");
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (Exception ex) {

            }
        }

        return false;
    }

}
