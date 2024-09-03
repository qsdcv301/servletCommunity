package kdtweb.dao.members;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kdtweb.beans.User;
import kdtweb.dao.KdtwebDao;

public class SelectOneMem {
	// 필드로 접속객체를 생성
	private KdtwebDao dao = new KdtwebDao();
	private CloseResource reso = new CloseResource();
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	public int SelectOneMem(String userid) throws SQLException {
		int res = 0;

		return res;
	}

	public int SelectOneMem(String userid, String userpass) throws SQLException {
		int res = 0;
		String sql = "select * from members where userid=? and userpass=?";
		try {
			conn = this.dao.getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, userpass);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			reso.CloseResource(conn, pstmt, rs);
		}

		return res;
	}
}
