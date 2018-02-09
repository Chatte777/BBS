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
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>


	<nav class="navbar navbar-default">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collpased"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<span class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>

		<%
			if (userID != null && userID.equals("slop1434")) {
		%>
		<a class="navbar-brand" href="main.jsp">DREAMY CAT</a>
		<%
			}
		%>
		<a class="navbar-brand" href="main.jsp">������ �ֽ�����</a>
	</div>

	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li class="active"><a href="main.jsp">����</a></li>
			<li><a href="bbs.jsp">�Խ���</a></li>
			<%
				if (userID != null && userID.equals("slop1434")) {
			%>
			<li><a href="thread.jsp">��ȭ�� ��</a></li>
			<%
				}
			%>
		</ul>

		<%
			if (userID == null) {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">�����ϱ�<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="login.jsp">�α���</a></li>
					<li><a href="join.jsp">ȸ������</a></li>
				</ul></li>
		</ul>
		<%
			} else {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">ȸ������<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="logoutAction.jsp">�α׾ƿ�</a></li>
				</ul></li>
		</ul>
		<%
			}
		%>

	</div>
	</nav>


</body>
</html>