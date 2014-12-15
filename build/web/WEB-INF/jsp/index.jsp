<%@page import="DbConn.TaskRepository"%>
<%@page import="Entities.Task"%>
<%@page import="DbConn.ProjectRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entities.Project"%>
<%@page import="Entities.Employee"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link href="css/topMenu.css" rel="stylesheet">
        <link href="css/issueTable.css" rel="stylesheet">


        <title>Issue Tracker</title>
    </head>
    <body>

        <div id='topmenu'>
            <ul>
                <li class='active'><a href='/Dbteh/'><span>Projects</span></a></li>
                <li><a href='/Dbteh/projectCreation'><span>Add Project</span></a></li>
                <li class='last'><a href='/Dbteh/logout'><span>Logout</span></a></li>
            </ul>
        </div>
        <h1> Your tasks open in projects</h1>
        <%
            Employee e = (Employee) session.getAttribute("user");
            ArrayList<Project> projects = ProjectRepository.getEmployeeProjects(e.getAccountID());
            for (Project p : projects) {
                out.println("<table class=\"taskTable\"><tr><td colspan=\"6\"><a href=\"/Dbteh/project?projectID=" + p.projectID + "\">" + p.projectName + "</a></tr>");
                out.print("<tr ><td style=\"background-color:yellow;\">#</td><td style=\"background-color:yellow;\">Type</td> <td style=\"background-color:yellow;\">Status</td> <td style=\"background-color:yellow;\">Priority</td > <td style=\"background-color:yellow;\">Subject</td><td style=\"background-color:yellow;\">Date</td> </tr> ");

                for (Task t : TaskRepository.getTasksForEmployeeInProject(e, p)) {
                    if (!t.status.equals("Closed")) {
                        out.print("<tr onclick=\"window.location='/Dbteh/task?taskID=" + t.taskID + "'\"><td>" + t.taskID + "</td><td>" + t.type + "</td><td>" + t.status + "</td><td>" + t.priority + "</td><td>" + t.subject + "</td><td>" + t.startdDate + "</td></tr>");
                    } 
                }

                out.println("</table><br><br>");
            }

        %>

    </body>
</html>