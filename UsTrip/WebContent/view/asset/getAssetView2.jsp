<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>���డ���</title>	
		
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
    <script src="/js/canvasjs.min.js"></script>
    <script src="/js/graph.js"></script>
    
    <link rel="stylesheet" href="/css/default.css">
<link rel="stylesheet" href="/css/default.date.css">
  <script src="/js/picker.js"></script>
    <script src="/js/picker.date.js"></script>
    <script src="/js/legacy.js"></script>
     <script src="/js/dateFormat.js"></script>
      
	<style>
 		body {padding-top : 50px;}      
 		
 	 /* 	.canvasjs-chart-tooltip{
  right: auto !important;
  left: 5px !important;
  top: 5px !important;
  bottom: auto !important;
  position:fixed;
}  */
     </style>
    
	<script type="text/javascript">	
	
	
	
		    $(function() {	
		    	$("form").attr("method" , "POST").attr("action" , "/asset/getAsset?travNo=4").submit();
								});
	</script>
	
</head>

<body>
<form></form>
</body>

</html>