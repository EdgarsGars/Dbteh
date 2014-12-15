/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DbConn;

import Entities.Comment;
import Entities.Employee;
import Entities.Project;
import Entities.Task;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Edgar
 */
public class TaskRepository {

    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydb?user=newuser&password=abcd123";

    public static ArrayList<Task> getTasksForEmployee(Employee e) {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select taskID, subject,s.statusName,tp.typeName,p.priorityName,t.startDate from task t join status s on t.status = statusID join type tp on t.type = tp.typeID join priority p on t.priority = p.priorityID where assignee =" + e.getAccountID());
            ArrayList<Task> tasks = new ArrayList<>();
            while (rs.next()) {
                Task t = new Task();
                t.taskID = rs.getInt("taskID");
                t.subject = rs.getString("subject");
                t.status = rs.getString("statusName");
                t.startdDate = rs.getString("startDate");
                t.type = rs.getString("typeName");
                t.priority = rs.getString("priorityName");
                t.assigne = e;
                tasks.add(t);
            }
            conn.close();
            return tasks;
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

    public static ArrayList<Task> getTasksForEmployeeInProject(Employee e, Project p) {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select taskID, subject,s.statusName,tp.typeName,p.priorityName,t.startDate from task t join status s on t.status = statusID join type tp on t.type = tp.typeID join priority p on t.priority = p.priorityID where assignee =" + e.getAccountID() + " and projectID=" + p.projectID);
            ArrayList<Task> tasks = new ArrayList<>();
            while (rs.next()) {
                Task t = new Task();
                t.taskID = rs.getInt("taskID");
                t.subject = rs.getString("subject");
                t.status = rs.getString("statusName");
                t.startdDate = rs.getString("startDate");
                t.type = rs.getString("typeName");
                t.priority = rs.getString("priorityName");
                t.assigne = e;
                tasks.add(t);
            }
            conn.close();
            return tasks;
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

    public static ArrayList<Task> getProjectTasks(int projectID) {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select taskID, subject,s.statusName,tp.typeName,p.priorityName,t.startDate from task t join status s on t.status = statusID join type tp on t.type = tp.typeID join priority p on t.priority = p.priorityID where t.projectID =" + projectID);
            ArrayList<Task> tasks = new ArrayList<>();
            while (rs.next()) {
                Task t = new Task();
                t.taskID = rs.getInt("taskID");
                t.subject = rs.getString("subject");
                t.status = rs.getString("statusName");
                t.startdDate = rs.getString("startDate");
                t.type = rs.getString("typeName");
                t.priority = rs.getString("priorityName");
                //t.assigne = e;
                tasks.add(t);
            }
            conn.close();
            return tasks;
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

    public static ArrayList<String> getAllStatuses() {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select statusName from status;");
            ArrayList<String> statuses = new ArrayList<>();
            while (rs.next()) {
                statuses.add(rs.getString("statusName"));
            }
            conn.close();
            return statuses;
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

    public static Map<String, Integer> getAllPriorities() {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from priority");
            Map<String, Integer> priorities = new HashMap<String, Integer>();
            while (rs.next()) {
                priorities.put(rs.getString("priorityName"), rs.getInt("priorityID"));
            }
            conn.close();
            return priorities;
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
            ResultSet rs = stmt.executeQuery("SELECT * FROM project p where projectID = (select t.projectID from task t where t.taskID = " + taskID + ");");
            Project p = new Project();
            if (rs.next()) {
                p.projectID = rs.getInt("projectID");
                p.description = rs.getString("description");
                p.projectName = rs.getString("name");
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

    public static Task getTaskByID(int taskID) {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select taskID, assignee,subject,description,s.statusName,tp.typeName,p.priorityName,t.startDate from task t join status s on t.status = statusID join type tp on t.type = tp.typeID join priority p on t.priority = p.priorityID where t.taskID =" + taskID + ";");
            Task t = new Task();
            if (rs.next()) {
                t.taskID = rs.getInt("taskID");
                t.subject = rs.getString("subject");
                t.status = rs.getString("statusName");
                t.startdDate = rs.getString("startDate");
                t.type = rs.getString("typeName");
                t.priority = rs.getString("priorityName");
                t.description = rs.getString("description");
                t.assigne = new Employee();
                t.assigne.accountID = rs.getInt("assignee");
            }
            conn.close();
            return t;
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

    public static ArrayList<Comment> getTaskComments(int taskID) {
        ArrayList<Comment> comments = new ArrayList<>();
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select e.accountID,e.firstname,e.lastname,c.text,c.date from comment c join employee e on e.accountID = c.accountID where c.taskID=" + taskID + " order by c.date");

            while (rs.next()) {
                Comment c = new Comment();
                c.author = new Employee();
                c.author.accountID = rs.getInt("accountID");
                c.author.firstname = rs.getString("firstname");
                c.author.lastname = rs.getString("lastname");
                c.text = rs.getString("text");
                c.time = rs.getString("date");
                comments.add(c);
            }
            conn.close();
            return comments;
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

    public static boolean addComment(int taskID, int employeeID, String text) {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            stmt.execute("insert into comment(accountID,taskID,text,date) values(" + employeeID + "," + taskID + ",'" + text + "',Now())");
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

    public static boolean updateTask(int taskID, int accountID, String status, String priority, String description) {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            System.out.println(description);
            stmt.execute("update task set status=(select statusID from status where statusName = '" + status + "'),assignee = " + accountID + ",priority = (select priorityID from priority where priorityName ='" + priority + "'),description='" + description + "' where taskID=" + taskID);
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

    public static ArrayList<String> getAllType() {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select typeName from type;");
            ArrayList<String> statuses = new ArrayList<>();
            while (rs.next()) {
                statuses.add(rs.getString("typeName"));
            }
            conn.close();
            return statuses;
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

    public static boolean insertTask(int projectID, String status, String priority, String type, int accountID, String description, String parent, String subject, int creatorID) {
        Connection conn = null;
        Statement stmt;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL);

            stmt = conn.createStatement();
            System.out.println(description);
            stmt.execute("insert into task(projectID,parentTask,status,type,assignee,creator,priority,subject,description,startDate) values ("+projectID+","+parent+",(select statusID from status where statusName='"+status+"'),(select typeID from type where typeName='"+type+"'),"+accountID+","+creatorID+",(select priorityID from priority where priorityName='"+priority+"'),'"+subject+"','"+description+"',Now());");
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
