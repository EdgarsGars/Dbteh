<%-- 
    Document   : projectCreation
    Created on : Dec 14, 2014, 1:07:21 AM
    Author     : Edgar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/topMenu.css" rel="stylesheet">
        <title>ProjectCreation</title>
    </head>
    <body>

    <body>

        <div id='topmenu'>
            <ul>
                <li><a href='/Dbteh/'><span>Home</span></a></li>
                <li><a href='/Dbteh/projects'><span>Projects</span></a></li>
                <li class='active'><a href='/Dbteh/projectCreation'><span>Add Project</span></a></li>
                <li class='last'><a href='/Dbteh/logout'><span>Logout</span></a></li>
            </ul>
        </div>


        <h1>Project creation</h1>
        <form action="/Dbteh/addProject" method="post">
            <table>
                <tr>
                    <td>Project Name</td><td><input type="text"  name="projectName" placeholder="Project Name"</td>
                </tr>
            </table>
            <textarea name="description" cols="35" rows="10"></textarea><br>
            <input style="width:269px;" type="submit" name="action" value="Submit"/>
        </form>
    </body>
</body>
</html>
