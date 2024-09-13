package kdtweb.servlet.bbs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kdtweb.dao.bbs.Board;


@WebServlet("/deleteOk")
public class DeleteOk extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       PrintWriter out = response.getWriter();
       response.setContentType("application/json; charset=utf-8");
       response.setCharacterEncoding("utf-8");
       
       Board bbs = new Board();
       long num = 0;
       int res = 0;
       String strNum = request.getParameter("num");
       if(strNum != null && !strNum.isEmpty()) {
    	   num = Long.parseLong(strNum);
       }
       String auth = request.getParameter("auth");
              
       if(!"ok".equals(auth)) {
    	  String goOut = "<script>alert('정상적이지 않은 방법으로 접근하셨습니다.');location.href='bbs.jsp';</script>";  
          out.println(goOut);
       }
       try {
    	  res = bbs.deleteBoard(num);
       }catch(SQLException e) {}
       
       String result = "{\"result\" : "+res+"}";
       out.println(result);
       out.flush();
       out.close();
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
