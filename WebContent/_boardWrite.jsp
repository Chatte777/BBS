<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
String boardName = request.getParameter("boardName");
String action = boardName+"WriteAction.jsp";
String title = boardName+"Title";
String content = boardName+"Content";
String authorize = boardName+"Authorize";
%>


	<div class="container">
		<div class="row">
			<form method="post" action="<%=action%>" enctype="multipart/form-data">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
						</tr>
					</thead>

					<tbody>
						<tr>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="<%=title%>" maxlength="50"></td>
							<td><select class="form-control" name="<%=authorize%>"><option value="1" selected>전체공개</option><option value="2">나만보기</option></select></td>
						</tr>
						<tr>
							<td colspan="2"><textarea type="text" class="form-control" placeholder="글 내용" name="<%=content%>" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
						<jsp:include page="_fileUpload.jsp" flush="false"/>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="작성완료">
			</form>
		</div>
	</div>
</body>
</html>