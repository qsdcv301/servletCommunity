package kdtweb.dao.members;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kdtweb.beans.User;
import kdtweb.dao.KdtwebDao;

public class UpdateMem {
	   //필드로 접속객체를 생성	
	   private KdtwebDao dao = new KdtwebDao();
	   private CloseResource reso = new CloseResource();
	   private Connection conn = null;
	   private PreparedStatement pstmt = null;
	
	   public int updateMember(User user) throws SQLException {
		    int rs = 0;

		    StringBuilder sql = new StringBuilder("UPDATE members SET ");
		    boolean firstField = false;

		    if (user.getUserpass() != null && !user.getUserpass().isEmpty()) {
		        sql.append("userpass=?");
		        firstField = true;
		    }
		    if (user.getUsername() != null && !user.getUsername().isEmpty()) {
		        if (firstField) sql.append(", ");
		        sql.append("username=?");
		        firstField = true;
		    }
		    if (user.getUseremail() != null && !user.getUseremail().isEmpty()) {
		        if (firstField) sql.append(", ");
		        sql.append("useremail=?");
		        firstField = true;
		    }
		    if (user.getUsertel() != null && !user.getUsertel().isEmpty()) {
		        if (firstField) sql.append(", ");
		        sql.append("usertel=?");
		        firstField = true;
		    }
		    if (user.getUserpost() != 0) {
		        if (firstField) sql.append(", ");
		        sql.append("userpost=?");
		        firstField = true;
		    }
		    if (user.getUseraddr1() != null && !user.getUseraddr1().isEmpty()) {
		        if (firstField) sql.append(", ");
		        sql.append("useraddr1=?");
		        firstField = true;
		    }
		    if (user.getUseraddr2() != null && !user.getUseraddr2().isEmpty()) {
		        if (firstField) sql.append(", ");
		        sql.append("useraddr2=?");
		        firstField = true;
		    }
		    if (user.getUseraddrexc() != null && !user.getUseraddrexc().isEmpty()) {
		        if (firstField) sql.append(", ");
		        sql.append("useraddrexc=?");
		        firstField = true;
		    }
		    if (user.getGrade() != 0) {
		    	if (firstField) sql.append(", ");
		        sql.append("grade=?");
		        firstField = true;
		    }

		    if (!firstField) {
		        return 0;
		    }
		    
		    sql.append(" WHERE userid=?");

		    try {
		        conn = this.dao.getConn();
		        pstmt = conn.prepareStatement(sql.toString());

		        int index = 1;

		        if (user.getUserpass() != null && !user.getUserpass().isEmpty()) {
		            pstmt.setString(index++, user.getUserpass());
		        }
		        if (user.getUsername() != null && !user.getUsername().isEmpty()) {
		            pstmt.setString(index++, user.getUsername());
		        }
		        if (user.getUseremail() != null && !user.getUseremail().isEmpty()) {
		            pstmt.setString(index++, user.getUseremail());
		        }
		        if (user.getUsertel() != null && !user.getUsertel().isEmpty()) {
		            pstmt.setString(index++, user.getUsertel());
		        }
		        if (user.getUserpost() != 0) {
		            pstmt.setInt(index++, user.getUserpost());
		        }
		        if (user.getUseraddr1() != null && !user.getUseraddr1().isEmpty()) {
		            pstmt.setString(index++, user.getUseraddr1());
		        }
		        if (user.getUseraddr2() != null && !user.getUseraddr2().isEmpty()) {
		            pstmt.setString(index++, user.getUseraddr2());
		        }
		        if (user.getUseraddrexc() != null && !user.getUseraddrexc().isEmpty()) {
		            pstmt.setString(index++, user.getUseraddrexc());
		        }
		        if (user.getGrade() != 0) {
		            pstmt.setInt(index++, user.getGrade());
		        }

		        pstmt.setString(index, user.getUserid());

		        rs = pstmt.executeUpdate();

		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        reso.closeResource(conn, pstmt);
		    }

		    return rs;
		}
}
