/**
 * 
 */
function check_ok(){
	if(reg_frm.b_name.value.length==0){
	   alert("작성자를 입력하셔야합니다.");
	   reg_frm.b_name.focus();
	   return;
	}
	if(reg_frm.b_title.value.length==0){
	   alert("제목을 입력하셔야합니다.");
	   reg_frm.b_title.focus();
	   return;
	}
	if(reg_frm.b_content.value.length==0){
	   alert("내용을 입력하셔야합니다.");
	   reg_frm.b_content.focus();
	   return;
	}
	if(reg_frm.b_pwd.value.length==0){
	   alert("비밀번호를 입력하셔야합니다.");
	   reg_frm.b_pwd.focus();
	   return;
	}
	document.reg_frm.submit();
}
function delete_ok(){
	
	if(document.del_frm.b_pwd.value.length==0){
	   alert("비밀번호를 입력하셔야합니다.");
	   del_frm.b_pwd.focus();
	   return;
	}
	document.del_frm.submit();
}