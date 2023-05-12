<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" align="center">
		<tr height="30" align="center">
			<td width="80">사용자 Id</td>
			<td><input type="text" name="mem_uid"></td>
		</tr>
		<tr height="30">
			<td width="80" align="center">비밀번호</td>
			<td> <input type="password" name="mem_pwd"> </td>
		</tr>
		<tr align="center">
			<td colspan="2"> 
				<input type="submit" value="로 그 인">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="회원가입" onclick="javascript:window.location='register2.jsp'">
			</td>
		</tr>
	</table>
</body>
</html>