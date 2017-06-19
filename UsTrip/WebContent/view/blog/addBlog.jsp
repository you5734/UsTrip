<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<script type="text/javascript">
	$(function() {
		$('body').on('click' , '#addBlog', function() {
			self.location="/blog/addBlog?travelNo="+$('#travelNo').val();
		});
		
	});
</script>
</head>
<body>
	(${travel[0].travTitle})<br/>
	<input type="button" id="addBlog" value="블로그 시작하기">
	<input type="hidden" id="travelNo" name="travelNo" value="${travel[0].travelNo}">
	<input type="hidden" id="visitDate" name="visitDate" value="${travel[0].startDate}">
</body>
</html>