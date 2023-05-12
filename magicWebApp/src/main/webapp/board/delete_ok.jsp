<%@page import="java.io.File"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//	넘어오는 페이지 번호를 변수에 저장
	String pageNum = request.getParameter("pageNum");

	BoardDBBean db = BoardDBBean.getInstance();	
	int b_id = Integer.parseInt(request.getParameter("b_id"));
	String b_pwd = request.getParameter("b_pwd");
	
//  파일삭제를 위한 처리
	BoardBean board = db.getBoard(b_id, false);
	String fName = board.getB_fname();
	
// 	글삭제를 위해서 글번호와 비밀번호를 가지고 메소드 호출
	int re = db.deleteBoard(b_id, b_pwd);	
    String up = "/Users/parkjeonghoon/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/magicWebApp/upload/";
%>
<%
	if(re == 1) {
	
		response.sendRedirect("list.jsp?pageNum=" + pageNum);
		
		if(fName != null) {
			
			File file = new File(up + fName);
// 			File file = new File(application.getRealPath(up + fName));
			file.delete();
		}
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
				alert("삭제에 실패하였습니다.")
				history.go(-1)
			</script>
		<%
	}
%>
</body>
</html>