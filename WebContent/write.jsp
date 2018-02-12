<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>DREAMY CAT</title>
</head>
<body>
	<jsp:include page="_headNav.jsp" flush="false" />

	<div class="container">
		<div class="row">
			<form method="post" action="writeAction.jsp">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">게시판
								글쓰기 양식</th>
						</tr>
					</thead>

					<tbody>
						<tr>
						<tr>
							<td><input type="text" class="form-control"
								palceholder="글 제목" name="bbsTitle" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea type="text" class="form-control"
									palceholder="글 내용" name="bbsContent" maxlength="2048"
									style="height: 350px;"></textarea></td>
						</tr>
						<tr>
							<td>
								<form action="uploadAction.jsp" method="post"
									enctype="multipart/form-data">
									<div class="row">
										<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">파일:</div>
										<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
											<input type="file" name="file">
										</div>
										<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
											<input type="submit" value="업로드" style="float: left;">
										</div>
									</div>
								</form>
							</td>
						</tr>
						<tr>
							<td>썸네일</td>
						</tr>
					</tbody>
				</table width="800">
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>

		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>