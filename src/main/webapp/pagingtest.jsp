<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="kdtweb.util.Paging"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
//Paging(int totalRecords, int recordsPerPage, int currentPage, int pagesPerGroup)
int totalRecords = 2498;
int recordsPerPage = 14;
int pagesPerGroup = 12;
int currentPage = 1;
int limit = (currentPage - 1) * recordsPerPage;

if (request.getParameter("pg") != null) {
	currentPage = Integer.parseInt(request.getParameter("pg"));
}

Paging paging = new Paging(totalRecords, recordsPerPage, currentPage, pagesPerGroup);
request.setAttribute("paging", paging);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h1 class="my-5 py-5 text-center">select * from bbs_bbs order by
			num desc limit ${limit }, 16;</h1>
		<ul class="pagination">
			<!-- 이전그룹 -->
			<c:if test="${paging.StartPageOfGroup>1 }">
				<li class="page-item"><a class="page-link" href="#">Previous</a></li>
			</c:if>
			<c:forEach var="i" begin="${paging.startPageOfGroup }"
				end="${paging.endPageOfGroup }">
				<li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
					<a class="page-link" href="">${i}</a>
				</li>

			</c:forEach>
			<!-- 다음그룹 -->
			<c:if test="${paging.endPageOfGroup < paging.totalPages }">
				<li class="page-item"><a class="page-link" href="#">Next</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>