<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<script type="text/javascript">
	$(function() {
		$('body').on('click' , '#addBlog', function() {
			alert("dddddd"+$('#travNo').val());
			self.location="/blog/addBlog?travelNo="+$('#travNo').val();
		});
		
	});
</script>

	${travel.travTitle}<br/>
	<input type="button" id="addBlog" value="start BLOG">
	<%-- <input type="hidden" id="travelNo" name="travelNo" value="${travel.travelNo}"> --%>
	<input type="text" id="travelNo" name="travelNo" value="${travel.travelNo}"> -
