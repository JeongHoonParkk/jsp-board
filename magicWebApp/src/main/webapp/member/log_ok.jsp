<%@page import="magic.member.MemberBean"%>
<%@page import="magic.member.MemberDBBean2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	MemberDBBean2 mb = MemberDBBean2.getInstance();
	String id = request.getParameter("mem_uid");
	String pwd = request.getParameter("mem_pwd");
	int re = mb.userCheck(id, pwd);
	MemberBean mmb = mb.getMember(id);
	if(re == 1) {
		String name = mmb.getMem_name();
		session.setAttribute("id",id);
		session.setAttribute("name", name);
		response.sendRedirect("main2.jsp");
		%>
		<script type="text/javascript">
			alert("로그인성공");
		</script>
		<%
		
	}
%>
</body>
</html>