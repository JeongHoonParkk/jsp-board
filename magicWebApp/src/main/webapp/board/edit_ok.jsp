<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean class="board.BoardBean" id="bean"></jsp:useBean>
<jsp:setProperty property="*" name="bean"/>
<% 
//	넘어오는 페이지 번호를 변수에 저장
	String pageNum = request.getParameter("pageNum");
	
	int b_id = Integer.parseInt(request.getParameter("b_id"));
	String b_pwd = request.getParameter("b_pwd");
	bean.setB_id(b_id);
	bean.setB_pwd(b_pwd);
	BoardDBBean db = BoardDBBean.getInstance();
	int re = db.editBoard(bean);
	
	System.out.println("@# name===>"+bean.getB_id());
	System.out.println("@# name===>"+bean.getB_name());
	System.out.println("@# email===>"+bean.getB_email());
	System.out.println("@# title===>"+bean.getB_title());
	System.out.println("@# content===>"+bean.getB_content());
	System.out.println("@# content===>"+bean.getB_pwd());
	
	if(re == 1) {
		%>
			<script type="text/javascript">
				alert("정상적으로 수정되었습니다.");
			</script>
		<%	
		response.sendRedirect("list.jsp?pageNum=" + pageNum);
	}else if(re == 0) {
		%>
			<script type="text/javascript">
				alert("비밀번호가 틀렸습니다.")
				history.go(-1)
			</script>
		<%
	}else if(re == -1){
		%>
			<script type="text/javascript">
				alert("수정에 실패하였습니다.")
				history.go(-1)
			</script>
		<%
	}
	
%>
