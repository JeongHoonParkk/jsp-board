<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String price = request.getParameter("price");
	String description = request.getParameter("description");
	
	Connection conn=null;
    PreparedStatement pstmt=null;

	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "scott";
	String password = "tiger";
	String sql = "INSERT INTO ITEM VALUES(?,?,?)";
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, password);
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, price);
		pstmt.setString(3, description);
		pstmt.executeUpdate();
		
	}catch(Exception e) {
		e.printStackTrace();
	}

%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="itemWrite.jsp"><h1>결과보기</h1></a>
</body>
</html>