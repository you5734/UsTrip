<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
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
 	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 		<script src="https://use.fontawesome.com/04438b50a5.js"></script>
	
	<script type="text/javascript">
	
		function fncGetAllList(currentPage) {
			$("#currentPage").val(currentPage);		
			$("form").attr("method" , "POST").attr("action" , "/message/listReceivMsg").submit();
		}
		
		$(function() {
			$( ".content" ).on("click" , function() {
				var msgNo = $(this).next().val();
				var receiver = $("#receiver").val();
				 self.location ="/message/getMsg?msgNo="+msgNo+"&receiver="+receiver;
			});
		});
		
		$(function() {
			$("#sendMsg").on("click", function() {
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
		
/* 		//한개삭제?
		$(function() {		
			$(".fa.fa-trash-o").on("click", function() {
				var msgNo = $("#msgNo").val();
				self.location="/message/deleteMsg?msgNo="+msgNo;	
			});
		});
		 */
		$(function() {
			$( "#delete" ).on("click" , function() {
				fncDeleteMessage();
			});
		});

		function fncDeleteMessage() {
			$("form").attr("method" , "POST").attr("action" , "/message/deleteMsg").submit();
		}
	
	</script>
	
	<style type="text/css">
		#accordion .glyphicon { margin-right:10px; }
		.panel-collapse>.list-group .list-group-item:first-child {border-top-right-radius: 0;border-top-left-radius: 0;}
		.panel-collapse>.list-group .list-group-item {border-width: 1px 0;}
		.panel-collapse>.list-group {margin-bottom: 0;}
		.panel-collapse .list-group-item {border-radius:0;}
		.content{
			overflow: hidden; 
			text-overflow: ellipsis;
			white-space: nowrap; 
			width: 60px;
			height: 20px;
			display: inline-block;
		}
		
	</style>
	
</head>

<body>
<jsp:include page="/common/toolbar.jsp"/>
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
			<td align="center"><input type="checkbox" name="chbox" value="${message.msgNo}" /></td>
			<input type="hidden" id="receiver" name="receiver" value="${message.receiver}">
			<td align="left">${message.sender}</td>
			<td></td>
			<td align="left">
				<span class="content" >${message.msgContent}</span>
				<input type="hidden" id="msgNo" name="msgNo" value="${message.msgNo}">
			</td>
			<td></td>
			<td></td>
			<td align="left">${message.sendDate}</td>
			<td></td>
			<c:set var="readDate" value="${message.readDate}"/>
					<c:if test="${ empty message.readDate}">
						<td align="left">읽지않음</td>
					</c:if>
			 <c:if test="${!empty message.readDate}">
				<td align="left">${message.readDate}</td>
			 </c:if>
			<td align="center"><i class="fa fa-trash-o" aria-hidden="true"></i></td>
		</tr>
	</c:forEach>
</table>
	<div align="right">
    		<button type="button" class="btn" id="delete">삭제하기</button>
   	</div>
</div>
		<tr>
			<td align="center">
				<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
					<jsp:include page="../../common/pageNavigator_new.jsp"/>	
	    	</td>
		</tr>
	</div>
	</form>
</div>

</body>
</html>