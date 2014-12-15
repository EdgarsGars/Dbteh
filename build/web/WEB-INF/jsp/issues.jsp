<%-- 
    Document   : issues
    Created on : Dec 13, 2014, 1:44:06 PM
    Author     : Edgar
--%>


<%@page import="java.util.ArrayList"%>
<%@page import="Entities.Task"%>
<%@page import="Entities.Employee"%>
<%@page import="DbConn.TaskRepository"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link href="css/issueTable.css" rel="stylesheet">
        <link href="css/topMenu.css" rel="stylesheet">
        <title>Issues</title>
    </head>
    <div id='topmenu'>
            <ul>
                <li class='active'><a href='/Dbteh/'><span>Projects</span></a></li>
                <li><a href='/Dbteh/projectCreation'><span>Add Project</span></a></li>
                <li class='last'><a href='/Dbteh/logout'><span>Logout</span></a></li>
            </ul>
        </div>

        <div class="issueBox">
            <div class="filterBox">
                Assignee
                <select >
                    <% out.print("<option value=\"accountID\"><< ME >></option> <option value=\"audi\">Audi</option>");
                    
                    
                    
                    %>
                </select>
            </div>
            <table class="taskTable">
                <tr>
                    <td>#</td>
                    <td>Type</td>
                    <td>Status</td>
                    <td>Priority</td>
                    <td>Subject</td>
                    <td>Assignee</td>
                    <td>Date</td>   
                </tr>
                    <%
                        out.println(" ->  "+(Employee)session.getAttribute("user"));
                        ArrayList<Task> tasks = TaskRepository.getTasksForEmployee((Employee)session.getAttribute("user"));
                        if(tasks!=null){
                            for(Task t : tasks){
                                out.print("<tr><td>"+t.taskID+"</td><td>"+t.type+"</td><td>"+t.status+"</td><td>"+t.priority+"</td><td>"+t.subject+"</td><td>"+t.assigne.getFirstname()+" "+t.assigne.getLastname()+"</td><td>"+t.startdDate+"</td></tr>");
                            }
                        }else{
                            out.println("<p> No records Found </p>");
                        }
                    %>
                    
                </tr>
            </table>
        </div>

    </body>
</html>
