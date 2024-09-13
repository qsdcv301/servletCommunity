<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="kdtweb.dao.bbs.Board, kdtweb.beans.BoardDto, java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%
  String stringNum = request.getParameter("num");
  if(stringNum != null && !stringNum.isEmpty()){
  long num = Long.parseLong(stringNum);
  
  int currentPage = 1;
  if(request.getParameter("pg") != null) {
	  currentPage = Integer.parseInt(request.getParameter("pg"));
  }
  
  BoardDto boardView = null;
  Board bbs = new Board();
  try{
	 bbs.updateCount(num); 
	 boardView = bbs.viewBoard(num);
  }catch(SQLException e){
	  e.printStackTrace();
  }
  request.setAttribute("currentPage", currentPage);
  request.setAttribute("boardView", boardView);
%>
<section class="view">
   <div class="view-box">
   	<div class="view-head">
   	   <i class="ri-arrow-right-circle-fill"></i> 
   	   ${boardView.title }
   	</div>
   	<div class="view-body">
       <div class="contents-box">
           <div class="wdate"><i class="ri-calendar-2-line"></i> ${boardView.wdate }</div>
           <div class="writer"><i class="ri-user-voice-line"></i>${boardView.writer }</div>
           <div class="count"><i class="ri-anticlockwise-2-line"></i> ${boardView.count }</div>          
       </div>
       <div class="contents">
            <p>학교교육 및 평생교육을 포함한 교육제도와 그 운영, 교육재정 및 교원의 지위에 관한 기본적인 사항은 법률로 정한다. 국가는 대외무역을 육성하며, 이를 규제·조정할 수 있다.</p>
            <p>국가는 지역간의 균형있는 발전을 위하여 지역경제를 육성할 의무를 진다. 대한민국은 민주공화국이다. 이 헌법에 의한 최초의 대통령의 임기는 이 헌법시행일로부터 개시한다.</p>
       </div>
    </div>
   	<div class="view-foot">
       <a href="?mode=list&pg=${currentPage }" class="btn btn-success mr-2">목록</a>
       <a href="?mode=pass&bmode=edit&num=${boardView.num }&pg=${currentPage}" class="btn btn-warning mr-2">수정</a>
       <a href="?mode=pass&bmode=del&num=${boardView.num }&pg=${currentPage}" class="btn btn-danger mr-2">삭제</a>
       <a href="?mode=write&pg=${currentPage }" class="btn btn-success">글쓰기</a>
    </div>
   </div>
</section>

<% }else{ %>
  <script>
   alert("이런식으로 하기야?");
   location.history.go(-1);
  </script>
<%	  
  }
%>