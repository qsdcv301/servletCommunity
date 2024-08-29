package kdtweb.forms;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/createcookie")
public class CreateCookie extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		Cookie myCookie1 = new Cookie("name", "홍길동");
		Cookie myCookie2 = new Cookie("nation", "자연");
		Cookie myCookie3 = new Cookie("age", "11");
		myCookie1.setMaxAge(60*60);
		myCookie2.setMaxAge(60*60);
		myCookie3.setMaxAge(60*60);
		response.addCookie(myCookie1);
		response.addCookie(myCookie2);
		response.addCookie(myCookie3);
		
		out.println("쿠키가 생성됨");
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
