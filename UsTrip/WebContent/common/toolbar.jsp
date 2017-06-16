<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html >

	<script type="text/javascript">
		 $(function(){
			 $("#login").on("click" , function() {
				 self.location="/user/login"
			 });
			 $("#logout").on("click" , function() {
				 self.location="/user/logout"
			 });
			 
			 $("#join").on("click" , function() {
				 self.location="/user/addUser"
			 });
			 
			 $(".logo").on("click" , function() {
				 self.location="../../index.jsp"
			 });
			 
			 $(".img-responsive.user-photo").on("click", function() {
				 self.location="/user/getContents";
			 })
			 
			 $("#community").on("click" , function() {
				 self.location="/community/listCommunity"
			 });
		 });
	</script>
	
	<style>
		.img-responsive.user-photo{
			  float: none;
			  margin: -14px 20px;
			  width: 40px;
			  height: 40px;
			  -webkit-border-radius: 50% !important;
			  -moz-border-radius: 50% !important;
			  border-radius: 50% !important;
			  display: inline-block !important;
		}
 		.fa.fa-envelope{
			width: 40px;
			height: 40px;
		}
	</style>

	<!-- Header -->
	<header id="header">
		<nav class="left">
			<a href="#menu"><span>Menu</span></a>
		</nav>
		<a class="logo">UsTrip</a>
		<c:if test="${empty user}">
			<nav class="right">
				<a class="button alt" id="login">Log in</a>
				<a href="#" class="button alt" id="join">join</a>
			</nav>
		</c:if>
		
		 <c:if test="${ ! empty user }">
		 	<nav class="right">
				<img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
				<a id="my">${sessionScope.user.nickName}</a>
				<i class="fa fa-envelope" aria-hidden="true"></i>
				<a class="" id="logout">Log Out</a>
			</nav>
		 </c:if>
	</header>

	<!-- Menu -->
	<nav id="menu">
		<ul class="links">
			<li><a>홈</a></li>
			<li><a>어스토리</a></li>
			<li><a>플랜</a></li>
			<li><a id="community">커뮤니티</a></li>
		</ul>
		<ul class="actions vertical"> 
			<c:if test="${empty user}">
				<li><a href="#" class="button fit">로그인</a></li>
			</c:if>
			 <c:if test="${ ! empty user }">
			 	<li><a href="#" class="button fit">로그아웃</a></li>
			 </c:if>
		</ul>
	</nav>