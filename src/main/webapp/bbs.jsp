<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%
   String mode = "list";
   if(request.getParameter("mode")!=null && !request.getParameter("mode").isEmpty()){
	   mode = request.getParameter("mode");
   }
   mode= "/bbs/"+mode+".jsp";
%>    
<%@ include file="include/header.jsp" %>
   <div class="bg-white bbs">
      <jsp:include page="<%=mode %>"/>
   </div>
     

<%@ include file="include/footer.jsp" %>