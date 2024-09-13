<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="kdtweb.dao.bbs.Board, 
            kdtweb.beans.BoardDto, 
            kdtweb.util.Paging, 
            java.sql.*, 
            java.util.*,
            java.net.URLEncoder" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<%
  request.setCharacterEncoding("UTF-8");
  int totalRecords = 0;
  int recordsPerPage = 10;
  int pagesPerGroup = 10;
  int currentPage = 1;
  
  if(request.getParameter("pg") != null) {
     currentPage = Integer.parseInt(request.getParameter("pg"));
  }
  
  String searchKey = request.getParameter("searchKey");
  String searchVal = request.getParameter("searchVal");
  
  String encodeSearchKey = (searchKey != null)? URLEncoder.encode(searchKey, "UTF-8"):"title";
  String encodeSearchVal = (searchVal != null)? URLEncoder.encode(searchVal, "UTF-8"):"";
  
   int limit = (currentPage - 1) * recordsPerPage;
  
   Board bbs = new Board();
   ArrayList<BoardDto> boardList = null;
   try{
   if(searchKey != null && !searchKey.isEmpty()){
       totalRecords = bbs.getSearchBoardCount(searchKey, searchVal); 
       boardList = bbs.listSearchBoard(searchKey, searchVal, limit, recordsPerPage); 
   }else{
        totalRecords = bbs.getTotalBoardCount();
         boardList = bbs.listBoard(limit, recordsPerPage);
   }
   }catch(SQLException e){
      e.printStackTrace();
   }
   
   Paging paging = new Paging(totalRecords, recordsPerPage, currentPage, pagesPerGroup);
   request.setAttribute("paging", paging);
   request.setAttribute("boardList", boardList);
   request.setAttribute("encodeSearchKey", encodeSearchKey);
   request.setAttribute("encodeSearchVal", encodeSearchVal);
%>
<h1 class="text-center mb-5">
   게시판
</h1>
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
        <c:forEach var="post" items="${boardList }">
        <!-- 루프 -->
        <tr>
           <td class="text-center">${post.num }</td>
           <td class="ellipsis"><a href="bbs.jsp?mode=view&num=${post.num}&pg=${paging.currentPage}">${post.title }</a> </td>
           <td class="ellipsis text-center">${post.writer }</td>
           <td class="text-center">${post.viewDate }</td>
           <td class="text-center">${post.count }</td>
        </tr>
        <!-- /루프 -->
        </c:forEach>
      </tbody>
   </table>

   <div class="search-and-button">
      <div class="col-md-5 searchbox">
           <form id="searchForm" name="searchForm" method="get">
         <div class="input-group mt-3 mb-3">
           <div class="input-group-prepend">
             <button type="button" class="btn btn-outline-secondary dropdown-toggle" 
             data-toggle="dropdown" id="searchtext">제목검색
             </button>
             
             <div class="dropdown-menu">
               <a class="dropdown-item" href="#" data-search="title"> 제목검색 </a>
               <a class="dropdown-item" href="#" data-search="writer"> 이름검색 </a>
               <a class="dropdown-item" href="#" data-search="contents"> 내용검색 </a>
             </div>
           </div>
           <input type="text" class="form-control" name="searchVal" id="searchInput" placeholder="검색어 입력">
           <input type="hidden" id="searchKey" name="searchKey" value="title">
           
           <div class="input-group-append">
                 <button class="btn btn-success" id="searchSubmit" type="submit">검색</button>
              </div>
         </div>
          </form>
       </div>
      <div class="col-md-7 text-right">
        <a href="bbs.jsp" class="btn btn-success">목록</a>  
        <a href="?mode=write" class="btn btn-success">글쓰기</a>
      </div>
   </div>
      <ul class="pagination justify-content-center">
        <li class="page-item"><a class="page-link bg-light" href="?pg=1&searchKey=${encodeSearchKey}&searchVal=${encodeSearchVal}"><i class="ri-arrow-left-double-line"></i></a></li>
   <!-- 이전그룹 -->
   <c:if test="${paging.startPageOfGroup > 1 }">
     <li class="page-item"><a class="page-link" href="?pg=${paging.startPageOfGroup - 1 }&searchKey=${encodeSearchKey}&searchVal=${encodeSearchVal}"><i class="ri-arrow-left-s-line"></i></a></li>
   </c:if>  
   
   <c:forEach var="i" begin="${paging.startPageOfGroup }" end="${paging.endPageOfGroup}">
      <li class='page-item <c:if test="${ i == paging.currentPage}">active</c:if>'><a class="page-link" href="?pg=${i}&searchKey=${encodeSearchKey}&searchVal=${encodeSearchVal}">${i }</a></li>
   </c:forEach>  
     
     
    <!-- 다음그룹 -->
   <c:if test="${paging.endPageOfGroup < paging.totalPages }">  
     <li class="page-item"><a class="page-link" href="?pg=${paging.endPageOfGroup + 1}&searchKey=${encodeSearchKey}&searchVal=${encodeSearchVal}"><i class="ri-arrow-right-s-line"></i></a></li>
   </c:if>  
   <li class="page-item"><a class="page-link bg-light" href="?pg=${paging.totalPages }&searchKey=${encodeSearchKey}&searchVal=${encodeSearchVal}"><i class="ri-arrow-right-double-line"></i></a></li>
   </ul>
   
   <script>
   $(function(){
      $(".dropdown-item").click(function(e){
         e.preventDefault();
         const selectedText = $(this).text();
         const selectedKey = $(this).data("search");
         $("#searchKey").val(selectedKey);
         $("#searchtext").text(selectedText);
      });
      
      $("#searchForm").submit(function(){
         const keyword = $("#searchInput").val().trim();
         if(keyword === ""){
            alert("검색어를 입력하세요.");
            $("#searchInput").focus();
            return false;
         }
      });
   });
   </script>