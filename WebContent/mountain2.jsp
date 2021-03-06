<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="mountainMaster.MountainMasterDAO" %>
<%@ page import="mountainMaster.MountainMaster" %>
<%@ page import="java.util.ArrayList" %>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>DREAMY CAT</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
		}
</style>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	
	
	<jsp:include page="_headNav.jsp" flush="false"/>
	
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
					MountainMasterDAO mountainMasterDAO = new MountainMasterDAO();
					ArrayList<MountainMaster> list = mountainMasterDAO.getList(pageNumber);
					
					for(int i=0; i<list.size(); i++){
						int replyCnt = mountainMasterDAO.getReplyCnt(list.get(i).getMountainNo());
						int replyColorFlag = mountainMasterDAO.getReplyColor(list.get(i).getMountainNo());
				%>
					<tr>
						<td
						<%
							if(replyColorFlag==1){%> style="color:#873286;"<%}
							else if(replyColorFlag==2){%> style="color:#DE2A45;"<%}
							else if(replyColorFlag==3){%> style="color:#F5762C;"<%}
							else if(replyColorFlag==4){%> style="color:#10BF00;"<%}
							else if(replyColorFlag==5){%> style="color:#2865BF;"<%}
							else if(replyColorFlag==6){%> style="color:black;"<%}
						%>>
						<%if(replyCnt!=0){%><%=replyCnt%><%}%></td>
						<td><a href="mountainView.jsp?mountainNo=<%= list.get(i).getMountainNo() %>"><%= list.get(i).getMountainTitle() %></a></td>
						<td><%= list.get(i).getMountainMakeUser() %></td>
						<td><%= list.get(i).getMountainMakeDt().substring(0,11)+list.get(i).getMountainMakeDt().substring(11,13)+"시"+list.get(i).getMountainMakeDt().substring(14,16)+"분" %></td>
					</tr>
				<%
					}				
				%>
				</tbody>
			</table>
			
			<%
				if(pageNumber!= 1){
			%>
				<a href="mountain.jsp?boardName=mountain&pageNumber=<%=pageNumber-1%>" class="btn btn-successs btn-arrow-left">이전</a>
			<%
				} if(mountainMasterDAO.nextPage(pageNumber+1)) {
			%>
				<a href="mountain.jsp?boardName=mountain&pageNumber=<%=pageNumber+1%>" class="btn btn-successs btn-arrow-right">다음</a>
			<%
				}
			%>
			
			<a href="mountainWrite.jsp?boardName=mountain" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="mountainMaster.MountainMasterDAO" %>
<%@ page import="mountainMaster.MountainMaster" %>
<%@ page import="java.util.ArrayList" %>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>DREAMY CAT</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
		}
</style>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	
	
	<jsp:include page="_headNav.jsp" flush="false"/>
	
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
					MountainMasterDAO mountainMasterDAO = new MountainMasterDAO();
					ArrayList<MountainMaster> list = mountainMasterDAO.getList(pageNumber);
					
					for(int i=0; i<list.size(); i++){
						int replyCnt = mountainMasterDAO.getReplyCnt(list.get(i).getMountainNo());
						int replyColorFlag = mountainMasterDAO.getReplyColor(list.get(i).getMountainNo());
				%>
					<tr>
						<td
						<%
							if(replyColorFlag==1){%> style="color:#873286;"<%}
							else if(replyColorFlag==2){%> style="color:#DE2A45;"<%}
							else if(replyColorFlag==3){%> style="color:#F5762C;"<%}
							else if(replyColorFlag==4){%> style="color:#10BF00;"<%}
							else if(replyColorFlag==5){%> style="color:#2865BF;"<%}
							else if(replyColorFlag==6){%> style="color:black;"<%}
						%>>
						<%if(replyCnt!=0){%><%=replyCnt%><%}%></td>
						<td><a href="mountainView.jsp?mountainNo=<%= list.get(i).getMountainNo() %>"><%= list.get(i).getMountainTitle() %></a></td>
						<td><%= list.get(i).getMountainMakeUser() %></td>
						<td><%= list.get(i).getMountainMakeDt().substring(0,11)+list.get(i).getMountainMakeDt().substring(11,13)+"시"+list.get(i).getMountainMakeDt().substring(14,16)+"분" %></td>
					</tr>
				<%
					}				
				%>
				</tbody>
			</table>
			
			<%
				if(pageNumber!= 1){
			%>
				<a href="mountain.jsp?boardName=mountain&pageNumber=<%=pageNumber-1%>" class="btn btn-successs btn-arrow-left">이전</a>
			<%
				} if(mountainMasterDAO.nextPage(pageNumber+1)) {
			%>
				<a href="mountain.jsp?boardName=mountain&pageNumber=<%=pageNumber+1%>" class="btn btn-successs btn-arrow-right">다음</a>
			<%
				}
			%>
			
			<a href="mountainWrite.jsp?boardName=mountain" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
>>>>>>> branch 'master' of https://github.com/Chatte777/BBS.git
</html>