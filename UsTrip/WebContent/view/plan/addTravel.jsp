<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/sunny/jquery-ui.css">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>


	<style>
 		body {
            padding-top : 70px;
        }
     </style>
     
<script type="text/javascript">

		
	$( function() {
	    $( "#startDate" ).datepicker({
	      dateFormat : "yy-mm-dd",
		  showOn: "button",
	      buttonImage: "../images/ct_icon_date.gif",
	      buttonImageOnly: true,
	      showButtonPanel: true,
	      buttonText: "Select date" 
	    });
	});
	
	


	function fncAddTravel() {

		var startDate = $("input[name='startDate']").val();
		
		$("form").attr("method", "POST").attr("action", "/plan/addTravel")
				.submit();
	}

	$(function() {
	
		$("button[name='등록']").on("click", function() {	
			fncAddTravel();
		});

		$("button[name='취소']").on("click", function() {
			$("form")[0].reset();
		});
		
		
		
		
	});	
		
</script>
</head>

<body>
<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">

	<div class="page-header text-info">
       <h3>Travel테이블입력</h3>
    </div>
		
		<!-- form Start /////////////////////////////////////-->
		<!-- <form class="form-horizontal" name="detailForm"> -->
		<form class="form-horizontal">
			
			<!-- 히든유저있던곳	 -->		
		  <div class="form-group">
		    <input type="hidden" id="userId" name="userId" value="user01"/>
		  </div>			
		
			
		  
		  <div class="form-group">
		    <label for="travTitle" class="col-xs-4 col-md-2">여행제목</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="travTitle" name=travTitle placeholder="여행제목">
		    </div>
		  </div>

		  
		  <div class="form-group">
		    <label for="startDate" class="col-xs-4 col-md-2">출발일</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="startDate"  name="startDate" placeholder="달력 이미지 클릭">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="memberCount" class="col-xs-4 col-md-2">인원수</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="memberCount" name="memberCount" placeholder="인원수">
		    </div>
		  </div>
		  		  
		  <div class="form-group">
		  	 <label for="travTheme" class="col-xs-4 col-md-2">여행테마</label>
		    <div class="col-sm-4">
		      <select name="travTheme" style="width: 85px; height: 28px" >
				<option value="우정여행">우정여행</option>
				<option value="커플여행">커플여행</option>
				<option value="신혼여행">신혼여행</option>
				<option value="가족여행">가족여행</option>
				<option value="솔로여행">솔로여행</option>
				<option value="배낭여행">배낭여행</option>
			</select>
		    </div>
		  </div>
	
		  <div class="form-group">
		    <label for="totalDate" class="col-xs-4 col-md-2">총 숙박일</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="totalDate" name="totalDate" placeholder="총 숙박일">
		    </div>
		  </div>
			<!-- 
		  <div class="form-group">
		    <label for="isBlogStart" class="col-xs-4 col-md-2">블로그 시작 여부</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="isBlogStart" name="isBlogStart">
		    </div>
		  </div>
		  	 -->
		  
		  
		  <br/>
		  <hr/>
		  
		 
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  name="등록">등&nbsp;록</button>
		      <button type="button" class="btn btn-primary"  name="취소">취&nbsp;소</button>
		    </div>
		  </div>
		</form>
		<!-- form End /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
	
</body>
</html>



