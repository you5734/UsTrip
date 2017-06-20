<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %>
 
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
 
	<!-- Bootstrap -->
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
<%-- 	<link href='<c:url value="/css/kfonts2.css" />' rel="stylesheet"> --%>
	 
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script type="text/javascript">
	
		$(function() {
			$( ".btn.btn-info" ).on("click" , function() {

				  $("form").attr("method" , "POST").attr("action" , "/user/findPwd").submit();  
			});
		});	
	</script>
	
	<style>
		.container{
			margin-top:100px;
		}
	</style>
 
<title>���� ������</title>
</head>
<body>
<div class="container">
  <h4 align="center">���� ������</h4>
  <form >
    <div align="center"><!-- �޴� ��� �̸��� -->
      <input type="text" id="userId" name="userId" size="120" style="width:50%" placeholder="����� �̸���" class="form-control" >
    </div>     
    <!-- <div align="center">����
      <input type="text" name="title" size="120" style="width:100%" placeholder="������ �Է����ּ���" class="form-control" >
    </div>
    <p>
    <div align="center">���� 
      <textarea name="content" cols="120" rows="12" style="width:100%; resize:none" placeholder="����#" class="form-control"></textarea>
    </div> -->
    <p>
    <div align="center">
<!--       <input type="submit" id="submit" value="���� ������" class="btn btn-info"> -->
      <button type="submit" id="submit" class="btn btn-info">���Ϻ�����</button>
    </div>
  </form>
</div>
</body>
</html> 