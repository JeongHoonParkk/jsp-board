<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDBBean"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
// 	넘어오는 페이지 번호를 변수에 저장
	String pageNum = request.getParameter("pageNum");
	
// 	넘어오는 페이지 번호가 없으면 1페이지
	if(pageNum == null) {
		pageNum = "1";
	}

	BoardDBBean  db = BoardDBBean.getInstance();
//	호출된 메소드의 반환 타입으로 받아주면 됨
// 	ArrayList<BoardBean> list = db.listBoard();
	ArrayList<BoardBean> list = db.listBoard(pageNum);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	int b_level = 0, b_fsize = 0;
%>
</head>
<body>
	<h1 align="center">게시판에 등록된 글 목록 보기</h1>
	<table width="80%">
		<tr>
			<td width="5%"></td>
			<td width="75%"></td>
			<td align="right" width="20%">
<!-- 				<a href="write.jsp">글 쓰 기</a> -->
				<a href="write.jsp?pageNum=<%= pageNum %>">글 쓰 기</a>
			</td>
		</tr>
	</table>
	
	<table border="2" width="80%" cellspacing="0" align="center">
		<tr style="border-color: white;">
		</tr>
		<tr align="center">
			<td width="5%">번호</td>
			<td width="5%">첨부파일</td>
			<td width="45%">글제목</td>
			<td width="20%">작성자</td>
			<td width="20%" align="center">작성일</td>
			<td width=10% align="center">조회수</td>
		</tr>
		<%
// 			boardLit 에 있는 오라클 데이터 가져옴
			for(int i = 0; i < list.size(); i++){
// 				ArrayList 데이터의 BoardBean 객체를 가져온다.
				BoardBean data = list.get(i);
				int b_id = data.getB_id();
				String b_title = data.getB_title();
				String b_name = data.getB_name();
				String b_email = data.getB_email();
				Timestamp b_date = data.getB_date();
				int b_hit = data.getB_hit();
				b_level = data.getB_level();
				b_fsize = data.getB_fsize();
				
				
				%>
				<tr onmouseover="this.style.background='pink'" onmouseout="this.style.background='white'">
					<td align="center"><%= b_id %></td>
					<td>
						<%
							if(b_fsize > 0) {
								%>
									<img src="../images/zip.gif">
								<%
							}
						%>
					</td>
					<td>
						<%
// 						b_level 기준으로 화살표 이미지를 들여쓰기로 출력
						if(b_level > 0){//답변글
							for(int j=0; j<b_level; j++){//for 기준으로 들여쓰기를 얼마만큼 할것인지 정함
					%>
								&nbsp;
					<%
							}
// 							들여쓰기가 적용된 시점->이미지 추가
					%>
							<img src="../images/AnswerLine.gif" width="16" height="16">
					<%
						}
					%>
<!-- 					글번호를 가지고 글내용 보기 페이지로 이동 -->				
<%-- 						<a href="show.jsp?id=<%= b_id %>"><%= b_title %></a> --%>
						<a href="show.jsp?id=<%= b_id %>&pageNum=<%= pageNum %>">
							<%= b_title %>
						</a>
					</td>
					<td align="center"><a href="mailto:<%= b_email %>"><%= b_name %></a></td>
					<td align="center"><%= sdf.format(b_date) %></td>
					<td align="center"><%= b_hit %></td>
				</tr>
				<%
			}
		%>
		
	</table>
<!-- 	페이지 표시 4개씩 -->
 <center>
	<%= BoardBean.pageNumber(4) %>
</center>	
</body>
</html>