<%-- 
    Document   : addMemberToProject
    Created on : Dec 15, 2014, 10:39:27 AM
    Author     : Edgar
--%>

<%@page import="DbConn.ProjectRepository"%>
<%@page import="DbConn.EmployeeRepository"%>
<%@page import="DbConn.TaskRepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entities.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="css/issueTable.css" rel="stylesheet">
        <link href="css/topMenu.css" rel="stylesheet">
        <title>Add member to team</title>
    </head>
    <script language="javascript">
        function submit(accountID, projectID) {
            role = document.getElementById('role').options[document.getElementById('role').selectedIndex].text;
            window.location = "/Dbteh/addMember?memberID=" + accountID + "&projectID=" + projectID + "&role=" + role;

        }
    </script>

    <body>
        <div id='topmenu'>
            <ul>
                <li><a href='/Dbteh/'><span>Home</span></a></li>
                <li><a class='active' href='/Dbteh/projects'><span>Projects</span></a></li>
                <li class='last'><a href='/Dbteh/logout'><span>Logout</span></a></li>
            </ul>
        </div>
        Choose role 
        <select id='role'>
            <% ArrayList<String> roles = ProjectRepository.getAllRoles();
                for (String s : roles) {
                    out.print("<option>" + s + "</option>");

                }
            %>


        </select> for employee


        <% int projectID = Integer.valueOf(request.getAttribute("projectID").toString()); %>

        <table class="taskTable">
            <tr><td>Employee</td> <td>Completed Tasks</td> <td>Total Tasks</td><td>Completion</td></tr>
            <%
                ArrayList<Employee> employees = EmployeeRepository.getAllEmployees();

                for (Employee e : employees) {
                    out.print("<tr onclick='submit("+e.accountID+","+projectID+")'><td>" + e.firstname + " " + e.lastname + "</td><td>" + e.completedTasks + "</td> <td>" + e.totalTasks + "</td><td>" + e.completionRate + "</td></tr> ");

                }

            %>
        </table>





    </body>
</html>
