<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!-- Bootstrap Core CSS -->
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    
    <meta name="viewport" content="width=device-width, initial-scale=1">
 	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<script type="text/javascript">
	
		function fncGetAllList(currentPage) {
			$("#currentPage").val(currentPage);		
			$("form").attr("method" , "POST").attr("action" , "/message/listReceivMsg").submit();
		}
		
		$(function() {
			$("#send").on("click", function() {
				self.location="/message/sendMsg";	
			});
		});
		
		$(function() {
			$("#listSend").on("click", function() {
				self.location="/message/listSendMsg";	
			});
		});
		
		$(function() {		
			$("#listReceive").on("click", function() {
				self.location="/message/listReceivMsg";	
			});
		});
	
	</script>
	
	<style>
		body{margin:150px;}
		#accordion .glyphicon { margin-right:10px; }
		.panel-collapse>.list-group .list-group-item:first-child {border-top-right-radius: 0;border-top-left-radius: 0;}
		.panel-collapse>.list-group .list-group-item {border-width: 1px 0;}
		.panel-collapse>.list-group {margin-bottom: 0;}
		.panel-collapse .list-group-item {border-radius:0;}
	</style>
	
</head>

<body>

<div class="container">
<form name="detailForm">
  <div class="row">
    <div class="col-sm-3 col-md-3">
      <div class="panel-group" id="accordion">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h4 class="panel-title">
              <a id="sendMsg" >
              <span class="glyphicon glyphicon-folder-close">
                </span>쪽지보내기</a>
            </h4>
          </div>
        </div>
        
        <br>
        <div class="panel panel-default">
          <div class="panel-heading">
            <h4 class="panel-title">
              <a id="listSend" ><span class="glyphicon glyphicon-file">
                </span >보낸쪽지함</a>
            </h4>
          </div>
        </div>
        
        <br>
        <div class="panel panel-default">
          <div class="panel-heading">
            <h4 class="panel-title">
              <a id="listReceive"><span class="glyphicon glyphicon-heart">
                </span >받은쪽지함</a>
            </h4>
          </div>
        </div>
      </div>
    </div>
   
<!--     <div class="col-sm-9 col-md-9">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title">Dashboard</h3>
        </div>
        <div class="panel-body">
          Admin Dashboard Accordion List Group Menu
        </div>
      </div>
    </div>
  </div>
</div> -->
<div class="col-sm-9 col-md-9">
<table class="table">
	<tr>
		<td colspan="13" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td align="center"><input type="checkbox" value="" /></td>
		<td class="ct_list_b" width="150">보낸사람</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">글내용</td>
		<td class="ct_line02"></td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">받은날짜</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">읽은날짜</td>	
	</tr>

	<c:set var="i" value="0"/>
	<c:forEach var="message" items="${list}">
		<c:set var="i" value="${i+1}"/>
		<tr class="ct_list_pop">
			<td align="center"><input type="checkbox" value="" /></td>
			<input type="hidden" id="msgNo" name="msgNo" value="${message.msgNo}"/>
			<input type="hidden" id="sender" name="sender" value="${message.receiver}"/>
			<td align="left">${message.sender}</td>
			<td></td>
			<td align="left">${message.msgContent}</td>
			<td></td>
			<td></td>
			<td align="left">${message.sendDate}</td>
			<td></td>
			<td align="left">${message.readDate}</td>
		</tr>
	</c:forEach>
</table>
</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:20px; margin-left:110px;">
		<tr>
			<td align="center">
				<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
					<jsp:include page="../../common/pageNavigator_new.jsp"/>	
	    	</td>
		</tr>
	</table>

	</div>
	</form>
	</div>

</body>
</html>