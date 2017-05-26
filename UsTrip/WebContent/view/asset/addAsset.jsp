<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
<!-- 	  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  jQuery UI toolTip ��� JS
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
  <link rel="stylesheet" href="/css/default.css">
<link rel="stylesheet" href="/css/default.date.css">

   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/js/bootstrap-dropdownhover.min.js"></script>
	     <script src="/js/jquery.1.7.0.js"></script>
    <script src="/js/picker.js"></script>
    <script src="/js/picker.date.js"></script>
    <script src="/js/legacy.js"></script>

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/star-rating.css" media="all" type="text/css"/>
    <link rel="stylesheet" href="../themes/krajee-fa/theme.css" media="all" type="text/css"/>
    <link rel="stylesheet" href="../themes/krajee-svg/theme.css" media="all" type="text/css"/>
    <link rel="stylesheet" href="../themes/krajee-uni/theme.css" media="all" type="text/css"/>
    
    <script src="../javascript/star-rating.js" type="text/javascript"></script>
    <script src="../themes/krajee-fa/theme.js" type="text/javascript"></script>
    <script src="../themes/krajee-svg/theme.js" type="text/javascript"></script>
    <script src="../themes/krajee-uni/theme.js" type="text/javascript"></script>
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
        .overlay
{
padding-left:5px;
position: absolute;
margin-left: 3px;
margin-top: 15px;
}
#abc{
    font:Verdana, Geneva, sans-serif;
    font-size:18px;
    text-align:left;
    background-color:#0F0;
    height:50px;
    vertical-align:middle;
}
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		//============= ȸ���������� Event  ó�� =============	
		 $(function() {
			
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button:contains('�ۼ��Ϸ�')" ).on("click" , function() {
				 $("form").attr("method" , "POST").attr("action" , "/asset/addAsset").submit();
				});
			
			 $( "button:contains('Ȯ ��')" ).on("click" , function() {
				 $("form").attr("method" , "POST").attr("action" , "/asset/getAsset?travNo=4").submit();
				});
			 
			  $("#visitDate").pickadate({
					dateFormat: "yymmdd",
					min: [2017,05,01],
					max: [2017,05,10]
					
				}); 
			 			 
		});
		
	</script>
	
</head>

<body>
<form>

	<!-- ToolBar Start /////////////////////////////////////-->
	
	<br></br><br></br>
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
		<c:if test="${ !empty result }">
	       <h3 class=" text-info">�Է°��!! :: ${result}</h3>
	       </c:if>
	       <h5 class="text-muted">����θ� <strong class="text-danger">�Է��غ�����</strong>�ȵɲ���...�Ƹ�.....</h5>
	    </div>
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�����ȣ</strong></div>
			<div class="col-xs-8 col-md-4"><input name="travNo"></div>
		</div>
		
		<hr/>
	
		 <div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��α׹�ȣ</strong></div>
			<div class="col-xs-8 col-md-4"><input name="blogNo"></div>
		</div>
		
		<hr/>
		
		 <div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��볻��</strong></div>
			<div class="col-xs-8 col-md-4"><input name="usage"></div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>ī�װ�</strong></div>
			<div class="col-xs-8 col-md-4"><input name="assetCategory"></div>
		</div>
			<hr/>
			
			<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���ݾ�</strong></div>
			<div class="col-xs-8 col-md-4"><input name="charge"></div>
		</div>
			<hr/>
			
			<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�湮��¥</strong></div>
			<div class="col-xs-8 col-md-4"><input id = "visitDate"  class="datepicker" readonly></div>
		</div>
			<hr/>
		
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  		
	  			<button type="button" class="btn btn-primary">�ۼ��Ϸ�</button>
	  		
	  			<button type="button" class="btn btn-primary">Ȯ ��</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</form>
</body>

</html>