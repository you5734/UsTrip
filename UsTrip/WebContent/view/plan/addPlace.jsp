<%@ page contentType="text/html; charset=euc-kr" %>



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
	    $( "#visitDate" ).datepicker({
	      dateFormat : "yy-mm-dd",
		  showOn: "button",
	      buttonImage: "../images/ct_icon_date.gif",
	      buttonImageOnly: true,
	      showButtonPanel: true,
	      buttonText: "Select date" 
	    });
	});
	
	


	function fncAddPlace() {

		var visitDate = $("input[name='visitDate']").val();
		
		$("form").attr("method", "POST").attr("action", "/plan/addPlace")
				.submit();
	}

	$(function() {
	
		$("button[name='등록']").on("click", function() {	
			fncAddPlace();
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
		
		<!-- form Start /////////////////////////////////////-->
		<!-- <form class="form-horizontal" name="detailForm"> -->
		<form class="form-horizontal">
			
		  <div class="page-header text-info">
       		<h3>Place테이블입력</h3>
    	  </div>
		  
		  <input type="hidden" id="cityNo" name="cityNo" value="${sessionScope.city.cityNo}"/>
		  <input type="hidden" id="travelNo" name="travelNo" value="${sessionScope.city.travelNo}"/>
		  
		  <div class="form-group">
		    <label for="placeId" class="col-xs-4 col-md-2">장소ID</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="placeId"  name="placeId" placeholder="">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="place" class="col-xs-4 col-md-2">장소명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="place"  name="place" placeholder="">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="placeX" class="col-xs-4 col-md-2">장소X좌표</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="placeX"  name="placeX" placeholder="">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="placeY" class="col-xs-4 col-md-2">장소Y좌표</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="placeY"  name="placeY" placeholder="">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prePlaceNo" class="col-xs-4 col-md-2">이전장소번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prePlaceNo"  name="prePlaceNo" placeholder="">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="nextPlaceNo" class="col-xs-4 col-md-2">다음장소번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="nextPlaceNo"  name="nextPlaceNo" placeholder="">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="memo" class="col-xs-4 col-md-2">메모</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="memo"  name="memo" placeholder="">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="visitDate" class="col-xs-4 col-md-2">방문날짜</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="visitDate"  name="visitDate" placeholder="">
		    </div>
		  </div>
		  
		  
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



