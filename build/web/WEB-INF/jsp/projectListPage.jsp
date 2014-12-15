<%-- 
    Document   : projectListPage
    Created on : Dec 13, 2014, 11:28:37 PM
    Author     : Edgar
--%>

<%@page import="Entities.Task"%>
<%@page import="DbConn.TaskRepository"%>
<%@page import="Entities.Employee"%>
<%@page import="DbConn.ProjectRepository"%>
<%@page import="Entities.Project"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link href="css/topMenu.css" rel="stylesheet">
        <link href="css/issueTable.css" rel="stylesheet">
        <title>Issues</title>
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
       




    </body>
</html>
