<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			<form method="post" action="threadWriteAction.jsp" enctype="multipart/form-data">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
						</tr>
					</thead>

					<tbody>
						<tr>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="threadTitle" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea type="text" class="form-control" placeholder="글 내용" name="threadContent" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
						<tr>
							<td>
								<div class="row">
									<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">파일:</div>
									<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
										<input type="file" name="file">
									</div>
									<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
										<input type="file" name="file2">
									</div>
									<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
										<input type="file" name="file3">
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td>썸네일</td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>