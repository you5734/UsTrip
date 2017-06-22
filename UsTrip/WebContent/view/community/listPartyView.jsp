<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
	 <link rel="stylesheet" href="/css/bootstrap.vertical-tabs.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.4/sweetalert2.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.4/sweetalert2.min.css">
	
	<script src="/js/dateFormat.js"></script>
	
	<link href="/css/jquery.contextMenu.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery.contextMenu.js" type="text/javascript"></script>
    <script src="/js/jquery.ui.position.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>    <link href="/css/main.css" rel="stylesheet" type="text/css"/>    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <script src="/js/jquery.min.js"></script>
	<script src="/js/jquery.scrolly.min.js"></script>
	<script src="/js/skel.min.js"></script>
	<script src="/js/util.js"></script>
	<script src="/js/main.js"></script>
	
	<script>
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("#searchForm").attr("method" , "POST").attr("action" , "/community/listCommunity").submit();
	}
	
	$(function () {	
		
		var current ='${resultPage.currentPage}';
		
		if('${search.order}' == 'DESC'){
			$('#simbol').attr('class','glyphicon glyphicon-arrow-up');
		}else{
			$('#simbol').attr('class','glyphicon glyphicon-arrow-down');
		}
		
		$('#search').on("click" , function() {
			fncGetList(1);
		});
		
		$('.list-group-item').hover(function(){				
			$(this).css('background-color','PeachPuff');		
		},function(){
			$(this).css('background-color','white');
		});
		
		$('b').hover(function(){
			$(this).attr('class','text-danger');
		},function(){
			$(this).attr('class','text-default');
		});
		
		$('b').on('click',function(){
			var objectID=$(this).attr('id');			
			$("#currentPage").val(current);
			$('#order').val('${search.order}');
			$("form").attr("method" , "POST").attr("action" , "/community/getBoard?boardNo="+objectID).submit();
		        });
		
		$('font').on('click',function(){
			var adad = $(this).text();
			popmenu(adad);
		});	
		
		$('#orderby').on('click',function(){		
			if('${search.order}' == 'DESC'){
				$('#order').val('ASC');
				fncGetList(current);
			}else{
				$('#order').val('DESC');
				fncGetList(current);
			}
		});	
		
		$('#write').on('click',function(){
			self.location="/community/addBoardForm?userId="+"${user.userId}"
		});
		
		$('#orderby').hover(function(){
			$(this).attr('class','col-md-1 text-primary');
		},function(){
			$(this).attr('class','col-md-1');
		});
		
		$('font').hover(function(){
			$(this).attr('class','text-danger');
		},function(){
			$(this).attr('class','text-default');
		});
		
        $('#men').on('click',function(){
        	$('#searchKeyword').val(null);
        	$('#searchCondition').val(null);
        	$('#boardCategory').val('0');
        	fncGetList(1);
        });
        
        $('#part').on('click',function(){
        	$('#searchKeyword').val(null);
        	$('#searchCondition').val(null);
        	fncGetList(1);
        }); 
        
       // style="width: 100px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;"
       var maxLength = 200;
        $('textarea').keyup(function() {
          var length = $(this).val().length;
          var length = maxLength-length;
          $('#chars').text(length);
        }); 
      
});
	
	function popmenu(userId){
	    $.contextMenu({
	        selector: 'font', 
	        trigger: 'left',
	        callback: function(key, options) {
	            if(key == '1'){
	            	$('#searchKeyword').val(userId);
	            	$('#c').val('2');
	            	$('#boardCategory').val('1');
	            	fncGetList(1);
	            }else if(key == '2'){
	            	swal({
	            		  title: userId+'���� \n������������ �̵��Ͻðڽ��ϱ�?',
	            		  text: userId+"���� �����������ΰ��� �ٸ����൵ �����غ�����",
	            		  type: 'question',
	            		  showCancelButton: true,
	            		  confirmButtonColor: '#3085d6',
	            		  cancelButtonColor: '#d33',
	            		  confirmButtonText: '����'
	            		}).then(function () {
	            		  swal(
	            		    '����!',
	            		    '�������� �ϼ��Ǹ� �����մϴ�.',
	            		    'success'
	            		  )
	            		})
	            }else{
	            	swal({
	            		  title: userId+' ����\n Follow �Ͻðڽ��ϱ�?',
	            		  text: userId+" ���� Follow�ؼ� ������ �Բ��ϼ���!",
	            		  type: 'question',
	            		  showCancelButton: true,
	            		  confirmButtonColor: '#3085d6',
	            		  cancelButtonColor: '#d33',
	            		  confirmButtonText: 'Follw'
	            		}).then(function () {
	            			//ajax���� follow�߰�
	            			swal({
	            				  title: userId+'���� Follow�� �߽��ϴ�',
	            				  text: "Followȭ������ ���ðڽ��ϱ�?",
	            				  type: 'success',
	            				  showCancelButton: true,
	            				  confirmButtonColor: '#3085d6',
	            				  cancelButtonColor: '#d33',
	            				  confirmButtonText: '����'
	            				}).then(function () {
	            				  swal(
	            				    '����!',
	            				    '���������� �ϼ��Ǹ� �������� �����ϴ�..',
	            				    'success'
	            				  )
	            				})
	            		})
	            }
	        },
	        items: {
	            "1": {name: "�ۼ����� �� ��κ���"},
	            "2": {name: "�ۼ����� ������������"},
	            "3": {name: "�ۼ��ڸ� Follow �ϱ�"}
	        }
	    });
	}
	
  </script>
  <style type="text/css">
  body{font-family: "arial", dotum, "����", gulim, arial, helvetica, sans-serif;}
  </style>
  </head>
<body>
<jsp:include page="/common/toolbar.jsp"/>
	<div class="container" >
	
		<div class="jumbotron" 
			style="margin-top:50px;
			 background-image:url('http://cfile1.uf.tistory.com/image/1462BE384FFD98AE042149' );
			 background-size: cover;
			 background-position: center bottom ;
			 height:400px;
			 opacity: 0.8;">
						 
	  <h1 style="color:white;">���౸�ϱ� �Խ���</h1>
	  <p style="color:white; margin-top:130px;">���� ������ ������ ���غ�����!</p>
		</div> 
	</div>

	<div class="row" >
		<div class="col-md-2" style="margin-left:60px; margin-top:34px;">        
			<div class="list-group">
				<a class="list-group-item list-group-item-info" id="men" style="font-size:20px;"><i class="glyphicon glyphicon-star"></i> ���丵</a>
				<a class="list-group-item list-group-item-warning" id="part" style="font-size:20px;"><i class="glyphicon glyphicon-heart"></i> ���౸�ϱ�</a>
				<c:if test="${ !empty user }">
				<a class="list-group-item list-group-item-success" id="write" style="font-size:20px;"><i class="glyphicon glyphicon-list-alt"></i> �Խñ��ۼ�</a> 
				</c:if>
			</div>        
		</div>
    <div class="col-md-9" style="margin-left:10px;">
    
    <div class="row">
    	<div class="col-md-6 text-left">
		    	<p class="text-danger">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
    <div class="col-md-6 text-right" >
    <form class="form-inline" name="detailForm" id="searchForm">
	    <select class="form-control" name="searchCondition"  id="searchCondition" style="width:130px;">
		  <option value="0" ${ (search.searchCondition=="0" ? "selected" : "")}>�Խù� ��ȣ</option>
		  <option value="1" ${ (search.searchCondition=="1" ? "selected" : "")}>�Խù� ����</option>
		  <option value="2" ${ (search.searchCondition=="2" ? "selected" : "")}>�ۼ��� �̸�</option>
		</select>
	
		<input style="width:250px;" type="text" class="form-control" id="searchKeyword" name="searchKeyword" 
		 placeholder="�˻������� �����ϰ� �˻��ϼ���." value="${! empty search.searchKeyword ? search.searchKeyword : '' }" >
	    <input type="hidden" id="currentPage" name="currentPage" value=""/>  
	    <input type="hidden" id="boardCategory" name="boardCategory" value="1"/>
	    <input type="hidden" id="order" name="order" value=""/>
		<button class="btn btn-danger" type="button" id="search">�˻�</button>
		</form>
    	</div>
    </div>
    
    <!-- /input-group -->
	<div class="panel panel-warning" id="board">
	 <div class="panel-heading">
                     
       <div class="row" >
	         <div class="col-md-2" align="left" >��ȣ</div>
	         <div class="col-md-6" align="center">����</div>
	         <div class="col-md-2" align="center" >�ۼ���</div>
	         <div class="col-md-1" align="center" id="orderby">����� <i id ="simbol" class="glyphicon glyphicon-arrow-up"></i></div>
	         <div class="col-md-1" align="center">��ȸ��</div>
         </div> 
            
	</div>
	
		        
		<ul class="list-group"> 
		    
		<c:set var="i" value="0" />
		<c:forEach var="board" items="${list}">
		  	<li class="list-group-item">		
			<div class="row">
				<div class="col-md-2 text-default" align="left">${board.numbering}</div>
				<div class="col-md-6" align="left" style="display: flex; justify-content: left;">
				<b class="text-default" style="width: 400px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;"  id="${board.boardNo}">${board.boardTitle}<c:if test='${board.countComment > 0}'> [ ${board.countComment} ]</c:if></b>
				</div>
				<div class="col-md-2 " ><font class="text-default">${board.nickName}</font></div>
				<div class="col-md-1" align="left"><fmt:formatDate value="${board.regDate}" pattern="yyyy/MM/dd"/></div>
				<div class="col-md-1" align="center">${board.hits}</div>
			</div>
			</li>
		</c:forEach>
		
		</ul>
		
	</div>
	
	<jsp:include page="/view/common/pageNavigator.jsp" />
            
	</div>
	</div>
	
</body>
</html>