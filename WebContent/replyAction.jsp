<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "reply.ReplyDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<jsp:useBean id="reply" class="reply.Reply" scope="page"/> 
<jsp:setProperty name="bbs" property="bbsID"/>
<jsp:setProperty name="reply" property="replyContent"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DREAMY CAT</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else{
			if(reply.getReplyContent()==null){
				
			} else {
				ReplyDAO replyDAO = new ReplyDAO();
				int result = replyDAO.write(bbs.getBbsID(), userID, reply.getReplyContent());
				
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else
				{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='view.jsp?bbsID=" + bbs.getBbsID() + "'");
					script.println("</script>");
				}
		}
		
		
		}
	

			
	%>
</body>
</html>









