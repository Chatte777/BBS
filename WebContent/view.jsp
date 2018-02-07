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
	
	
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collpased"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>				
			</button>
		
			<a class="navbar-brand" href="main.jsp">DREAMY CAT</a>
		</div>
		
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			
			<%
				if(userID==null){
			%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul>
					</li>
				</ul>
			<%	
				} else {
			%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul>
					</li>
				</ul>
			<%	
				}
			%>
			
		</div>
	</nav>
	
	<div class="container">
		<div class="row">

				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
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
										<td style="width:5%;" align="center"><%= list.get(i).getReplyID() %></td>
										<td style="width:65%;" align="left"><%= list.get(i).getReplyContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
										<%
											if(userID!=null && userID.equals(list.get(i).getUserID())){
										%>
										<td style="width:5%;" align="center">
											<a onclick="return confirm('정말로 삭제하시겠습니까?')" a href="replyDeleteAction.jsp?bbsID=<%=bbsID%>&replyID=<%=list.get(i).getReplyID() %>" 
												type="button" class="close" aria-label="close">
												<span aria-hidden="true">&times;</span>
											</button>
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
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>