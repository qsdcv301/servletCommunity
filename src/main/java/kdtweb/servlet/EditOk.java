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

import kdtweb.beans.User;
import kdtweb.dao.members.UpdateMem;

@WebServlet("/editok")
public class EditOk extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		int postcode = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String userid = request.getParameter("usrid");
		String userpass = request.getParameter("usrpass");
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		String userpost = request.getParameter("postcode");
		if (userpost != null) {
			postcode = Integer.parseInt(userpost);
		}
		String useraddr1 = request.getParameter("useraddr1");
		String useraddr2 = request.getParameter("useraddr2");
		String useraddrexc = request.getParameter("useraddrexc");

		User user = new User();
		user.setUserid(userid);
		user.setUserpass(userpass);
		user.setUsername(username);
		user.setUseremail(email);
		user.setUsertel(tel);
		user.setUserpost(postcode);
		user.setUseraddr1(useraddr1);
		user.setUseraddr2(useraddr2);
		user.setUseraddrexc(useraddrexc);
		UpdateMem mem = new UpdateMem();

		try {
			int ct = mem.updateMember(user);
			if (ct > 0) {
				out.println("<p>회원 정보가 성공적으로 수정되었습니다.</p>");
			} else {
				out.println("<p>회원 정보 수정에 실패했습니다.</p>");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			out.println("<p>회원 정보 수정 중 오류가 발생했습니다.</p>");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
