<%-- 
    Document   : projectPage
    Created on : Dec 13, 2014, 11:26:33 PM
    Author     : Edgar
--%>

<%@page import="DbConn.TaskRepository"%>
<%@page import="org.springframework.core.task.TaskRejectedException"%>
<%@page import="Entities.Task"%>
<%@page import="DbConn.EmployeeRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entities.Project"%>
<%@page import="Entities.Employee"%>
<%@page import="DbConn.ProjectRepository"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/topMenu.css" rel="stylesheet">
        <link href="css/issueTable.css" rel="stylesheet">
        <link href="css/teamMenu.css" rel="stylesheet">
        <%
            Employee me = (Employee) session.getAttribute("user");

            int projectID = Integer.valueOf(request.getAttribute("projectID").toString());
            Project p = ProjectRepository.getProjectByID(projectID, me);

            ArrayList<Employee> team = EmployeeRepository.getProjectEmployees(projectID);
            ArrayList<Task> tasks = TaskRepository.getProjectTasks(projectID);


        %>
        <title><%= p.projectName%></title>
    </head>
    <body>
        <div id='topmenu'>
            <ul>
                <li><a href='/Dbteh/'><span>Home</span></a></li>
                <li  class='active'><a href='/Dbteh/projects'><span>Projects</span></a></li>
                <li class='last'><a href='/Dbteh/logout'><span>Logout</span></a></li>
            </ul>
        </div>


        <h2> Projects > <%= p.projectName%> </h2>
        <%

            out.print("<table class=\"taskTable\"><tr ><td style=\"background-color:yellow;\">#</td><td style=\"background-color:yellow;\">Type</td> <td style=\"background-color:yellow;\">Status</td> <td style=\"background-color:yellow;\">Priority</td > <td style=\"background-color:yellow;\">Subject</td><td style=\"background-color:yellow;\">Date</td> </tr> ");

            for (Task t : TaskRepository.getProjectTasks(projectID)) {
                if (t.status.equals("Closed")) {
                    out.print("<tr class=\"strikeout\" onclick=\"window.location='/Dbteh/task?taskID=" + t.taskID + "'\"><td><s>" + t.taskID + "</s></td><td><del>" + t.type + "</del></td><td>" + t.status + "</td><td>" + t.priority + "</td><td>" + t.subject + "</td><td>" + t.startdDate + "</td></tr>");
                } else {
                    out.print("<tr onclick=\"window.location='/Dbteh/task?taskID=" + t.taskID + "'\"><td>" + t.taskID + "</td><td>" + t.type + "</td><td>" + t.status + "</td><td>" + t.priority + "</td><td>" + t.subject + "</td><td>" + t.startdDate + "</td></tr>");

                }
            }

            out.println("</table><br><br>");

        %>



        <table class="memberList">
            <tr><td colspan="2">Team</td></tr>
            <%                for (Employee e : team) {
                    out.print("<tr><td>" + e.getFirstname() + " " + e.getLastname() + "</td><td>ROLE</td></tr>");
                }

            %>
            <tr><td style="text-align: center" colspan="2"><form action="/Dbteh/employees?projectID=<%=projectID%>" method="post"><input type="submit" value="Add team member"></form></td></tr>
        </table>
        <form action="/Dbteh/newTask?projectID=<%=projectID%>" method="post">
            <input type="submit"    value="Add new Task">

        </form>






    </body>
</html>
