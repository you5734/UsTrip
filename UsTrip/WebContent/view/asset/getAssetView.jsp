<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>여행가계부</title>	
		
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
 		
 	 	 .canvasjs-chart-tooltip{
  /* right: auto !important;
  left: 5px !important;
  top: 5px !important;
  bottom: auto !important;
  position:fixed; */
}  
     </style>
    
	<script type="text/javascript">	
	
	
	
		    $(function() {	
		    	 var condi = 4; /* travNo를 넣어준다. */
		    	newGraph(condi);		  
								});
	</script>
	
</head>

<body>

	<div class="container">
  <h2><strong>여행 사용 총금액 :: ${sum}</strong></h2>
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#home" id="bar">막대 그래프</a></li>
    <li><a data-toggle="tab" href="#menu1" id="pie">원형 그래프</a></li>   
  </ul>

  <div class="tab-content">
    <div class="tab-pane fade in active">
      <div id="listasset" style="height: 500px; width: 1000px;;"></div>
    </div>
     
  </div>
</div>	
<jsp:include page="/view/asset/updateAssetView.jsp" />
</body>

</html>