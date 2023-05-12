<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="java.net.UnknownHostException"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	//한글처리
    request.setCharacterEncoding("utf-8");
 %>
 //boardBean을 사용하기위한 객체생성
<jsp:useBean class="board.BoardBean" id="board"></jsp:useBean>
//boardBean에 setter를 대신해 값들을 board객체를 통해 넣어줌  * - 모두 넣겠다는 의미 
<jsp:setProperty property="*" name="board"/>

<%
// 	파일 업로드 처리
	/*
	SmartUpload upload = new SmartUpload();
	upload.initialize(pageContext);
	upload.upload();
	String fName="";
	int fSize = 0;
	
	File file =  upload.getFiles().getFile(0);
	if(!file.isMissing()) {
		fName = file.getFileName();
		file.saveAs("/upload/"+file.getFileName());
		fSize = file.getSize();
	}
	*/
	
	String path = request.getRealPath("upload");
	int size = 1024*1024;
	int fileSize = 0;
	String file = "";
	String orifile = "";
	
// 	DefaultFileRenamePolicy() : 파일명 넘버링 처리
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
// 	파일명 가져오기
	Enumeration files = multi.getFileNames();
	String str = files.nextElement().toString();
// 	file : 넘버링 처리된 파일명 
	file = multi.getFilesystemName(str);

	if(file != null) {
// 		orifile : 실제 파일명
		orifile = multi.getOriginalFileName(str);
		fileSize = file.getBytes().length;
	}
%>
<%
	//BoardDbBean에 있는 메소드를 사용하기 위해 getInstace()메소드 활용하여 manager 객체생성 
	BoardDBBean manager = BoardDBBean.getInstance();
	//오늘 날짜 추가
	board.setB_date(new Timestamp(System.currentTimeMillis()));
	
	//ip 추가(0:0:0:0:0:0:0:1)
// 	board.setB_ip(request.getRemoteAddr());
	
// 	자바 클래스 이용해서 ip 추가
	InetAddress address = InetAddress.getLocalHost();
// 	getHostAddress() : ip 주소 가져오는 메소드
	String ip = address.getHostAddress();

	board.setB_ip(ip);//192.168.50.17
	
    //데이터베이스에 값을 넣어주는 insertBoard() 메소드 사용하여 리턴값을 변수에 받음
    out.print(board.getB_step());
    out.print(board.getB_level());
	
// 	파일 업로드 처리
	/*
	board.setB_id(Integer.parseInt(upload.getRequest().getParameter("b_id")));
	board.setB_name(upload.getRequest().getParameter("b_name"));
	board.setB_email(upload.getRequest().getParameter("b_email"));
	board.setB_title(upload.getRequest().getParameter("b_title"));
	board.setB_content(upload.getRequest().getParameter("b_content"));
	board.setB_pwd(upload.getRequest().getParameter("b_pwd"));
	*/

	board.setB_id(Integer.parseInt(multi.getParameter("b_id")));
	board.setB_name(multi.getParameter("b_name"));
	board.setB_email(multi.getParameter("b_email"));
	board.setB_title(multi.getParameter("b_title"));
	board.setB_content(multi.getParameter("b_content"));
	board.setB_pwd(multi.getParameter("b_pwd"));
	
	
	board.setB_ref(Integer.parseInt(multi.getParameter("b_ref")));
	board.setB_step(Integer.parseInt(multi.getParameter("b_step")));
	board.setB_level(Integer.parseInt(multi.getParameter("b_level")));
	
	
	
// 	board.setB_fname(fName);
// 	board.setB_fsize(fSize);

	if(file != null) {
	board.setB_fname(file);
	board.setB_fsize(fileSize);		
	board.setB_rfname(orifile);		
	}
	int re = manager.insertBoard(board);
%>

<%
// 	값이 제대로 들어가는지 확인하는 과정
	System.out.println("writeOk name ===>"+board.getB_name());
	System.out.println("email ===>"+board.getB_email());
	System.out.println("title ===>"+board.getB_title());

	
	if(re == 1) {//글쓰기가 정상적으로 완료시
		%>
			<script>
				alert("등록되었습니다.");
			</script>
		<%
		response.sendRedirect("list.jsp");
	}else{
		%>
		<script>
			alert("작성중 오류가 발생하였습니다.");
		</script>
	<%
		response.sendRedirect("write.jsp");
	}
%>
