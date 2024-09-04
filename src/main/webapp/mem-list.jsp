<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="kdtweb.beans.User, java.util.*, java.sql.*" %>
<%@ include file="include/header.jsp" %>
<jsp:useBean id="memlist" class="kdtweb.dao.members.SelectMem" scope="page" />
<%
  List<User> userList = null;
  try{
      userList = memlist.selectMem();
  }catch(SQLException e){
	   out.println("에러가 발생했습니다. "+ e.getMessage());        	   
  }
%>
<script src="js/photo-gallery.js"></script>

    <div class="row">
           <div class="col-12">
               <div class="bg-white rg p-5">
                   <h1 class="text-center py-5">회원 관리</h1>
                   <p class="text-danger text-center pb-5">관리자 모드 입니다.</p>
                   <table class="table table-bordered">
                      <thead>
                         <tr>
                            <th>번호</th>
                            <th>아이디</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>주소</th>
                            <th>가입일</th>
                            <th>회원등급</th>
                         </tr>
                      </thead>  
                      <tbody>
       <%
            String[] memLevel = {"일반회원","특별회원","운영자"};
            if(userList != null && !userList.isEmpty()){
            for(User user : userList){
       %>       
       <tr>
            <td><%=user.getId() %></td>
            <td><%=user.getUserid() %></td>
            <td><%=user.getUsername() %></td>
            <td><%=user.getUseremail() %></td>
            <td><%=user.getUsertel() %></td>
            <td>(<%=user.getUserpost() %>)
                <%=user.getUseraddr1() %>
                <%=user.getUseraddr2() %>
                <%=user.getUseraddrexc() %></td>
            <td><%=user.getRdate()%></td>
            <td><%=memLevel[user.getGrade()-1]%></td>
       </tr>
       <%
           } 
           }
       %>               </tbody>                       
                   </table>
               </div>
           </div>    
     </div>
   <%@ include file="include/footer.jsp" %>
</body>
</html>
  