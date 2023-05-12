<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//	넘어오는 페이지 번호를 변수에 저장
	String pageNum = request.getParameter("pageNum");
	
	int index = Integer.parseInt(request.getParameter("id"));
	BoardDBBean  db = BoardDBBean.getInstance();
// 	board 객체에 게시글의 정보가 저장되어 있음
	BoardBean bb = db.getBoard(index, true);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1 align="center">글 내 용 보 기</h1>
<%-- 	<form method="post" action="delete.jsp?b_id=<%= index %>"> --%>
		<table border="2" width="60%" cellspacing="0" align="center">
			<tr align="center">
				<td width="30%">글번호</td>
				<td><%= bb.getB_id() %></td>
				<td>조회수</td>
				<td><%= bb.getB_hit() %></td>
			</tr>
			<tr align="center">
				<td>작성자</td>
				<td><%= bb.getB_name() %></td>
				
				<td>작성일</td>
				<td><%= sdf.format(bb.getB_date())%></td>
			</tr>
			<tr height="30" align="center">
				<td width="110">파&nbsp;&nbsp;일</td>
				<td colspan="3">
					&nbsp;
					<!-- 					
					<%
						if(bb.getB_fname() != null) {
							%>
								<img src="../images/zip.gif">
								<a href="../upload/<%= bb.getB_fname() %>">
									원본파일 : <%= bb.getB_fname() %>
								</a>
							<%
						}
					%>
					-->
					<%
						out.print(bb.getB_rfname());
						out.print("<p>첨부파일"+"<a href='FileDownload.jsp?fileN="+bb.getB_id()+"'>"+bb.getB_rfname()+"</a>"+"</p>");
					%>
				</td>
			</tr>
			<tr>	
				<td align="center">글제목</td>
				<td colspan="3"><%= bb.getB_title() %></td>
			</tr>	
			<tr>	
				<td align="center">글내용</td>
				<td colspan="3"><%= bb.getB_content() %></td>
			</tr>
			<tr align="right">
				<td colspan="4">
					<input type="button" value="글수정" onclick="location.href='edit.jsp?b_id=<%= index %>&pageNum=<%= pageNum %>'">
					<input type="button" value="글삭제" onclick="location.href='delete.jsp?b_id=<%= bb.getB_id() %>&pageNum=<%= pageNum %>'">
					<input type="button" value="답변" onclick="location.href='write.jsp?b_id=<%= bb.getB_id() %>&pageNum=<%= pageNum %>'">
					<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'">
				</td>
			</tr>
		</table>
<!-- 	</form> -->
<%
	
%>
</body>
</html>