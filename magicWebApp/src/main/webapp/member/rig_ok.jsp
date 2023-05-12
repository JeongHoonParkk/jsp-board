<%@page import="magic.member.MemberDBBean2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="magic.member.MemberBean" id="bean"></jsp:useBean>
<jsp:setProperty property="*" name="bean"/>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	MemberDBBean2 mb2 = MemberDBBean2.getInstance();
	int re = mb2.insertMember(bean);
	if(re == 1){
		%>
		<script type="text/javascript">
			alert("가입완료")
		</script>
		<% 
	}
%>
</body>
</html>