package kdtweb.forms;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kdtweb.beans.User;


@WebServlet("/register")
public class RegisterResult extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		User user = new User();
		
		user.setUserid(request.getParameter("userid"));
		user.setUserpass(request.getParameter("userpass"));
		user.setUsername(request.getParameter("username"));
		user.setUseremail(request.getParameter("useremail"));
		user.setUsertel(request.getParameter("usertel"));
		user.setUserpost(Integer.parseInt(request.getParameter("post")));
		user.setUseraddr1(request.getParameter("addr1"));
		user.setUseraddr2(request.getParameter("addr2"));
		user.setUseraddrexc(request.getParameter("addrexc"));
		out.println("<html><head></head><body>");
		out.println("<h1>임시 데이터 테스트</h1>");
		out.println("<p> 아이디 : "+user.getUserid()+"</p>");
		out.println("<p> 비밀번호 : "+user.getUserpass()+"</p>");
		out.println("<p> 이름 : "+user.getUsername()+"</p>");
		out.println("<p> 이메일 : "+user.getUseremail()+"</p>");
		out.println("<p> 전화번호 : "+user.getUsertel()+"</p>");
		out.println("<p> 우편번호 : "+user.getUserpost()+"</p>");
		out.println("<p> 주소 : "+user.getUseraddr1()+"</p>");
		out.println("<p> 상세주소 : "+user.getUseraddr2()+"</p>");
		out.println("<p> 참고항목 : "+user.getUseraddrexc()+"</p>");
		out.println("</body></html>");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
