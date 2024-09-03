<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<jsp:useBean id="connBean" class="kdtweb.dao.KdtwebDao" scope="page"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Connection conn = null;
	try{
		conn = connBean.getConn();
		out.println("데이터 베이스 접속 성공");
	}catch(SQLException e){
		out.println("접속 에러 : "+e.getMessage());
	}finally{
		if(conn !=null){
			try{
				conn.close();
			}catch(SQLException e){
				out.println("커넥션을 닫다가 에러가 발생했습니다");
			}
		}
	}
	
%>
</body>
</html>