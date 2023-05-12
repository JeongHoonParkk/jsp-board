function check_ok() {
//	유효성 검사(validation check)
//	if(document.reg_frm.mem_uid.value.length==0){
//	if(document.reg_frm.mem_uid.value.length==""){
//	폼 이름에 name 값으로 찾아감
	if(reg_frm.mem_uid.value.length==""){
	   alert("아이디를 써주세요");
	   reg_frm.mem_uid.focus();
	   return;
	}
	if(reg_frm.mem_uid.value.length < 4){
	   alert("아이디는 4글자이상이어야 합니다.");
	   reg_frm.mem_uid.focus();
	   return;
	}
	if(reg_frm.mem_pwd.value.length==0){
	   alert("패스워드는 반드시 입력해야 합니다.");
	   reg_frm.mem_pwd.focus();
	   return;
	}
	if(reg_frm.mem_pwd.value !== reg_frm.mem_pwd2.value){
	   alert("패스워드가 일치하지 않습니다.");
	   reg_frm.mem_pwd2.focus();
	   return;
	}
	if(reg_frm.mem_name.value.length==0){
	   alert("이름을 써주세요");
	   reg_frm.mem_name.focus();
	   return;
	}
	if(reg_frm.mem_email.value.length==0){
	   alert("Email을 써주세요.");
	   reg_frm.mem_email.focus();
	   return;
	}	
	document.reg_frm.submit();
}
function update_check_ok(){
	if(upd_frm.mem_pwd.value.length==0){
	   alert("패스워드는 반드시 입력해야 합니다.");
	   upd_frm.mem_pwd.focus();
	   return;
	}
	if(upd_frm.mem_pwd.value !== upd_frm.mem_pwd2.value){
	   alert("패스워드가 일치하지 않습니다.");
	   upd_frm.mem_pwd2.focus();
	   return;
	}
	if(upd_frm.mem_email.value.length==0){
	   alert("Email을 써주세요.");
	   upd_frm.mem_email.focus();
	   return;
	}
	document.upd_frm.submit();
}