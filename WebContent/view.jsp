<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="reply.Reply" %>
<%@ page import="reply.ReplyDAO" %>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>DREAMY CAT</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>"); 
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>
	
	
	<jsp:include page="_headNav.jsp" flush="false"/>
	
	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; word-break:break-all;">
					<thead>
						<tr>
							<th colspan="4" style="background-color: #eeeeee; text-align: center;">게시판 글</th>
						</tr>
					</thead>
					
					<tbody>
							<tr>
								<td style="width: 20%;">글제목</td>
								<td colspan="3"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
							</tr>
							<tr>
								<td>작성자</td>
								<td colspan="3"><%= bbs.getUserID() %></td>
							</tr>
							<tr>
								<td>작성일자</td>
								<td colspan="3"><%= bbs.getBbsDate().substring(0,11)+bbs.getBbsDate().substring(11,13)+"시"+bbs.getBbsDate().substring(14,16)+"분" %></td>
							</tr>
							<tr>
								<td>내용</td>
								<td colspan="3" style="min-height: 200px; text-align: left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>")%></td>
							</tr>
						</tbody>
				</table>
				
				<table class="table table-striped">
					<tbody>
							<%
									ReplyDAO replyDAO = new ReplyDAO();
									ArrayList<Reply> list = replyDAO.getList(bbsID);
				
									for(int i=0; i<list.size(); i++){
							%>
								<tr>
									<td  align="center"><%= list.get(i).getReplyID() %></td>
									<td  align="left" style="word-break:break-all;"><%= list.get(i).getReplyContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
									<%
										if(userID!=null && userID.equals(list.get(i).getUserID())){
									%>
										<td  align="center">
											<a onclick="return confirm('정말로 삭제하시겠습니까?')" a href="replyDeleteAction.jsp?bbsID=<%=bbsID%>&replyID=<%=list.get(i).getReplyID() %>" 
												type="button" class="close" aria-label="close">
												<span aria-hidden="true">&times;</span>
											</a>
										</td>
									<%
											}
									%>
									<td style="width:10%;"><%= list.get(i).getUserID() %></td>
									<td style="width:15%;"><%= list.get(i).getReplyDate().substring(0,11)+list.get(i).getReplyDate().substring(11,13)+"시"+list.get(i).getReplyDate().substring(14,16)+"분" %></td>
								</tr>
							<%
								}
							%>
					</tbody>
				</table>
			</div>
				
				<table class="table table-condensed">
						<form method="post" action="replyAction.jsp">
								<tbody>
										<td style="width:90%;"><input type="text" class="form-control" palceholder="댓글" name="replyContent" maxlength="2048" style="height: 150px;"></td>
										<td style="width:10%; vertical-align:bottom;" align="center">
											<input type="submit" class="btn btn-primary pull-right" value="댓글작성">
										</td>
										<input type="hidden" name="bbsID" value="<%=bbs.getBbsID()%>">
								</tbody>
						</form>
				</table>
				
				<a href="bbs.jsp" class="btn btn-primary">목록</a>
				<%
					if(userID!=null && userID.equals(bbs.getUserID())){
				%>
						<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-priamry">수정</a>
						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-priamry">삭제</a>
				<%
					}
				%>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">

		</div>

	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
	
	
	
	
	
	