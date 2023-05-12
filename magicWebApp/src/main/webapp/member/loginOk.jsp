<%@page import="magic.member.MemberBean"%>
<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id = request.getParameter("mem_uid");
	String pwd = request.getParameter("mem_pwd");
	
	MemberDBBean manager=MemberDBBean.getInstance();
	int check = manager.userCheck(id, pwd);
	MemberBean mb = manager.getMember(id);
	
	if(mb == null){//회원없음
		%>
	 	<script>
		alert("존재하지 않는 회원");
		</script>
		<%
	}else{//회원있음
		String name = mb.getMem_name(); 
		if(check == 1){//비밀번호가 일치하면 1
			session.setAttribute("id", id);//회원아이디
			session.setAttribute("name", name);//회원이름
			session.setAttribute("member", "yes");//회원여부
			response.sendRedirect("main.jsp");
		}else if(check == 0){//비밀번호가 불일치 하면 0
			%>
			<script>
				alert("비밀번호가 맞지 않습니다.");
// 				history.back();
				history.go(-1);
			</script>
			<%
		}else{//아이디가 불일치
			%>
				<script type="text/javascript">
					alert("아이디가 맞지 않습니다.");
// 					history.back();
					history.go(-1);
				</script>
			<%
		}
	}
%>
</body>
</html>