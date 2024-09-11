<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="kdtweb.dao.bbs.Board, kdtweb.beans.BoardDto, java.sql.*, java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
Board bbs = new Board();
ArrayList<BoardDto> boardList = null;
//try {
	//boardList = bbs.listBoard();
//} catch (SQLException e) {
//	e.printStackTrace();
//}
int pageGroup = 5; // 최대 5개의 페이지 그룹 생성 초과분 next로 이동
int listView = 10; // 한개의 페이지에 보여질 목록 수
int totalPosts = boardList.size(); // 페이지의 총 갯수
int totalPages = (int) Math.ceil((double) totalPosts / listView); // 전체 페이지 수

//현재 페이지 처리 (쿼리 파라미터로 받기)
int currentPage = 1; // 기본 페이지 번호
String pageParam = request.getParameter("currentPage");
if (pageParam != null && !pageParam.isEmpty()) {
	currentPage = Integer.parseInt(pageParam);
}

//현재 페이지 그룹의 시작 페이지 번호 계산
int groupStartPage = ((currentPage - 1) / pageGroup) * pageGroup + 1;
//현재 페이지 그룹의 마지막 페이지 번호 계산
int groupEndPage = Math.min(groupStartPage + pageGroup - 1, totalPages);

//게시글 자르기 (startPageIndex ~ endPageIndex까지 잘라서 보여줌)
int startPageIndex = (currentPage - 1) * listView; // 건너뛸 데이터 수
int endPageIndex = Math.min(startPageIndex + listView, totalPosts); // 끝 인덱스 계산

//버튼을 누를때 마다 작동
List<BoardDto> pageView = boardList.subList(startPageIndex, endPageIndex);
request.setAttribute("pageView", pageView);
request.setAttribute("currentPage", currentPage);
request.setAttribute("totalPages", totalPages);
request.setAttribute("groupStartPage", groupStartPage);
request.setAttribute("groupEndPage", groupEndPage);
request.setAttribute("listView", listView);
%>
<h1 class="text-center mb-5">게시판</h1>
<table class="bbslist table-hover">
	<colgroup>
		<col width="10%">
		<col width="50%">
		<col width="15%">
		<col width="15%">
		<col width="10%">
	</colgroup>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="post" items="${pageView}">
			<tr>
				<td>${post.num}</td>
				<td class="ellipsis"><a
					href="bbs.jsp?mode=view&num=${post.num}">${post.title}</a></td>
				<td class="ellipsis">${post.writer}</td>
				<td>${post.viewDate}</td>
				<td>${post.count}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div class="text-right my-5 px-5">
	<a href="?mode=write" class="btn btn-success">글쓰기</a>
</div>

<!-- 페이지네이션 -->
<div class="d-flex justify-content-center">
	<ul class="pagination">
		<!-- Previous 버튼 -->
		<li class="page-item ${groupStartPage > 1 ? '':'disabled'}"><a
			class="page-link"
			href="?currentPage=${groupStartPage - 1}&size=${listView}">Previous</a>
		</li>
		<!-- 페이지 번호 출력 -->
		<c:forEach var="i" begin="${groupStartPage}" end="${groupEndPage}">
			<li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
				<a class="page-link" href="?currentPage=${i}&size=${listView}">${i}</a>
			</li>
		</c:forEach>

		<!-- Next 버튼 -->
		<li class="page-item ${groupEndPage < totalPages ? '':'disabled'}">
			<a class="page-link"
			href="?currentPage=${groupEndPage + 1}&size=${listView}">Next</a>
		</li>
	</ul>
</div>
<script>
	
</script>