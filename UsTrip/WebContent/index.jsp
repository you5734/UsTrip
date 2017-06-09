<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
  <title>Vidbg.js Demo</title>
  <link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
  <link href="/css/fullscreenDemo.css" rel="stylesheet" type="text/css">
   <link rel="stylesheet" href="/css/bootstrap.vertical-tabs.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  
  $(window).scroll(function() {
		if ($(document).scrollTop() > 150) {
          alert('hi');
		$('.logo').height(200);

		}
		else {
		$('.logo').height(100);
		}
		});
  
  </script>
  
  
</head>

<body>

<div id="nav">
  <div class="navbar navbar-inverse navbar-fixed-top" data-spy="affix" data-offset-top="100">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#"><img class="img-responsive logo" src="https://cdn4.iconfinder.com/data/icons/adore/118/Camera.png" alt=""></a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">

          <ul class="nav navbar-nav navbar-right">
            <li class="active"><a href="http://localhost:8080/view/user/login.jsp">Home</a>
            </li>
            <li><a href="#about">About</a>
            </li>
            <li><a href="#contact">Contact</a>
            </li>
          </ul>
        </div>
        </div>
        </div>
        </div>

  <div class="block-container">
    <div class="block">
      <h1>Us Trip</h1>
      <h3>당신의 아름다운 대한민국을 여행하세요</h3>
    </div>
  </div>
  
  <script type="text/javascript">
    $(function($){
          $('body').vidbg({
              'mp4': '/images/media/mp4_video.mp4',
              'webm': '/images/media/webm_video.webm',
              'poster': '/images/media/fallback.jpg',
          }, {
            // Options
            muted: true,
            loop: true,
  					overlay: true,
            overlayColor: '#000',
            overlayAlpha: '0.2',
          });
      });
  </script>

  <script src="/js/vidbg.min.js"></script>

</body>
</html>
