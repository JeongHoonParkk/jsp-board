<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//	넘어오는 페이지 번호를 변수에 저장
	String pageNum = request.getParameter("pageNum");
	
	int b_id = Integer.parseInt(request.getParameter("b_id"));
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script lang="javascript" src="board2.js" charset="utf-8"></script>
</head>

<body>
<!-- 	show.jsp 로 부터 받은 글버호를 delete_ok.jsp 로 넘겨준다 -->
	<form method="post" action="delete_ok.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>" name="del_frm">
		<table align="center">
		<caption><h1>글 삭 제 하 기</h1></caption>
			<tr>
				<td>
					<b>
						>> 암호를 입력하세요. <<
					</b> 
				</td>
			</tr>
			<tr>
				<td>
					암&nbsp;&nbsp;호 
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="password" name="b_pwd" maxlength="12">
				</td>
			</tr>
			<tr align="center">
				<td>
					<input type="button" value="글삭제" onclick="delete_ok()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value="다시작성">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>