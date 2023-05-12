<%@page import="magic.member.MemberDBBean2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="magic.member.MemberBean" id="bean"></jsp:useBean>
<jsp:setProperty property="*" name="bean"/>
<%
	MemberDBBean2 mb = MemberDBBean2.getInstance();
	String id = (String)session.getAttribute("id");
	bean.setMem_uid(id);
	int re = mb.updateMember(bean);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if(re == 1) {
		%>
			<script type="text/javascript">
				alert("정보수정완료")
				document.location.href="log.jsp";
			</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("정보수정실패")
		</script>
	<%
	}
%>
</body>
</html>