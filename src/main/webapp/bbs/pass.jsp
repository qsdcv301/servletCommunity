<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="kdtweb.dao.bbs.Board, kdtweb.beans.BoardDto, java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
int num = 0;
int result = 0;
String mode = request.getParameter("mode");

if (request.getParameter("num") != null) {
	num = Integer.parseInt(request.getParameter("num"));
}
String userid = (String) request.getSession().getAttribute("userid");
Board bbs = new Board();
try {
	result = bbs.selectUserId(userid, num);

} catch (SQLException e) {
	e.printStackTrace();
}
request.setAttribute("num", num);
request.setAttribute("result", result);
%>

<c:choose>
	<c:when test="${num == 0 }">
		<script>
			alert("오류가 발생했습니다.");
			history.back();
		</script>
	</c:when>
	<c:when test="${sessionScope.userid==null || result == 0}">
		<div class="pass-box">

			<p class="text-center">비밀번호를 입력 하세요.</p>
			<form class="bbspass" action="bbspassok" method="post">
				<div class="password">
					<input type="password" name="bbspassword" id="bbspassword"
						class="form-control" placeholder="비밀번호" />
				</div>
				<button type="reset" class="btn btn-danger">수정</button>
				<button type="submit" class="btn btn-success">전송</button>

			</form>
		</div>
	</c:when>
	<c:when test="${result == 1 }">
		<c:if test="${param.mode =='edit' }">
			<form id="editform" action="bbs.jsp" method="post">
				<input type="hidden" name="mode" value="edit" />
				 <input type="hidden" name="num" value="${num }" />
				  <input type="hidden" name="auth" value="ok" /> 
				  <input type="hidden" name="pg" value="${param.pg }" />
			</form>
			<script>
				$(function() {
					$("#editform").submit();
				});
			</script>
		</c:if>
		<c:if test="${param.mode =='del' }">
	델
	</c:if>
	</c:when>
</c:choose>
