package kdtweb.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kdtweb.dao.MySqlConnect;

@WebServlet("/findidok")
public class FindIdOk extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		PrintWriter out = response.getWriter();

		MySqlConnect dbCon = new MySqlConnect();
		String findEmail = request.getParameter("useremail");
		try {
			conn = dbCon.getConn();
			String sql = "select userid from members where useremail = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, findEmail);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String alert = "<script>alert('아이디는" + rs.getString("userid") + "'); location.href='index.jsp';</script>'";
				out.println(alert);
			} else {
				String alert = "<script>alert('일치하는 아이디가 없습니다.'); location.href='index.jsp';</script>'";
				out.println(alert);
			}

		} catch (SQLException | ClassNotFoundException e) {
			System.out.println("db 접속 에러 " + e.getMessage());

		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {

				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {

				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

				}
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
