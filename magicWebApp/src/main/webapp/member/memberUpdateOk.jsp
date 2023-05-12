<!-- 데이터 update 처리하는 jsp -->
<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");//한글처리
%>
<jsp:useBean class="magic.member.MemberBean" id="member"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<!-- 오류 발생시 데이터 확일할 때  -->
<!-- 1.db 쪽에 로그를 추가해서 확인 -->
<!-- 2.오류 발생 시점에 더블클릭해서 표시를 하고 debug 모드로 톰캣을 재시작해서 단축키로 이동하면서 값을 확인  -->
<!-- name="mem_pwd" -->
<!-- name="mem_pwd2" -->
<!-- name="mem_email" -->
<!-- name="mem_address" -->
<!-- 넘어온 값을 세팅 -->
<!-- private String mem_uid; -->
<!-- 	private String mem_pwd; -->
<!-- 	private String mem_name; -->
<!-- 	private String mem_email; -->
<!-- 	private String mem_address; -->
<%
	MemberDBBean manager = MemberDBBean.getInstance();
	String id = (String)session.getAttribute("id");
	member.setMem_uid(id);
	int re = manager.updateMember(member);

	
	
	if(re == 1) {
		%>
		<script>
			alert("입력하신 대로 회원 정보가 수정되었습니다.");
			document.location.href="main.jsp";
		</script>
		<%
	}else{
		%>
		<script>
			alert("수정이 실패했습니다.");
			history.go(-1);
		</script>
		<%
	}
	
%>