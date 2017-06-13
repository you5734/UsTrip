<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html >

	<script type="text/javascript">
		 $(function(){
			 $("#login").on("click" , function() {
				 self.location="/user/login"
			 });
			 
			 $("#join").on("click" , function() {
				 self.location="/user/addUser"
			 });
			 
			 $(".logo").on("click" , function() {
				 self.location="../../index.jsp"
			 });
		 });
	</script>

	<!-- Header -->
	<header id="header">
		<nav class="left">
			<a href="#menu"><span>Menu</span></a>
		</nav>
		<a class="logo">UsTrip</a>
		<nav class="right">
			<a class="button alt" id="login">Log in</a>
			<a href="#" class="button alt" id="join">join</a>
		</nav>
	</header>

	<!-- Menu -->
	<nav id="menu">
		<ul class="links">
			<li><a>Home</a></li>
			<li><a>어스토리</a></li>
			<li><a>플랜</a></li>
			<li><a>커뮤니티</a></li>
		</ul>
		<ul class="actions vertical"> 
			<li><a href="#" class="button fit">Login</a></li>
		</ul>
	</nav>