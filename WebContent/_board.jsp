<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="container">
	<div class="row">
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">댓글</th>
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">작성자</th>
					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
				</tr>
			</thead>

			<tbody>
				<%
					String boardName = request.getParameter("boardName");
				
					String userId = null;
					if(session.getAttribute("userID") != null){
						userId = (String)session.getAttribute("userID");
					}
				
					int pageNumber = 1;
						if(request.getParameter("pageNumber") != null){
							pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
						}
				
					BoardDAO boardDAO = new BoardDAO(boardName);
					ArrayList<BoardVO> list = null; //boardDAO.getList(pageNumber, userId);
					
					for(int i=0; i<list.size(); i++){
						int replyCnt = boardDAO.getReplyCnt(list.get(i).getBoardNo());
						int replyColorFlag = boardDAO.getReplyColor(list.get(i).getBoardNo());
				%>
				<tr>
					<td <%
							if(replyColorFlag==1){%> style="color: #873286;" <%}
							else if(replyColorFlag==2){%> style="color:#DE2A45;" <%}
							else if(replyColorFlag==3){%> style="color:#F5762C;" <%}
							else if(replyColorFlag==4){%> style="color:#10BF00;" <%}
							else if(replyColorFlag==5){%> style="color:#2865BF;" <%}
							else if(replyColorFlag==6){%> style="color:black;" <%}
						%>>
						<%if(replyCnt!=0){%><%=replyCnt%>
						<%}%>
					</td>
					<td><a href="<%=boardName%>View.jsp?<%=boardName%>No=<%= list.get(i).getBoardNo() %>"><%= list.get(i).getBoardTitle() %></a></td>
					<td><%= list.get(i).getBoardMakeUser() %></td>
					<td><%= list.get(i).getBoardMakeDt().substring(0,11)+list.get(i).getBoardMakeDt().substring(11,13)+"시"+list.get(i).getBoardMakeDt().substring(14,16)+"분" %></td>
				</tr>
				<%
					}				
				%>
			</tbody>
		</table>

		<%
				if(pageNumber!= 1){
			%>
		<a href="<%=boardName%>.jsp?boardName=<%=boardName%>&pageNumber=<%=pageNumber-1%>" class="btn btn-successs btn-arrow-left">이전</a>
		<%
				} if(boardDAO.nextPage(pageNumber+1)) {
			%>
		<a href="<%=boardName%>.jsp?boardName=<%=boardName%>&pageNumber=<%=pageNumber+1%>" class="btn btn-successs btn-arrow-right">다음</a>
		<%
				}
			%>

		<a href="<%=boardName%>Write.jsp?boardName=<%=boardName%>" class="btn btn-primary pull-right">글쓰기</a>
	</div>
</div>

</body>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="container">
	<div class="row">
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">댓글</th>
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">작성자</th>
					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
				</tr>
			</thead>

			<tbody>
				<%
					String boardName = request.getParameter("boardName");
				
					String userId = null;
					if(session.getAttribute("userID") != null){
						userId = (String)session.getAttribute("userID");
					}
				
					int pageNumber = 1;
						if(request.getParameter("pageNumber") != null){
							pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
						}
				
					BoardDAO boardDAO = new BoardDAO(boardName);
					ArrayList<BoardVO> list = null; //boardDAO.getList(pageNumber, userId);
					
					for(int i=0; i<list.size(); i++){
						int replyCnt = boardDAO.getReplyCnt(list.get(i).getBoardNo());
						int replyColorFlag = boardDAO.getReplyColor(list.get(i).getBoardNo());
				%>
				<tr>
					<td <%
							if(replyColorFlag==1){%> style="color: #873286;" <%}
							else if(replyColorFlag==2){%> style="color:#DE2A45;" <%}
							else if(replyColorFlag==3){%> style="color:#F5762C;" <%}
							else if(replyColorFlag==4){%> style="color:#10BF00;" <%}
							else if(replyColorFlag==5){%> style="color:#2865BF;" <%}
							else if(replyColorFlag==6){%> style="color:black;" <%}
						%>>
						<%if(replyCnt!=0){%><%=replyCnt%>
						<%}%>
					</td>
					<td><a href="<%=boardName%>View.jsp?<%=boardName%>No=<%= list.get(i).getBoardNo() %>"><%= list.get(i).getBoardTitle() %></a></td>
					<td><%= list.get(i).getBoardMakeUser() %></td>
					<td><%= list.get(i).getBoardMakeDt().substring(0,11)+list.get(i).getBoardMakeDt().substring(11,13)+"시"+list.get(i).getBoardMakeDt().substring(14,16)+"분" %></td>
				</tr>
				<%
					}				
				%>
			</tbody>
		</table>

		<%
				if(pageNumber!= 1){
			%>
		<a href="<%=boardName%>.jsp?boardName=<%=boardName%>&pageNumber=<%=pageNumber-1%>" class="btn btn-successs btn-arrow-left">이전</a>
		<%
				} if(boardDAO.nextPage(pageNumber+1)) {
			%>
		<a href="<%=boardName%>.jsp?boardName=<%=boardName%>&pageNumber=<%=pageNumber+1%>" class="btn btn-successs btn-arrow-right">다음</a>
		<%
				}
			%>

		<a href="<%=boardName%>Write.jsp?boardName=<%=boardName%>" class="btn btn-primary pull-right">글쓰기</a>
	</div>
</div>

</body>
>>>>>>> branch 'master' of https://github.com/Chatte777/BBS.git
</html>