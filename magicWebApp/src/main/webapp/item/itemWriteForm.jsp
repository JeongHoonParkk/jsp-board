<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="itemWriteResult.jsp">	
		<h1>정보 입력 폼</h1>
		<table>
			<tr>
				<td>상품명</td> 
				<td><input type="text" name="name"> </td>
			</tr>
			<tr>
				<td>가격</td> 
				<td><input type="text" name="price"></td>
			</tr>
			<tr>
				<td>설명</td> 
				<td>
					<textarea rows="10" cols="60" name="description"></textarea>
				</td>
			</tr>
			<tr align="center">
				<td colspan="2">
					<input type="submit" value="전송">
					<input type="reset" value="취소">
				</td>
			</tr>
		</table>
	</form>	
</body>
</html>