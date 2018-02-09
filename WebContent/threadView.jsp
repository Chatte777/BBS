<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter" %>
<%@ page import="threadMaster.ThreadMaster" %>
<%@ page import="threadMaster.ThreadMasterDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="threadReply.ThreadReply" %>
<%@ page import="threadReply.ThreadReplyDAO" %>


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
		
		int threadNo = 0;
		if(request.getParameter("threadNo") != null){
			threadNo = Integer.parseInt(request.getParameter("threadNo"));
		}
		
		if(threadNo == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>"); 
		}
		ThreadMaster threadMaster = new ThreadMasterDAO().getThreadMaster(threadNo);
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
								<td colspan="3"><%= threadMaster.getThreadTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
							</tr>
							<tr>
								<td>작성자</td>
								<td colspan="3"><%= threadMaster.getThreadMakeUser() %></td>
							</tr>
							<tr>
								<td>작성일자</td>
								<td colspan="3"><%= threadMaster.getThreadMakeDt().substring(0,11) + threadMaster.getThreadMakeDt().substring(11,13) + "시" + threadMaster.getThreadMakeDt().substring(14,16)+"분" %></td>
							</tr>
							<tr>
								<td>내용</td>
								<td colspan="3" style="min-height: 200px; text-align: left;"><%=threadMaster.getThreadContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>")%></td>
							</tr>
						</tbody>
				</table>
				
				<table class="table table-striped">
					<tbody>
							<%
									ThreadReplyDAO threadReplyDAO = new ThreadReplyDAO();
									ArrayList<ThreadReply> list = threadReplyDAO.getList(threadNo);
				
									for(int i=0; i<list.size(); i++){
							%>
								<tr>
									<td  align="center"><%= list.get(i).getThreadNo() %></td>
									<td  align="left" style="word-break:break-all;"><%= list.get(i).getReplyContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
									<%
										if(userID!=null && userID.equals(list.get(i).getReplyMakeUser())){
									%>
										<td  align="center">
											<a onclick="return confirm('정말로 삭제하시겠습니까?')" a href="threadReplyDeleteAction.jsp?bbsID=<%=threadNo%>&replyID=<%=list.get(i).getReplyNo() %>" 
												type="button" class="close" aria-label="close">
												<span aria-hidden="true">&times;</span>
											</a>
										</td>
									<%
											}
									%>
									<td style="width:10%;"><%= list.get(i).getReplyMakeUser() %></td>
									<td style="width:15%;"><%= list.get(i).getReplyMakeDt().substring(0,11)+list.get(i).getReplyMakeDt().substring(11,13)+"시"+list.get(i).getReplyMakeDt().substring(14,16)+"분" %></td>
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
										<input type="hidden" name="threadNo" value="<%=threadMaster.getThreadNo()%>">
								</tbody>
						</form>
				</table>
				
				<a href="bbs.jsp" class="btn btn-primary">목록</a>
				<%
					if(userID!=null && userID.equals(threadMaster.getThreadMakeUser())){
				%>
						<a href="update.jsp?bbsID=<%=threadNo%>" class="btn btn-priamry">수정</a>
						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=threadNo%>" class="btn btn-priamry">삭제</a>
				<%
					}
				%>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">

		</div>

	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
</body>
</html>