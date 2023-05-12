package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean();
	
	public static BoardDBBean getInstance() {
		return instance;
	}
	public Connection getConnection() throws Exception {//예외처리
	      Context ctx = new InitialContext(); //네이밍 - 이름을 붙임 //InitialContext() 참조변수에게 준비하라는 
	      DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");//xml 파일에서 괄호엔에 내용을 찾아감
//	      dbcp 커넥션 객체 정보
	      return ds.getConnection();
	}
	public int insertBoard(BoardBean board) {
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      String sql="";
	      int re=-1;//초기값 -1, insert 정상적으로 실행되면 1
	      int number;
	      int id = board.getB_id();
	      int ref = board.getB_ref();
	      int step = board.getB_step();
	      int level = board.getB_level();
	      
	      try {
	         conn = getConnection();
//	         글번호 최대값+1을 구함: null 일때는 1, 아니면 +1
	         String sql2="SELECT max(b_id) FROM boardT";
	         pstmt = conn.prepareStatement(sql2);
	         rs = pstmt.executeQuery();
//	         
	         if (rs.next()) {
	            number = rs.getInt(1)+1;
	         } else {
	            number = 1;
	         }
	         
//	         1.글번호를 가지고 오는 경우(답변)
//	         2.글번호를 가지고 오지 않는 경우(신규글)
	         if (id != 0) {//글번호를 가지고 오는 경우(답변)
//	            특정 조건에 step+1 로 업데이트
	            sql="UPDATE boardT SET b_step=b_step+1 WHERE b_ref=? and b_step > ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, ref);
	            pstmt.setInt(2, step);
	            pstmt.executeUpdate();
	            
	            step=step+1;
	            level=level+1;
	         } else {//글번호를 가지고 오지 않는 경우(신규글)
	            ref=number;
	            step=0;
	            level=0;
	         }
	         sql="INSERT INTO boardT(b_id, b_name, b_email, b_title, b_content"
//	               + ", b_date, b_pwd, b_ip, b_ref, b_step, b_level) " //오류 방지를 위해 기존 데이터 주석처리
	               + ", b_date, b_pwd, b_ip, b_ref, b_step, b_level, b_fname, b_fsize, b_rfname) "
	               + "VALUES((SELECT nvl(max(b_id),0)+1 FROM boardT),?,?,?,?,?,?,?"
	               + ",?,?,?,?,?,?)";
	         
	         
	         pstmt = conn.prepareStatement(sql);
//	         pstmt.setInt(1, number);
	         System.out.println("insertBoard name===>"+board.getB_name());
	         System.out.println("insertBoard email===>"+board.getB_email());
	         System.out.println("insertBoard ===>"+board.getB_title());
	         pstmt.setString(1, board.getB_name());
	         pstmt.setString(2, board.getB_email());
	         pstmt.setString(3, board.getB_title());
	         pstmt.setString(4, board.getB_content());
	         pstmt.setTimestamp(5, board.getB_date());
	         pstmt.setString(6, board.getB_pwd());
	         pstmt.setString(7, board.getB_ip());
	         pstmt.setInt(8, ref);
	         pstmt.setInt(9, step);
	         pstmt.setInt(10, level);
	         pstmt.setString(11, board.getB_fname());
	         pstmt.setInt(12, board.getB_fsize());
	         pstmt.setString(13, board.getB_rfname()); 
	         re = pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	         System.out.println("추가 실패");
	      }finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	      return re;
	   }
//	public ArrayList<BoardBean> listBoard() {// 각각의 게시물을 객체로 만들어 순서대로 넣는다.
	public ArrayList<BoardBean> listBoard(String pageNumber) {// 각각의 게시물을 객체로 만들어 순서대로 넣는다.
		ArrayList<BoardBean> blist = new ArrayList<>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		ResultSet pageSet = null;//페이지에 관련된 결과값 받기위한 참조변수
		int dbCount = 0;//게시글 총 개수 
		int absolutePage = 1;

		String sql = "SELECT b_id, b_name, b_email, b_title, b_content, b_date, b_hit, b_pwd, b_ip,"
				+ " b_ref, b_step, b_level, b_fname, b_fsize FROM boardT "
//				ORDER BY b_ref desc, b_step asc  => 최신글 순이고, 답글 순
				+ "ORDER BY b_ref desc, b_step asc";
		
		String sql2 = "SELECT COUNT(b_id) FROM boardT";
		try {
			conn = getConnection();
//			stmt = conn.createStatement();
//			페이지 처리를 위한 메소드 파라미터 추가
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pageSet = stmt.executeQuery(sql2);
			
			if (pageSet.next()) {//게시글 총 개수 존재 여부
				dbCount = pageSet.getInt(1);//게시글 총 개수
				pageSet.close();//자원 반납
			}
			
			//ex> 84건인 경우 (84 % 10 = 4)
			//ex> 80건인 경우 (80 % 10 = 0)
			if (dbCount % BoardBean.pageSize == 0) {
//				80 / 10 = 8 페이지
				BoardBean.pageCount = dbCount / BoardBean.pageSize;
			} else {//84건인 경우
//				84 / 10 + 1 = 9 페이지
				BoardBean.pageCount = dbCount / BoardBean.pageSize + 1;
			}
			
			if(pageNumber != null) {//넘어오는 페이지 번호가 있는 경우
				BoardBean.pageNum = Integer.parseInt(pageNumber);
//				ex> 1 : 0* 10 + 1 = 1, 2 : 1* 10 + 1 = 11 =>1페이지는 1, 2페이지는 11 (페이지 기준 게시글) 
				absolutePage = (BoardBean.pageNum - 1) * BoardBean.pageSize + 1;
			}
			
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {//게시글이 있으면 참
				rs.absolute(absolutePage);//페이지의 기준 게시글 세팅
				int count = 0;
				
				while (count < BoardBean.pageSize) {//게시글 개수만큼 반복
//					쿼리 결과를 BoardBean 객체에 담아서 ArrayList 에 저장
					BoardBean bb = new BoardBean();
					bb.setB_id(rs.getInt(1));
					bb.setB_name(rs.getString(2));
					bb.setB_email(rs.getString(3));
					bb.setB_title(rs.getString(4));
					bb.setB_content(rs.getString(5));
					bb.setB_date(rs.getTimestamp(6));
					bb.setB_hit(rs.getInt(7));
					bb.setB_pwd(rs.getString(8));
					bb.setB_ip(rs.getString(9));
					bb.setB_ref(rs.getInt(10));
					bb.setB_step(rs.getInt(11));
					bb.setB_level(rs.getInt(12));
					bb.setB_fname(rs.getString(13));
					bb.setB_fsize(rs.getInt(14));
				
//					행의 데이터를 ArrayList 에 저장
					blist.add(bb);
					
//					페이지 변경시 처리위한 로직
					if (rs.isLast()) {
						break;
					} else {
						rs.next();
					}
					count++;
				}
			}
/*			while (rs.next()) {
//				쿼리 결과를 BoardBean 객체에 담아서 ArrayList 에 저장
				BoardBean bb = new BoardBean();
				bb.setB_id(rs.getInt(1));
				bb.setB_name(rs.getString(2));
				bb.setB_email(rs.getString(3));
				bb.setB_title(rs.getString(4));
				bb.setB_content(rs.getString(5));
				bb.setB_date(rs.getTimestamp(6));
				bb.setB_hit(rs.getInt(7));
				bb.setB_pwd(rs.getString(8));
				bb.setB_ip(rs.getString(9));
				bb.setB_ref(rs.getInt(10));
				bb.setB_step(rs.getInt(11));
				bb.setB_level(rs.getInt(12));
			
//				행의 데이터를 ArrayList 에 저장
				blist.add(bb);
			} */
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (rs != null) rs.close();
				if (stmt != null) stmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
			
		return blist;
	}
	public BoardBean getBoard(int index, boolean hitAdd) {
		BoardBean bb = new BoardBean(); 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM BOARDT WHERE b_id = ?";
		String sql2 = "UPDATE boardT SET b_hit =(b_hit+1) where b_id = ?";
		
		try {
//			조회수 1증가
			conn = getConnection();
			if(hitAdd == true) {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, index);
				pstmt.executeUpdate();
				//글 내용 보기
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, index);
				rs = pstmt.executeQuery();
			}else {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, index);
				rs = pstmt.executeQuery();
			}
//			글 내용 보기
			if (rs.next()) {
				bb.setB_id(index);
				bb.setB_name(rs.getString("b_name"));
				bb.setB_email(rs.getString("b_email"));
				bb.setB_title(rs.getString("b_title"));
				bb.setB_content(rs.getString("b_content"));
				bb.setB_date(rs.getTimestamp("b_date"));
				bb.setB_hit(rs.getInt("b_hit"));
				bb.setB_pwd(rs.getString("b_pwd"));
				bb.setB_pwd(rs.getString("b_ip"));
				bb.setB_ref(rs.getInt("b_ref"));
				bb.setB_step(rs.getInt("b_step"));
				bb.setB_level(rs.getInt("b_level"));
				bb.setB_fname(rs.getString("b_fname"));
				bb.setB_fsize(rs.getInt("b_fsize"));
				bb.setB_rfname(rs.getString("b_rfname"));
				
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return bb;
	}
	public int deleteBoard(int index, String b_pwd){
		BoardBean bb = new BoardBean();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int re = -1;
		String pwd = "";
		
//		글번호로 비밀번호 조회
		String sql = "SELECT b_pwd FROM BOARDT where b_id = ?";
		String sql2 = "DELETE FROM boardT WHERE b_id = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
//			쿼리 파라미터는 메소드 매개변수
			pstmt.setInt(1, index);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {//비밀번호가 있으면 참
//				쿼리결과에서 b_pwd 컬럼 데이터
				pwd = rs.getString(1);
				if (!pwd.equals(b_pwd)) {//비밀번호 불일치
					re = 0;//삭제안됨
				}else {
					pstmt = conn.prepareStatement(sql2);
					pstmt.setInt(1, index);
					re = pstmt.executeUpdate();
					re = 1;//정상적으로 삭제
				}
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return re;
	}
//	수정할 내용을 BoardBean 타입의 객체로 받는다.
	public int editBoard(BoardBean board) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String b_pwd = "";
		int re = -1;
		 
		 try {
			 sql = "SELECT b_pwd from boardT where b_id=?";
			 conn = getConnection();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, board.getB_id());
			 rs = pstmt.executeQuery();
			 if(rs.next()) {
				 b_pwd = rs.getString(1);
				 System.out.println("test" + board.getB_pwd());
				 System.out.println("test" + b_pwd);
				 if (!b_pwd.equals(board.getB_pwd())) {//비밀번호 불일치시
					re = 0;
				}else {//비밀번호 일치시
					sql = "UPDATE boardT SET b_name=?, b_email=?, b_title=?, b_content=? WHERE b_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, board.getB_name());
					pstmt.setString(2, board.getB_email());
					pstmt.setString(3, board.getB_title());
					pstmt.setString(4, board.getB_content());
					System.out.println("test" + board.getB_id());
					pstmt.setInt(5, board.getB_id());
					re = pstmt.executeUpdate();
				}
			 }
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		 return re;
	}
	public BoardBean getFileName(int bid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT b_fname, b_rfname from boardT where b_id=?";
		BoardBean board = null;
		
		try {
			 conn = getConnection();
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, bid);
			 rs = pstmt.executeQuery();
			 
//			 첨부파일이 있으면
			 if(rs.next()) {
				 board = new BoardBean();
				 board.setB_fname(rs.getString(1));
				 board.setB_rfname(rs.getString(2));
			 }
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return board;
	}
}
