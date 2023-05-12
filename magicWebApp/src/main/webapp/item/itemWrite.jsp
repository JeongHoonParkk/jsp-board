<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "scott";
	String password = "tiger";
	String sql = "select * from ITEM";
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<table border="1" align="center">
		<caption><h1>입력 완료된 정보</h1></caption>
		<tr>
			<th width="80">상품명</td>
			<th width="100">가격</td>
			<th width="150">설명</td>
		</tr>
<%			
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				%>
				<tr>
					<td><%= rs.getString("name") %></td>
					<td><%= rs.getString("price") %></td>
					<td><%= rs.getString("description") %></td>
				</tr>
				<%
			}
		}catch(Exception e){
			e.printStackTrace();
		}
%>
		
	</table>
</body>
</html>