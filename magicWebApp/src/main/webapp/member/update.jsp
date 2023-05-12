<%@page import="magic.member.MemberBean"%>
<%@page import="magic.member.MemberDBBean2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDBBean2 mb = MemberDBBean2.getInstance();
	String id = (String)session.getAttribute("id");
	MemberBean member = mb.getMember(id);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="update_ok.jsp">
		<table align="center">
		<caption>회원정보수정</caption>
			<tr>
				<td>
					아이디 <%= id %>
				</td>
			</tr>
			<tr>
				<td>
					비밀번호 <input type="password" name="mem_pwd">
				</td>
			</tr>
			<tr>
				<td>
					이름 <%= member.getMem_name() %>
				</td>
			</tr>
			<tr>
				<td>
					이멜 <input type="text" name="mem_email">
				</td>
			</tr>
			<tr>
				<td>
				 	주소 <input type="text" name="mem_address">
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="등록">
					<input type="button" value="로그인" onclick="location='log.jsp'">
				</td>
			</tr>			
		</table>
	</form>
</body>
</html>