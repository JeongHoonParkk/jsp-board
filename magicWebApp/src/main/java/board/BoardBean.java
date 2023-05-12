package board;

import java.sql.Timestamp;

public class BoardBean {
	private String b_name;
	private String b_email;
	private String b_title;
	private String b_content;
	private int b_id;
	private Timestamp b_date;
	private int b_hit;
	private String b_pwd;
	private String b_ip;
	
	private int b_ref=0;
	private int b_step=0;
	private int b_level=0;
	
	private String b_fname;
	private int b_fsize;
	
	private String b_rfname;
	
	public String getB_rfname() {
		return b_rfname;
	}

	public void setB_rfname(String b_rfname) {
		this.b_rfname = b_rfname;
	}

	public String getB_fname() {
		return b_fname;
	}

	public void setB_fname(String b_fname) {
		this.b_fname = b_fname;
	}

	public int getB_fsize() {
		return b_fsize;
	}

	public void setB_fsize(int b_fsize) {
		this.b_fsize = b_fsize;
	}
	public static int pageSize = 10;//한 페이지당 10개 출력물 
	public static int pageCount = 1;//페이지 지정 변수
	public static int pageNum = 1;//현재 페이지 번호 
	
//	리턴 : [이전] + 페이지번호 + [다음]
//	limit : 페이지 화면 출력 개수(ex>pdf는 4개)
	public static String pageNumber(int limit) {
		String str = "";
		// 현재 페이지에서 start페이지 첫번째 뜨는 숫자를 구해주기위해 존재 // 일정 개수씩 끊어져서
		int temp = (pageNum-1) % limit; // -1 을 하고 limit으로 나누는 이유는 정수를 맞춰주기 위해
		
		int startPage = pageNum - temp; // 시작되는 페이지 번호 (처음뜨는 숫자)
		
//		[이전] 출력 여부
		if ((startPage - limit) > 0) { // 
			str = "<a href='list.jsp?pageNum="+(startPage - 1)+"'>[이전]</a>&nbsp;&nbsp;";
		}
		
		//페이지 번호 나열하기
		for (int i = startPage; i < (startPage+limit); i++) { // i = 1 , i < 5
			if (i == pageNum) {// 현재 페이지에서 i값과 같으면 하이퍼링크 안걸어줌
				str += "["+i+"]&nbsp;&nbsp;";
			} else {
				str += "<a href='list.jsp?pageNum="+i+"'>"+"["+i+"]</a> &nbsp;&nbsp;";
			}
			if (i >= pageCount) break;
		}
//		[다음] 출력 여부
		if ((startPage + limit) <= pageCount) {
			str += "<a href='list.jsp?pageNum="+(startPage + limit)+"'>[다음]</a>&nbsp;&nbsp;";
		}
		return str;
	}

	public int getB_ref() {  
		return b_ref;
	}
	public void setB_ref(int b_ref) {
		this.b_ref = b_ref;
	}
	public int getB_step() {
		return b_step;
	}
	public void setB_step(int b_step) {
		this.b_step = b_step;
	}
	public int getB_level() {
		return b_level;
	}
	public void setB_level(int b_lever) {
		this.b_level = b_lever;
	}
	public String getB_ip() {
		return b_ip;
	}
	public void setB_ip(String b_ip) {
		this.b_ip = b_ip;
	}
	public String getB_pwd() {
		return b_pwd;
	}
	public void setB_pwd(String b_pwd) {
		this.b_pwd = b_pwd;
	}
	public int getB_hit() {
		return b_hit;
	}
	public void setB_hit(int b_hit) {
		this.b_hit = b_hit;
	}
	public Timestamp getB_date() {
		return b_date;
	}
	public void setB_date(Timestamp b_date) {
		this.b_date = b_date;
	}
	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
	public String getB_name() {
		return b_name;
	}
	public void setB_name(String b_name) {
		this.b_name = b_name;
	}
	public String getB_email() {
		return b_email;
	}
	public void setB_email(String b_email) {
		this.b_email = b_email;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
}
