package kdtweb.forms;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/viewcookie")
public class ViewCookie extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		Cookie[] cookies = request.getCookies();
		if ((cookies != null) && (cookies.length) > 0) {
			for (int i = 0; i < cookies.length; i++) {
				if(cookies[i].getName().equals("name")) {
					cookies[i].setMaxAge(0);
					response.addCookie(cookies[i]);
				}
				out.println(cookies[i].getName() + ": ");
				out.println(cookies[i].getValue() + "<br>");
			}
		}else {
			out.println("쿠키가 없음");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
