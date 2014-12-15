<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/loginForm.css" rel="stylesheet">
<title>Login</title>
</head>
<body>
    <div id="login">
        <h1>Login</h1>
        <form action="/Dbteh/auth" method="post">
        <%  if(request.getParameter("error") != null){
                out.println("<p style=\\\"color:red;\\\">Incorrect username or password!</p>");
            }
        %>
        
            <input type="text"  name="username" placeholder="Username" /><br>
             <input type="password" name="password"placeholder="Password" /><br> 
             <input type="submit" value="Signup" />
        </form>
    </div>
</body>
</html>