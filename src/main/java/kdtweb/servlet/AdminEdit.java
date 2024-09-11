package kdtweb.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kdtweb.beans.User;
import kdtweb.dao.members.DeleteMem;
import kdtweb.dao.members.UpdateMem;

@WebServlet("/adminedit")
public class AdminEdit extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String userid = request.getParameter("id");
		int lv = Integer.parseInt(request.getParameter("lv"));

		User user = new User();
		user.setUserid(userid);
		user.setGrade(lv);
		UpdateMem updateMem = new UpdateMem();
		DeleteMem deleteMem = new DeleteMem();
		if (lv == 99) {
			try {
				int ct = deleteMem.deleteMem(userid);
				if (ct > 0) {
					out.write("99");
				} else {
					out.write("0");
				}
			} catch (SQLException e) {
				e.printStackTrace();
				out.write("0");
			}
		} else {
			try {
				int ct = updateMem.updateMember(user);
				if (ct > 0) {
					out.write("1");
				} else {
					out.write("0");
				}
			} catch (SQLException e) {
				e.printStackTrace();
				out.write("0");
			}
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
