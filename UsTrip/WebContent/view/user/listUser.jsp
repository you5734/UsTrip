<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script type="text/javascript">
	function fncGetAllList(currentPage) {
		$("#currentPage").val(currentPage);		
		$("form").attr("method" , "POST").attr("action" , "/user/listUser").submit();
	}

		//검색 처리
		 $(function() {
			 $( "button.btn.btn-default" ).on("click" , function() {
				fncGetAllList(1);
			});
			 
			 $(  "td:nth-child(3)" ).on("click" , function() {
				 var userId =  $(this).text().trim();
				/*  alert(":: " + userId); */
				 self.location="/user/getUser?userId="+userId;
			 });
		 });
	</script>
	
</head>
<body>
<jsp:include page="/common/toolbar.jsp"/>
<div class="container">
	<div class="page-header text-info">
       <h3>회원목록조회</h3>
    </div>
    
    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
    <div class="row">
	    <div class="col-md-6 text-left">
	    	<p class="text-primary">
	    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
	    	</p>
	    </div>
		    
	    <div class="col-md-6 text-right">
		    <form class="form-inline" name="detailForm">
			  <div class="form-group">
			    <select class="form-control" name="searchCondition" >
					<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
					<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>닉네임</option>
				</select>
			  </div>
			  
			  <div class="form-group">
			    <label class="sr-only" for="searchKeyword">검색어</label>
			    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
			    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
			  </div>
			  <button type="button" class="btn btn-default">검색</button>
			  <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
			</form>
    	</div>
	</div>
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
        <thead>
          <tr>
          	<td align="center"><input type="checkbox" value="" /></td>
            <th align="center">No</th>
            <th align="left" >회원 ID</th>
            <th align="left">닉네임</th>
            <th align="left">성별</th>
            <th align="left">탈퇴여부</th>
          </tr>
        </thead>
		
		<tbody>
		  <c:set var="i" value="0" />
		  <c:forEach var="user" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center"><input type="checkbox" name="chbox" value="${user.userId}" /></td>
			  <td align="left">${ i }</td>
			  <td align="left">${user.userId}</td>
					<input type="hidden" class="userId" value="${user.userId}"/>
			  <td align="left">${user.nickName}</td>
			  <c:set var="gender" value="${user.gender}"/>
				  <c:if test="${user.gender== 'm'}">
				  	<td align="left">남자</td>
				  </c:if>
				  <c:if test="${user.gender== 'f'}">
				  	<td align="left">여자</td>
				  </c:if>
			  <c:set var="isDelete" value="${user.isDelete}"/>
			 	 <c:if test="${user.isDelete== 0}">
				  	<td align="left">회원탈퇴</td>
				  </c:if>
			 	 <c:if test="${user.isDelete== 1}">
				  	<td align="left">회원</td>
				  </c:if>			  
			  <td align="left">
<%-- 			  	
				<i class="glyphicon glyphicon-ok" id= "${user.userId}"></i>
			  	
--%>
			  </td>
			</tr>
          </c:forEach>
        </tbody>
      </table>
 	</div>
 	<!-- PageNavigation Start... -->
 	<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
	<jsp:include page="../../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->

</body>
</html>