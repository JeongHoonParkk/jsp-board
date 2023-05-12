<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
	String name = (String)session.getAttribute("name");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<td>하이<%= name %>(<%= id %>)</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="회원정보변경" onclick="location='update.jsp'">
			</td>
		</tr>
	</table>
</body>
</html>