<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Intensify by TEMPLATED
	templated.co @templatedco
	Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
<html>
	<head>
	<meta charset="UTF-8">
		<title>USTRIP</title>
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="/css/main.css" />
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		
		 <link href="/css/fullscreenDemo.css" rel="stylesheet" type="text/css">
		 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

		<script type="text/javascript">
/*  			$(window).scroll(function() {
				if ($(document).scrollTop() > 150) {
			         alert('hi');
					$('.logo').height(200);
				} 	else {
					$('.logo').height(100);
				}
			}); */
			
		 $(function(){
		          $('body').vidbg({
		              'mp4': '/images/media/mp4_video.mp4',
		              /*   	           		   'webm': '/images/media/webm_video.webm',
		              'poster': '/images/media/fallback.jpg',  */
		          }, {
		            // Options
		            muted: true,
		            loop: true,
		  			overlay: true,
		            overlayColor: '#000',
		            overlayAlpha: '0.2',
		            muted: true
		          });
		      }); 
			
		</script>
		
	</head>
	<body >
		<!-- Header -->
		<!-- 	<header id="header">
				<nav class="left">
					<a href="#menu"><span>Menu</span></a>
				</nav>
				<a href="index.jsp" class="logo">UsTrip</a>
				<nav class="right">
					<a class="button alt" id="login">Log in</a>
					<a href="#" class="button alt">join</a>
				</nav>
			</header> -->

		<!-- Menu -->
		<!-- 	<nav id="menu">
				<ul class="links">
					<li><a>Home</a></li>
					<li><a>어스토리</a></li>
					<li><a>플랜</a></li>
					<li><a>커뮤니티</a></li>
				</ul>
				<ul class="actions vertical"> 
					<li><a href="#" class="button fit">Login</a></li>
				</ul>
			</nav> -->
			<jsp:include page="/common/toolbar.jsp"/>
	<!-- //////////툴바 및 메뉴바/////////// -->
			 <div class="block-container">
				<div class="block">
					<h3>당신의 아름다운 대한민국을 여행하세요</h3><br>
						<ul class="actions">
					  		<li><a href="#one" class="button scrolly">Get Started</a></li>
					  </ul>
				</div>
			</div>
			
			<!-- Banner -->
			<section id="banner">
				<div class="content">
<!-- 					
				<h1>Ipsum sed lorem</h1>
					<p>Morbi in sem quis dui placerat ornare. Pellentesque odio nisi, euismod<br />sed arcu cras consecuat lorem ipsum dolor sit amet.</p>
					<ul class="actions">
						<li><a href="#one" class="button scrolly">Get Started</a></li>
					</ul> -->
				</div>
			</section> 

		<!-- One -->
			<section id="one" class="wrapper">
				<div class="inner flex flex-3">
					<div class="flex-item left">
						<div>
							<h3>Magna ultricies</h3>
							<p>Morbi in sem quis dui plalorem ipsum<br /> euismod in, pharetra sed ultricies.</p>
						</div>
						<div>
							<h3>Ipsum adipiscing lorem</h3>
							<p>Tristique yonve cursus jam nulla quam<br /> loreipsu gravida adipiscing lorem</p>
						</div>
					</div>
					<div class="flex-item image fit round">
						<img src="images/pic01.jpg" alt="" />
					</div>
					<div class="flex-item right">
						<div>
							<h3>Tempus nullam</h3>
							<p>Sed adipiscing ornare risus. Morbi estes<br /> blandit sit et amet, sagittis magna.</p>
						</div>
						<div>
							<h3>Suscipit nibh dolore</h3>
							<p>Pellentesque egestas sem. Suspendisse<br /> modo ullamcorper feugiat lorem.</p>
						</div>
					</div>
				</div>
			</section> 

		<!-- Two -->
			<section id="two" class="wrapper style1 special">
				<div class="inner">
					<h2>Feugiat lorem</h2>
					<figure>
					    <blockquote>
					        "Morbi in sem quis dui placerat ornare. Pellentesque odio nisi, euismod in, pharetra<br /> magna etiam lorem ultricies in diam. Sed arcu cras consequat."
					    </blockquote>
					    <footer>
					        <cite class="author">Jane Anderson</cite>
					        <cite class="company">CEO, Untitled</cite>
					    </footer>
					</figure>
				</div>
			</section>

		<!-- Three -->
			<section id="three" class="wrapper">
				<div class="inner flex flex-3">
					<div class="flex-item box">
						<div class="image fit">
							<img src="images/pic02.jpg" alt="" />
						</div>
						<div class="content">
							<h3>Consequat</h3>
							<p>Placerat ornare. Pellentesque od sed euismod in, pharetra ltricies edarcu cas consequat.</p>
						</div>
					</div>
					<div class="flex-item box">
						<div class="image fit">
							<img src="images/pic03.jpg" alt="" />
						</div>
						<div class="content">
							<h3>Adipiscing</h3>
							<p>Morbi in sem quis dui placerat Pellentesque odio nisi, euismod pharetra lorem ipsum.</p>
						</div>
					</div>
					<div class="flex-item box">
						<div class="image fit">
							<img src="images/pic04.jpg" alt="" />
						</div>
						<div class="content">
							<h3>Malesuada</h3>
							<p>Nam dui mi, tincidunt quis, accu an porttitor, facilisis luctus que metus vulputate sem magna.</p>
						</div>
					</div>
				</div>
			</section>

		<!-- Footer -->
			<footer id="footer">
				<div class="inner">
					<h2>Get In Touch</h2>
					<ul class="actions">
						<li><span class="icon fa-phone"></span> <a href="#">(000) 000-0000</a></li>
						<li><span class="icon fa-envelope"></span> <a href="#">information@untitled.tld</a></li>
						<li><span class="icon fa-map-marker"></span> 123 Somewhere Road, Nashville, TN 00000</li>
					</ul>
				</div>
				<div class="copyright">
					&copy; Untitled. Design <a href="https://templated.co">TEMPLATED</a>. Images <a href="https://unsplash.com">Unsplash</a>.
				</div>
			</footer>

		<!-- Scripts -->
			<script src="/js/jquery.min.js"></script>
			<script src="/js/jquery.scrolly.min.js"></script>
			<script src="/js/skel.min.js"></script>
			<script src="/js/util.js"></script>
			<script src="/js/main.js"></script>
			<script src="/js/vidbg.min.js"></script>

	</body>
</html>