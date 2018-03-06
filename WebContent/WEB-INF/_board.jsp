<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>
<%@ page import="java.util.ArrayList"%>


<div class="container">
	<div class="row">
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">���</th>
					<th style="background-color: #eeeeee; text-align: center;">����</th>
					<th style="background-color: #eeeeee; text-align: center;">�ۼ���</th>
					<th style="background-color: #eeeeee; text-align: center;">�ۼ���</th>
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
					ArrayList<BoardVO> list = boardDAO.getList(pageNumber, userId);
					
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
					<td><%= list.get(i).getBoardMakeDt().substring(0,11)+list.get(i).getBoardMakeDt().substring(11,13)+"��"+list.get(i).getBoardMakeDt().substring(14,16)+"��" %></td>
				</tr>
				<%
					}				
				%>
			</tbody>
		</table>

		<%
				if(pageNumber!= 1){
			%>
		<a href="<%=boardName%>.jsp?boardName=<%=boardName%>&pageNumber=<%=pageNumber-1%>" class="btn btn-successs btn-arrow-left">����</a>
		<%
				} if(boardDAO.nextPage(pageNumber+1)) {
			%>
		<a href="<%=boardName%>.jsp?boardName=<%=boardName%>&pageNumber=<%=pageNumber+1%>" class="btn btn-successs btn-arrow-right">����</a>
		<%
				}
			%>

		<a href="<%=boardName%>Write.jsp?boardName=<%=boardName%>" class="btn btn-primary pull-right">�۾���</a>
	</div>
</div>