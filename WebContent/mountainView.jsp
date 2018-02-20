<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="mountainMaster.MountainMaster"%>
<%@ page import="mountainMaster.MountainMasterDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="mountainReply.MountainReply"%>
<%@ page import="mountainReply.MountainReplyDAO"%>
<%@ page import="java.io.File"%>
<%@ page import="mountainFile.MountainFile"%>
<%@ page import="mountainFile.MountainFileDAO"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>DREAMY CAT</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}

		int mountainNo = 0;
		if (request.getParameter("mountainNo") != null) {
			mountainNo = Integer.parseInt(request.getParameter("mountainNo"));
		}

		if (mountainNo == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'mountain.jsp'");
			script.println("</script>");
		}
		MountainMaster mountainMaster = new MountainMasterDAO().getMountainMaster(mountainNo);
	%>


	<jsp:include page="_headNav.jsp" flush="false" />

	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; word-break: break-all;">
				<thead>
					<tr>
						<th colspan="4" style="background-color: #eeeeee; text-align: center;">게시판 글</th>
					</tr>
				</thead>

				<tbody>
					<tr>
						<td style="width: 20%;">글제목</td>
						<td colspan="3"><%=mountainMaster.getMountainTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
					.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="3"><%=mountainMaster.getMountainMakeUser()%></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="3"><%=mountainMaster.getMountainMakeDt().substring(0, 11) + mountainMaster.getMountainMakeDt().substring(11, 13)
					+ "시" + mountainMaster.getMountainMakeDt().substring(14, 16) + "분"%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="3" style="min-height: 200px; text-align: center;"> 
						<div class="row">
						<%
								ArrayList<MountainFile> fileList = new MountainFileDAO().getList(mountainMaster.getMountainNo());

								for (MountainFile file : fileList) {
									%>
									<div style="width:100%; text-algin:center;">
									<%
									out.write("<img src=\"images/uploadFile/mountainFile/" 
											+ java.net.URLEncoder.encode(file.getFileServerName(), "UTF-8") + "\" style=\"width:100%; max-width:760px; vertical-align:middle\">"
											+ "</a><br><br>");
									%>
							</div>
									<%
								}
							%>
							</div>
							<p class="text-left">
						<%=mountainMaster.getMountainContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
					.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></p></td>
					</tr>
					<tr>
						<td colspan="2">
							<%
								//ArrayList<MountainFile> fileList = new MountainFileDAO().getList(mountainMaster.getMountainNo());

								for (MountainFile file : fileList) {
									out.write("<a href=\"" + request.getContextPath() + "/MountainFileDownloadAction?file="
											+ java.net.URLEncoder.encode(file.getFileServerName(), "UTF-8") + "\">" + file.getFileClientName()
											//+ "(다운로드 횟수: " + file.getDownloadCount() 
											+ "</a><br>");
								}
							%>
							
						</td>
					</tr>
				</tbody>
			</table>

			<table class="table table-striped">
				<tbody>
					<%
						MountainReplyDAO mountainReplyDAO = new MountainReplyDAO();
						ArrayList<MountainReply> list = mountainReplyDAO.getList(mountainNo);

						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td align="center"><%=list.get(i).getReplyNo()%></td>
						<td align="left" style="word-break: break-all;"><%=list.get(i).getReplyContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
						<%
							if (userID != null && userID.equals(list.get(i).getReplyMakeUser())) {
						%>
						<td align="center"><a onclick="return confirm('정말로 삭제하시겠습니까?')" a href="mountainReplyDeleteAction.jsp?mountainNo=<%=mountainNo%>&replyNo=<%=list.get(i).getReplyNo()%>" type="button" class="close" aria-label="close"> <span aria-hidden="true">&times;</span>
						</a></td>
						<%
							}
						%>
						<td style="width: 10%;"><%=list.get(i).getReplyMakeUser()%></td>
						<td style="width: 15%;"><%=list.get(i).getReplyMakeDt().substring(0, 11) + list.get(i).getReplyMakeDt().substring(11, 13)
						+ "시" + list.get(i).getReplyMakeDt().substring(14, 16) + "분"%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>

		<table class="table table-condensed">
			<form method="post" action="mountainReplyAction.jsp">
				<tbody>
					<td style="width: 90%;"><input type="text" class="form-control" placeholder="댓글" name="replyContent" maxlength="2048" style="height: 150px;"></td>
					<td style="width: 10%; vertical-align: bottom;" align="center"><input type="submit" class="btn btn-primary pull-right" value="댓글작성"></td>
					<input type="hidden" name="mountainNo" value="<%=mountainMaster.getMountainNo()%>">
				</tbody>
			</form>
		</table>

		<a href="mountain.jsp" class="btn btn-primary">목록</a>
		<%
			if (userID != null && userID.equals(mountainMaster.getMountainMakeUser())) {
		%>
		<a href="mountainUpdate.jsp?mountainNo=<%=mountainNo%>" class="btn btn-priamry">수정</a> <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="mountainDeleteAction.jsp?mountainNo=<%=mountainNo%>" class="btn btn-priamry">삭제</a>
		<%
			}
		%>
		<a href="mountainWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>

	</div>


	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
</body>
</html>