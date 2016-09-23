<%@page import="java.util.List"%>
<%@page import="com.testapp.service.LoginService"%>
<%@page import="java.util.Date"%>
<%@page import="com.testapp.model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<title>Result Page</title>
</head>
<body>
	<div id="container">
		<h1>Result Page</h1>
		<b>This is Sample Result Page</b><br />
		<%=new Date()%>
		<%
		HttpSession usession=request.getSession(false);
		System.out.println(usession);
		if(usession==null){
			response.sendRedirect("login.jsp");
			return;
		}
        Users users = (Users) session.getAttribute("users");
        %>
		<b>Welcome <%= users.getFirstName() + " " + users.getLastName()%></b>
		<br /> <a href="logout.jsp">Logout</a>

		<table>
			<thead>
				<tr>
					<th>User ID</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>email</th>
				</tr>
			</thead>
			<tbody>
				<%
                     LoginService loginService = new LoginService();
                     List<Users> list = loginService.getListOfUsers();
                     for (Users u : list) {
                 %>
				<tr>
					<td><%=u.getUserId()%></td>
					<td><%=u.getFirstName()%></td>
					<td><%=u.getLastName()%></td>
					<td><%=u.getEmail()%></td>
				</tr>
				<%}%>
			
			<tbody>
		</table>
		<br />
	</div>
</body>
</html>