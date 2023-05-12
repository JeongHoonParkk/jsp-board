<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script lang="javascript" src="script3.js" charset="utf-8"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<table border="1" align="center">
			<form name="reg_frm" method="post" action="registerOk.jsp">
				<tr height="50">
					<td colspan="2" align="center">
						<h1>회원 가입 신청</h1> 
						'*' 표시 항목은 필수 입력 항목입니다. 
					</td>
				</tr>
				<tr height="30">
					<td width="80">User ID</td>
					<td>
						<input type="text" name="mem_uid" size="20">*
					</td>
				</tr>
				<tr height="30">
					<td width="80">암호</td>
					<td>
						<input type="password" name="mem_pwd" size="20">*
					</td>
				</tr>
				<tr height="30">
					<td width="80">암호 확인</td>
					<td>
						<input type="password" name="mem_pwd2" size="20">*
					</td>
				</tr>
				<tr height="30">
					<td width="80">이 름</td>
					<td>
						<input type="text" name="mem_name" size="20">*
					</td>
				</tr>
				<tr height="30">
					<td width="80">E-mail</td>
					<td>
						<input type="text" name="mem_email" size="30">*
					</td>
				</tr>
				<tr height="30">
					<td width="80">주소</td>
					<td>
						<input type="text" name="mem_address" size="40">
					</td>
				</tr>
				<tr align="center">
					<td colspan="2"><input type="button" value="등록" onclick="check_ok()">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value="다시입력">&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="login.jsp"><input type="button" value="가입안함" src="login.jsp"></a></td>
				</tr>
			</form>	
		</table>
</body>
</html>