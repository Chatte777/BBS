<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
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

	<br>
	<a href="fileDownload.jsp">파일 다운로드 페이지</a>
</body>
</html>