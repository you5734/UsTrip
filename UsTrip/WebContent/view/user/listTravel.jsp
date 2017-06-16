<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

	<!-- Bootstrap Core CSS -->
    <!-- <link href="../../css/bootstrap.min.css" rel="stylesheet"> -->
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
	
	<style>
	
		html, body {
			width: 100%;
			height:100%;
		}

/* 		.profile-sidebar {
		 // padding: 20px 0 10px 0; 
		  background: #fff;
		}
		.profile-pic img {
		  float: none;
		  margin: 0 auto;
		  width:110px;
		  height:120px;
		  -webkit-border-radius: 50% !important;
		  -moz-border-radius: 50% !important;
		  border-radius: 50% !important;
		}
		.profile-content{
			text-align:center;
		}
		 
		.margin-bottom-30 { 
			margin-bottom: 30px;
		}
		
		
.post
{
    background-color: #FFF;
    overflow: hidden;
    box-shadow: 0 0 1px #CCC;
   //  width:250px; 
}
 .post img
{
    filter: blur(2px);
    -webkit-filter: blur(2px);
    -moz-filter: blur(2px);
    -o-filter: blur(2px);
    -ms-filter: blur(2px);
} 
.post img:hover
{
    filter: blur(0px);
    -webkit-filter: blur(0px);
    -moz-filter: blur(0px);
    -o-filter: blur(0px);
    -ms-filter: blur(0px);
}
.post .content
{
    padding-bottom: 15px;
}
.post .author
{
    font-size: 14px;
    color: #737373;
    padding: 20px 10px 15px;
}
.post .post-img-content
{
    height: 134px;
    position: relative;
}
.post .post-img-content img
{
    position: absolute;
}
.post .post-title
{
    display: table-cell;
    vertical-align: bottom;
    z-index: 2;
    position: relative;
}
.post .post-title b
{
    background-color: rgba(51, 51, 51, 0.58);
    display: inline-block;
    margin-bottom: 5px;
    color: #FFF;
    padding: 10px 15px;
    margin-top: 5px;
}		

*/



body{
    background:#eee;;
}
.title{
    text-shadow: 2px 2px 0px rgba(0, 0, 0, 0.4) !important;    
}

.divider-title{
    border:1px solid #dddddd;
}

.project {
    margin-bottom: 30px;
    vertical-align: top;
    margin-right: 30px;
    float: left;
    cursor: pointer;
    width:100%;
}

.project figure {
    position: relative;
    display: inline-block;
    width: 283px;
    -moz-box-shadow: 0 3px 0 #e2e2e2,transparent 0 0 0;
    -webkit-box-shadow: 0 3px 0 #e2e2e2,transparent 0 0 0;
    box-shadow: 0 3px 0 #e2e2e2,transparent 0 0 0;
    -webkit-box-shadow: 0 3px 0 #e2e2e2;
    -moz-box-shadow: 0 3px 0 #e2e2e2;
    box-shadow: 0 3px 0 #e2e2e2;
}

.project figure figcaption {
    position: relative;
    z-index: 10;
    padding: 8px 18px 11px;
    background: #fff;
    -ms-transition: all .2s ease-out;
    -webkit-transition: all .2s ease-out;
    -moz-transition: all .2s ease-out;
    -o-transition: all .2s ease-out;
    transition: all .2s ease-out;
    text-align: left;
    color: #555;
}

.project figure:hover .actions {
    opacity: 1;
}

.project figure .actions {
    display: block;
    position: absolute;
    top: 0;
    z-index: 1;
    width: 100%;
    height: 100%;
    opacity: 0;
    background-color: rgba(29,29,29,.7);
    -ms-transition: all .2s ease-out;
    -webkit-transition: all .2s ease-out;
    -moz-transition: all .2s ease-out;
    -o-transition: all .2s ease-out;
    transition: all .2s ease-out;
}

.project figure img {
    border: 0;
    width: 100%;
}
.btn-warning bnt-action{
    margin: 0% 0% auto;    
}

figcaption .project-details {
    display: block;
    font-size: 16px;
    line-height: 33px;
    color: #0093d0;
    height: 27px;
    width: 85%;
    margin-bottom: 5px;
    overflow: hidden;
}

figcaption .project-price {
    position: absolute;
    right: 15px;
    top: 12px;
    font-size: 22px;
    text-align: right;
    /* margin-top: 8px; */
    letter-spacing: -1px;
    -webkit-font-smoothing: antialiased;
}

figcaption .project-creator {
    font-size: 13px;
    color: #545454;
    display: block;
}

figcaption .project-creator {
    font-size: 13px;
    color: #545454;
    display: block;
}

.project figure .actions button {
    padding: 13px 20px;
    font-size: 16px;
    top: 32%;
    position: absolute;
    left: 50%;
    width: 90%;
    margin-left: -45%;
    line-height: 18px;
    letter-spacing: 1px;
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
							<div class="profile-sidebar">
													
								 <c:forEach var="travel" items="${travel}">				
										<div class="col-ms-10 col-md-4">
									        <div class="project">
									            <figure class="img-responsive">
									                <img src="http://lorempixel.com/400/300/sports/6/">
									                <figcaption>
									                    <span class="project-details">${travel.travTitle }</span>
									                    <span class="project-price"><strong>${travel.userId }</strong></span>
									                    <span class="project-creator">2017/03/05~2017/03/09</span>
									                </figcaption>
									                <span class="actions">
									                        <button class="btn btn-warning bnt-action" type="submit" >상세보기</button>
									                </span>
									            </figure>
									       </div>
									    </div>
									</c:forEach>		
					
						</div>
					</div>
				</div>
			<!-- </div> -->
		</div>
	</div>
</div>
</body>
</html>
