package magic.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDBBean2 {
	private static MemberDBBean2 instance = new MemberDBBean2();
	public static MemberDBBean2 getInstance() {
		return instance;
	}
	public Connection getConnetion() throws Exception {
		Context cxt = new InitialContext();
		DataSource ds = (DataSource) cxt.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	public int insertMember(MemberBean bean) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		MemberDBBean2 mb = new MemberDBBean2();
		String sql = "INSERT INTO MEMBERT VALUES(?,?,?,?,?)";
		int re = -1;
		try {
			conn = mb.getConnetion();
			pstmt = conn.prepareStatement(sql);
			pstmt.setNString(1, bean.getMem_uid());
			pstmt.setNString(2, bean.getMem_pwd());
			pstmt.setNString(3, bean.getMem_name());
			pstmt.setNString(4, bean.getMem_email());
			pstmt.setNString(5, bean.getMem_address());
			pstmt.executeUpdate();
			re = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	}
	public int userCheck(String id, String pwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT mem_pwd FROM memberT WHERE mem_uid=?";
		int re = -1;
		String checkPwd = "";
		try {
			conn = getConnetion();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				checkPwd = rs.getString("mem_pwd");
				if (checkPwd.equals(pwd)) {
					re = 1;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	}
	public MemberBean getMember(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberBean member = null;
		String sql = "SELECT mem_uid, mem_pwd, mem_name, mem_email, mem_address "
		  		+ "FROM memberT WHERE mem_uid=?";
		try {
			conn = getConnetion();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				member = new MemberBean();
				member.setMem_uid(rs.getString("mem_uid"));
				member.setMem_pwd(rs.getString("mem_pwd"));
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_address(rs.getString("mem_address"));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return member;
	}
	public int updateMember(MemberBean member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE MEMBERT SET mem_pwd=?, mem_email=?, mem_address=? WHERE mem_uid=?";
		int re = -1;
		try {
			conn = getConnetion();
			pstmt = conn.prepareStatement(sql);
			System.out.println("@# getMem_pwd ===>" + member.getMem_pwd());
			System.out.println("@# getMem_email ===>" + member.getMem_email());
			System.out.println("@# getMem_address ===>" + member.getMem_address());
			System.out.println("@# getMem_uid ===>" + member.getMem_uid());
			 pstmt.setString(1, member.getMem_pwd());
	         pstmt.setString(2, member.getMem_email());
	         pstmt.setString(3, member.getMem_address());
	         pstmt.setString(4, member.getMem_uid());
	         re = pstmt.executeUpdate();
			System.out.println("변경성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	}
}
