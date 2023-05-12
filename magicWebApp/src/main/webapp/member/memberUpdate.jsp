<%@page import="magic.member.MemberBean"%>
<%@page import="magic.member.MemberDBBean"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 	String name = (String)session.getAttribute("name");
	String id = (String)session.getAttribute("id");
	
	MemberDBBean manager = MemberDBBean.getInstance();
	MemberBean member = manager.getMember(id);
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script lang="javascript" src="script3.js" charset="utf-8"></script>
</head>
<body>
		<table border="1" width="350" align="center">
		<form name="upd_frm" method="post" action="memberUpdateOk.jsp">
			<tr align="center">
				<td colspan="2">
					<h1>회원 정보 수정</h1><br>
					'*' 표시 항목은 필수 입력 항목입니다.				
				</td>
			</tr>
			<tr height="30">
				<td width="100">User ID</td>
				<td><%= id %></td>
			</tr>
			<tr height="30">
				<td width="100">암호</td>
				<td><input type="password" name="mem_pwd" size="20">*</td>
			</tr>
			<tr height="30">
				<td width="100">암호 확인</td>
				<td><input type="password" name="mem_pwd2" size="20">*</td>
			</tr>
			<tr height="30">
				<td width="100">이름</td>
				<td><%= member.getMem_name() %></td>
			</tr>
			<tr height="30">
				<td width="100">E-mail</td>
				<td><input type="text" name="mem_email" size="30" value="<%= member.getMem_email() %>">*</td>
			</tr>
			<tr height="30">
				<td width="100">주 소</td>
				<td><input type="text" name="mem_address" size="40" value="<%= member.getMem_address() %>"></td>
			</tr>
			<tr align="center">
				<td colspan="2">
					<input type="button" value="수정" onclick="update_check_ok()">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value="다시입력">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="수정안함" onclick="javascript:window.location='login.jsp'">
				</td>
			</tr>
		</form>	
		</table>
</body>
</html>