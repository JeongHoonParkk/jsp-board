<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name = (String)session.getAttribute("name");
	String id = (String)session.getAttribute("id");
%>
<%
	if(session.getAttribute("member") == null) {
		%>
			<jsp:forward page="login.jsp"></jsp:forward>
		<%
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" align="center">
		<form method="post" action="logOut.jsp">
			<tr height="30">
				<td>안녕하세요. <%= name %>(<%= id %>)님</td>
			</tr>
			<tr align="center">
				<td>
					<input type="submit" value="로그아웃">
						&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="회원정보변경" onclick="javascript:window.location='memberUpdate.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>