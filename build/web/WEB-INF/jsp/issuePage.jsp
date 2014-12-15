<%-- 
    Document   : issuePage
    Created on : Dec 14, 2014, 9:26:51 AM
    Author     : Edgar
--%>

<%@page import="Entities.Comment"%>
<%@page import="Entities.Task"%>
<%@page import="Entities.Project"%>
<%@page import="DbConn.EmployeeRepository"%>
<%@page import="DbConn.ProjectRepository"%>
<%@page import="Entities.Employee"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DbConn.TaskRepository"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <%
        int accountID = ((Employee) session.getAttribute("user")).accountID;
        int taskID = 0;
        taskID = Integer.valueOf(request.getAttribute("taskID").toString());
        Task task = TaskRepository.getTaskByID(taskID);
        int projectID = ProjectRepository.getProjectByTask(taskID).projectID;
    %>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/topMenu.css" rel="stylesheet">
        <script language="javascript">
            function comboBoxSelectedText(combobox, what) {
                var x = document.getElementById(combobox);
                var i = x.selectedIndex;
                console.log(x.options[i].text);
                return x.options[i][what];
            }

            function saveChanges() {
                window.location = "/Dbteh/updateTask?taskID=<%=taskID%>&status=" + comboBoxSelectedText('statusSelect', 'text') +
                        "&priority=" + comboBoxSelectedText('priority', 'text') + "&accountID=" + comboBoxSelectedText('assignee', 'value') +
                        "&description=" + document.getElementById('description').value;

            }
        </script>
        <title>Issue #<%=taskID%></title> 
    </head>
    <body>

        <div id='topmenu'>
            <ul>
                <li><a href='/Dbteh/'><span>Home</span></a></li>
                <li class='active'><a href='#'><span>Projects</span></a></li>
                <li><a href='/Dbteh/projectCreation'><span>Add Project</span></a></li>
                <li class='last'><a href='/Dbteh/logout'><span>Logout</span></a></li>
            </ul>
        </div>

        <h2> <% out.print(task.type + " #" + task.taskID);%></h2 ><hr> 
        <div class ="issueBody">
            <div class ="options">
                <h3><%=task.subject%></h3>
                <table>
                    <tr><td class ="fieldName">Status:</td><td> <select id="statusSelect">
                                <%
                                    ArrayList<String> statuses = TaskRepository.getAllStatuses();
                                    for (int i = 0; i < statuses.size(); i++) {
                                        if (statuses.get(i).equals(task.status)) {
                                            out.print("<option selected value=\"" + (i + 1) + "\">" + statuses.get(i) + "</option >");
                                        } else {
                                            out.print("<option value=\"" + (i + 1) + "\">" + statuses.get(i) + "</option >");
                                        }
                                    }
                                %>

                            </select></td><td>Parent Task:</td><td><%=task.parentTask%></td></tr>
                    <tr><td class="fieldName">Priority:</td><td><select id="priority">

                                <%
                                    Map<String, Integer> priorities = TaskRepository.getAllPriorities();
                                    if (priorities != null) {
                                        for (String p : priorities.keySet()) {
                                            if (p.equals(task.priority)) {
                                                out.print("<option selected value=\"" + priorities.get(p) + "\">" + p + "</option >");
                                            } else {
                                                out.print("<option  value=\"" + priorities.get(p) + "\">" + p + "</option >");
                                            }
                                        }
                                    }
                                %>

                            </select></td><td>Start date:</td><td><%=task.startdDate%></tr>
                    <tr><td class="fieldname">Assignee: </td><td> <select id="assignee">
                                <%
                                    ArrayList<Employee> team = EmployeeRepository.getProjectEmployees(projectID);
                                    for (Employee e : team) {
                                        if (e.accountID == task.assigne.accountID) {
                                            out.print("<option selected value=\"" + e.getAccountID() + "\">" + e.getFirstname() + " " + e.getLastname() + "</option >");
                                        } else {
                                            out.print("<option value=\"" + e.getAccountID() + "\">" + e.getFirstname() + " " + e.getLastname() + "</option >");
                                        }
                                    }
                                %> 
                            </select></td><td>End Date:</td><td><%=task.endDate%></td></tr>
                </table>
                <hr>
                <h4>Description</h4>
                <textarea id="description" name="description" cols="75" rows="10"><%=task.description%></textarea><br>

                <input type="submit" value="Save Changes" onclick="saveChanges()"/>


            </div>
            <div class="commentBox">
                <div class="commnet">
                    <table>
                        <%
                            ArrayList<Comment> comments = TaskRepository.getTaskComments(taskID);
                            for (Comment c : comments) {
                                out.print("<tr><td>[" + c.time + "]</td><td>" + c.author.firstname + " " + c.author.lastname + "</td> <td>: " + c.text + "</td > </tr> ");
                            }
                        %>
                    </table>
                </div>
                <hr>
                <form action="/Dbteh/postComment?taskID=<%=taskID%>&accountID=<%=accountID%>" method="post">
                    <textarea name="commentInput" cols="75" rows="1"></textarea><input type="submit" value="Comment"/>
                </form>

            </div>



        </div>








    </body>
</html>
