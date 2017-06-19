<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

	<!-- Bootstrap Core CSS -->
	<link rel="stylesheet" href="/css/main.css" /> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"> 
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
     
	<script src="/js/jquery.min.js"></script>
	<script src="/js/jquery.scrolly.min.js"></script>
	<script src="/js/skel.min.js"></script>
	<script src="/js/util.js"></script>
	<script src="/js/main.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 
	
	<!-- ////////////////////////////////////// 가계부 ////////////////////////////////////////////////// -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
    <script src="/js/canvasjs.min.js"></script>
    <script src="/js/graph.js"></script>
    
    <link rel="stylesheet" href="/css/default.css">
	<link rel="stylesheet" href="/css/default.date.css">
	<script src="/js/picker.js"></script>
	<script src="/js/picker.date.js"></script>
	<script src="/js/legacy.js"></script>
	<script src="/js/dateFormat.js"></script>
     
     <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.4/sweetalert2.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.4/sweetalert2.min.css">

	<!-- Include a polyfill for ES6 Promises (optional) for IE11 and Android browser -->
 	<script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script> 
	
	

	<script type="text/javascript">	
	    $(function() {	
			var condi = 4; /* travNo를 넣어준다. */
	    	newGraph(condi);
    	 });
	  
	    $(function() {	
			$( "tab2" ).on("click" , function() {
				var travelNo = $(".travNo").val();
					alert("travelno :: " + travelNo);
					self.location="/blog/listBlog?travNo=4";
			});
    	 }); 
	    		
	</script>

	<style>
			html, body {
			width: 100%;
			height:100%;
		}

*,
*:after,
*:before {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

.clearfix:before,
.clearfix:after {
	content: " ";
	display: table;
}

.clearfix:after {
	clear: both;
}

body {
	font-family: sans-serif;
	/* background: #f6f9fa; */
}

h1 {
	color: #ccc;
	text-align: center;
}

a {
  color: #ccc;
  text-decoration: none;
  outline: none;
}

/*Fun begins*/
.tab_container {
	width: 90%;
	margin: 0 auto;
	position: relative;
}

input, section {
  clear: both;
  padding-top: 10px;
  display: none ;
}

label {
  font-weight: 700;
  font-size: 15px;
  display: block;
  float: left;
  width: 20%;
  padding: 15px;
  color: #757575;
  cursor: pointer;
  text-decoration: none;
  text-align: center;
  background: #f0f0f0;
  margin-bottom: 0px !important;
}

#tab1:checked ~ #content1,
#tab2:checked ~ #content2,
#tab3:checked ~ #content3
{
  display: block !important;
  padding: 20px;
  background: #fff;
  color: #999;
  border-bottom: 2px solid #f0f0f0;
}

.tab_container .tab-content p,
.tab_container .tab-content h3 {
  -webkit-animation: fadeInScale 0.7s ease-in-out;
  -moz-animation: fadeInScale 0.7s ease-in-out;
  animation: fadeInScale 0.7s ease-in-out;
}
.tab_container .tab-content h3  {
  text-align: center;
}

.tab_container [id^="tab"]:checked + label {
  background: #fff;
  box-shadow: inset 0 3px #0CE;
}

.tab_container [id^="tab"]:checked + label .fa {
  color: #0CE;
}

label .fa {
  font-size: 1.3em;
  margin: 0 0.4em 0 0;
}

/*Media query*/
@media only screen and (max-width: 930px) {
  label span {
    font-size: 14px;
  }
  label .fa {
    font-size: 14px;
  }
}

@media only screen and (max-width: 768px) {
  label span {
    display: none;
  }

  label .fa {
    font-size: 16px;
  }

  .tab_container {
    width: 98%;
  }
}

/*Content Animation*/
@keyframes fadeInScale {
  0% {
  	transform: scale(0.9);
  	opacity: 0;
  }
  
  100% {
  	transform: scale(1);
  	opacity: 1;
  }
}


	</style>

</head>
<body>
<jsp:include page="/common/toolbar.jsp"/>
<div class="container">
	  <div class="row profile">
		<jsp:include page="/view/user/getProfile.jsp"/>
			
			<div class="col-md-9">
	        	<div class="profile-content">
				<!-- 	 <div class="row"> -->
					<div>
						<!-- <div class="profile-sidebar">  -->
						
						<div class="tab_container">
							<input type="hidden" class="travelNo" id="travNo" value="${travel.travelNo}">
							<input id="tab1" type="radio" name="tabs" checked>
							<label for="tab1"><i class="fa fa-code"></i><span>플랜</span></label>
				
							<input id="tab2" type="radio" name="tabs">
							<label for="tab2"><i class="fa fa-pencil-square-o"></i><span>블로그</span></label>
				
							<input id="tab3" type="radio" name="tabs">
							<label for="tab3"><i class="fa fa-bar-chart-o"></i><span>가계부</span></label>

							<section id="content1" class="tab-content">
								<h3>Headline 1</h3>
						      	<p>Tab 1 Content.</p>
							</section>
				
							<section id="content2" class="tab-content">
								
							</section>
				
							<section id="content3" class="tab-content">
								 <h3><strong>여행 사용 총금액 :: ${sum} 원</strong></h3>
									<ul class="nav nav-tabs">
										<li class="active"><a data-toggle="tab" href="#home" id="bar">막대 그래프</a></li>
										<li><a data-toggle="tab" href="#menu1" id="pie">원형 그래프</a></li>   
									</ul>
									<div id="listasset" ></div>
									<jsp:include page="/view/asset/updateAssetView.jsp" />  
							</section>
						</div>
					
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html> 