<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="kdtweb.dao.bbs.Board, kdtweb.beans.BoardDto, java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
   int num = 0;
   int result = 0;
   String mode = request.getParameter("mode");
   
   if(request.getParameter("num") != null){
	   num = Integer.parseInt(request.getParameter("num"));
   }
   String userid = (String) request.getSession().getAttribute("userid");
   Board bbs = new Board();
   try{
	   result = bbs.selectUserId(userid, num);

   }catch(SQLException e){
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
	   
	    <p class="text-center">비밀번호를 입력 하세요. </p>
		<form class="bbspass" action="passok" method="post">
		   <div class="alert alert-danger alert-dismissible fade hide">
              <button type="button" class="close">&times;</button>
              <strong>Warning!</strong> 비밀번호가 틀렸습니다.
           </div>
		
		   <div class="password">
		      <input type="password" name="bbspassword" id="bbspassword" 
		             class="form-control" placeholder="비밀번호" />
		   </div>
		   <button type="reset" class="btn btn-danger"> 취소 </button>
		   <button type="submit" id="submit" class="btn btn-secondary" disabled> 전송 </button>
		   
		</form>
	</div>
   </c:when>
   <c:when test="${result == 1 }">
      <c:if test="${param.bmode =='edit' }">
        <form id="editform" action="bbs.jsp" method="post">
           <input type="hidden" name="mode" value="reedit">
           <input type="hidden" name="num" value="${num }">
           <input type="hidden" name="auth" value="ok">
           <input type="hidden" name="pg" value="${param.pg }">
        </form>
        <script>
          $(function(){
        	 $("#editform").submit(); 
          });
        </script>
      </c:if>
      <c:if test="${param.bmode == 'del' }">
         <script>
           let y = confirm("정말로 삭제하시겠습니까?");
           if(y){
        	   $(function(){
                   $.ajax({
                	   url: 'deleteOk',
                	   type: 'POST',
                	   data: { num: ${num}, auth: "ok"},
                	   success:function(data){
                		   if(data.result == 1){
                			   alert("성공적으로 삭제되었습니다.");
                			   location.href="bbs.jsp";
                		   }else{
                			   alert("데이터를 삭제하는데 문제가 발생했습니다.");
                			   history.go(-1);
                		   }
                	   },
                	   error: function(err){
                		   alert("데이터를 삭제하는데 문제가 발생했습니다.");
                		   history.back();
                	   }
                   })
        		   	
        	   });
           }else{
        	   history.go(-1);
           }
         </script>
      </c:if>
   </c:when>
</c:choose>
<form id="editform" action="bbs.jsp" method="post">
           <input type="hidden" name="mode" value="reedit">
           <input type="hidden" name="num" value="${num }">
           <input type="hidden" name="auth" value="ok">
           <input type="hidden" name="pg" value="${param.pg }">
        </form>   
<script>
$(function(){
    $("#bbspassword").blur(function(){
        const pass = $(this).val();
        $.ajax({
            url: 'passok',
            type: 'POST',
            data: { pass: pass, num: "<%= num %>" },
            success:function(data){
                if(data != 1){
                    $(".alert").removeClass("hide").addClass("show");
                    $('#submit').attr('disabled', true);
                }else{
                    $('#submit').removeClass("btn-secondary")
                                .addClass("btn-success")
                                .attr('disabled', false);
                }
            },
            error: function(err){
                alert("비밀번호를 인증하는데 문제가 발생했습니다.");
                history.back();
            }			
        });
    });

    $(".close").click(function(){
       $(".alert").removeClass("show").addClass("hide");	
    });

    $("#submit").click(function(){
        let mode = $("#bmode").val();
        if(mode == "del"){
        	$.ajax({
        		   url: 'deleteOk',
        		   type: 'POST',
        		   data: { num: ${num}, auth: "ok"},
        		   success:function(data){
        		      // JSON 데이터로 응답받으므로, data.result 값을 참조해야 함
        		      if(data.result == 1){
        		         alert("성공적으로 삭제되었습니다.");
        		         location.href="bbs.jsp";
        		      }else{
        		         alert("데이터를 삭제하는데 문제가 발생했습니다.");
        		         history.go(-1);
        		      }
        		   },
        		   error: function(err){
        		      alert("데이터를 삭제하는데 문제가 발생했습니다.");
        		      history.back();
        		   }
        		});

        } else if(mode == "edit"){
            $("#editform").submit();
        }
    });
});

</script>