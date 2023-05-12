<%@page import="board.BoardBean"%>
<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//	넘어오는 페이지 번호를 변수에 저장
	String pageNum = request.getParameter("pageNum");

	int b_id = Integer.parseInt(request.getParameter("b_id"));
	BoardDBBean db = BoardDBBean.getInstance();
	BoardBean board = db.getBoard(b_id, false);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script lang="javascript" src="board2.js" charset="utf-8"></script>
</head>
<body>
<!-- 	edit_ok.jsp 로 show.jsp 에서 받은 글번호를 넘긴다. -->
<form method="post" action="edit_ok.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>" name="reg_frm">
	<table align="center">
	<caption><h2>글 수 정 하 기</h2></caption>
		<tr>
			<td>
				작성자
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" name="b_name" size="10" maxlength="20" 
				value="<%= board.getB_name() %>">
				&nbsp;&nbsp;&nbsp;&nbsp;
				이메일 
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" name="b_email" size="25" maxlength="50"
				value="<%= board.getB_email() %>">

			</td>
		</tr>
		<tr>
			<td>
				글제목 
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" name="b_title" size="50" maxlength="80"
				value="<%= board.getB_title() %>">

			</td>		
		</tr>
		<tr>
			<td>
				<textarea rows="10" cols="60" name="b_content"><%= board.getB_content() %></textarea>
			</td>
		</tr>
		<tr>
			<td>
				암호 
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="password" name="b_pwd" size="15" maxlength="12">
			</td>
		</tr>
		<tr>
			<td align="center">
				<input type="button" value="글수정" onclick="check_ok()">
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