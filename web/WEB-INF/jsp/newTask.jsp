<%-- 
    Document   : newTask
    Created on : Dec 15, 2014, 2:23:50 AM
    Author     : Edgar
--%>

<%@page import="DbConn.ProjectRepository"%>
<%@page import="Entities.Project"%>
<%@page import="Entities.Comment"%>
<%@page import="DbConn.EmployeeRepository"%>
<%@page import="java.util.Map"%>
<%@page import="DbConn.TaskRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entities.Employee"%>
<%@page import="Entities.Task"%>
<%@page import="Entities.Task"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        int accountID = ((Employee) session.getAttribute("user")).accountID;
        int projectID = Integer.valueOf(request.getAttribute("projectID").toString());
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

            function createTask() {
                console.log("Create task");
                window.location = "/Dbteh/createTask?projectID=<%=projectID%>&status=" + comboBoxSelectedText('statusSelect', 'text') +
                        "&priority=" + comboBoxSelectedText('priority', 'text') + "&accountID=" + comboBoxSelectedText('assignee', 'value') +
                        "&description=" + document.getElementById('description').value + "&parentID=" + comboBoxSelectedText('parentTask', 'text').replace('#', '') +
                        "&type=" + comboBoxSelectedText('typeSelect', 'text') + "&subject=" + document.getElementById('subject').value;

            }
        </script>

        <title>New task</title> 
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


        <div class ="issueBody">
            <div class ="options">
                <h3>New task  </h3>
                <hr>
                <table>
                    <tr><td>Subject</td><td><input id="subject" name = "subject" type="text"></td></tr>
                    <tr><td class ="fieldName">Status:</td><td> <select id="statusSelect">
                                <%
                                    ArrayList<String> statuses = TaskRepository.getAllStatuses();
                                    for (int i = 0; i < statuses.size(); i++) {
                                        out.print("<option >" + statuses.get(i) + "</option>");

                                    }
                                %>  
                            </select></td><td>Parent Task:</td><td>
                            <select id="parentTask">
                                <%
                                    ArrayList<Task> tasks = TaskRepository.getProjectTasks(projectID);
                                        out.print("<option>null</option>");
                                        for (Task t : tasks) {
                                            out.print("<option>#" + t.taskID + "</option>");
                                        }
                                    
                                %>


                            </select>
                        </td></tr>
                    <tr><td class="fieldName">Priority:</td><td><select id="priority">
                                <%
                                    Map<String, Integer> priorities = TaskRepository.getAllPriorities();
                                    if (priorities != null) {
                                        for (String p : priorities.keySet()) {
                                            out.print("<option  value=\"" + priorities.get(p) + "\">" + p + "</option >");
                                        }
                                    }
                                %>

                            </select></td></tr>
                    <tr><td class="fieldName">Type:</td><td><select id="typeSelect">
                                <%
                                    ArrayList<String> types = TaskRepository.getAllType();
                                    for (String p : types) {
                                        out.print("<option>" + p + "</option >");
                                    }

                                %>

                            </select></td><td></tr>
                    <tr><td class="fieldname">Assignee: </td><td> <select id="assignee">
                                <%                                    ArrayList<Employee> team = EmployeeRepository.getProjectEmployees(projectID);
                                    for (Employee e : team) {
                                        out.print("<option value=\"" + e.getAccountID() + "\">" + e.getFirstname() + " " + e.getLastname() + "</option >");

                                    }
                                %> 
                </table>
                <hr>
                <h4>Description</h4>
                <textarea id="description" name="description" cols="75" rows="10"></textarea><br>

                <input type="submit" value="Create" onclick="createTask();"/>


            </div>




        </div>



    </body>
</html>
