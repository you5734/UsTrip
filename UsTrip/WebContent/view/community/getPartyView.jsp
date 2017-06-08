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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>
	
	<script>
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("#searchForm").attr("method" , "POST").attr("action" , "/community/listCommunity").submit();
	}
	
	$(function () {	
		
		var select = '#'+'${board.boardNo}';
		
		$(select).css('color','red')
		
		var current ='${resultPage.currentPage}';
		
		if('${search.order}' == 'DESC'){
			$('#simbol').attr('class','glyphicon glyphicon-arrow-up');
		}else{
			$('#simbol').attr('class','glyphicon glyphicon-arrow-down');
		}
		
		$('#search').on("click" , function() {
			fncGetList(1);
		});
		
		$('li').hover(function(){			
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
			$("#currentPage").val('${resultPage.currentPage}');
			$("form").attr("method" , "POST").attr("action" , "/community/getBoard?boardNo="+objectID).submit();
		        });
		
		$('font').on('click',function(){
			var adad = $(this).text();
			alert(adad);
		});	
		
		$('#orderby').on('click',function(){		
			if('${search.order}' == 'DESC'){
				$('#order').val('ASC');
				orderRe()
			}else{
				$('#order').val('DESC');
				orderRe()
			}
		});	
		
		$('#write').on('click',function(){
			alert();
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
        
        $('#tossComment').hover(function(){
			$(this).attr('class','col-md-6 text-right text-danger');
		},function(){
			$(this).attr('class','col-md-6 text-right text-warning');
		});
        
        $('#tossComment').on('click',function(){
	        var position = $('#topComment').offset(); // 위치값
	        $('html,body').animate({ scrollTop : position.top }, 500); // 이동
        }); 
        
        $( "#goSubmit" ).on('click',function(){
       	 var check = $('textarea').val().length;
       	var form = $('#addComment').serialize();
       	if(check == null || check<1){
       		swal(
       				  '댓글을 적지않으셨네요',
       				  '댓글을 작성한후 클릭해주세요',
       				  'error'
       				);				
			}else{
				
				$.ajax( {type:"POST",  
	    	        url:"/community/addCommentJSON",
				data:form,
		        success : re()
								});
			}               	    	
       });
        $('.glyphicon.glyphicon-edit').hover(function(){
			$(this).attr('class','glyphicon glyphicon-edit text-danger');
		},function(){
			$(this).attr('class','glyphicon glyphicon-edit');
		});
        
        $('.glyphicon.glyphicon-remove').hover(function(){
			$(this).attr('class','glyphicon glyphicon-remove text-danger');
		},function(){
			$(this).attr('class','glyphicon glyphicon-remove');
		}); 
        
        $( '.glyphicon.glyphicon-edit' ).on('click',function(){
        	var temp = $(this).attr('temp');
        	alertUpdate(temp);
        });
        
        $( '.glyphicon.glyphicon-remove' ).on('click',function(){
        	var temp = $(this).attr('temp');
        	alertRemove(temp)
        });
               
   });
   	
   	function re(){		
   		var fun = '$("#currentPage").val("${resultPage.currentPage}");'+
   		'$("form").attr("method" , "POST").attr("action" , "/community/getBoard?boardNo="+"${board.boardNo}").submit();';
   		window.setTimeout(fun, 2000);
   	}
   	
   	function alertUpdate(temp){
   		swal({
   		  title: '댓글을 수정하시겠습니까?',
   		  text: "등록일짜는 수정할수없습니다",
   		  type: 'warning',
   		  showCancelButton: true,
   		  confirmButtonColor: '#3085d6',
   		  cancelButtonColor: '#d33',
   		  confirmButtonText: '수정합니다',
   		  cancelButtonText: '취소합니다',
   		  confirmButtonClass: 'btn btn-primary',
   		  cancelButtonClass: 'btn btn-danger',
   		  buttonsStyling: false
   		}).then(function () {
   			$.ajax("/community/oneCommentJSON/"+temp,{
				method : "GET" ,
				dataType : "json" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(J , status) {
					updateForm(J,temp)
		        }
   			});
											
		
   			
   		  /* swal(
   		    '수정성공',
   		    '선택하신 댓글이 수정되었습니다',
   		    'success'
   		  ) */
   		}, function (dismiss) {
   		  // dismiss can be 'cancel', 'overlay',
   		  // 'close', and 'timer'
   		  if (dismiss === 'cancel') {
   		    swal(
   		      '취소',
   		      '댓글수정을 취소하셨습니다',
   		      'error'
   		    )
   		  }
   		})
   	}
   	
   	function alertRemove(temp){
   		swal({
   		  title: '정말 삭제하시겠습니까?',
   		  text: "삭제된 댓글은 복구할수없습니다",
   		  type: 'warning',
   		  showCancelButton: true,
   		  confirmButtonColor: '#3085d6',
   		  cancelButtonColor: '#d33',
   		  confirmButtonText: '삭제합니다',
   		  cancelButtonText: '취소합니다',
   		  confirmButtonClass: 'btn btn-primary',
   		  cancelButtonClass: 'btn btn-danger',
   		  buttonsStyling: false
   		}).then(function () {   			
   			$.ajax({url:"/community/deleteCommentJSON/"+temp	});
   			
   		  swal(
   		    '삭제되었습니다.',
   		    '작성하셨던 댓글이 삭제되었습니다.',
   		    'success'
   		  )
   		  re()
   		}, function (dismiss) {
   		  // dismiss can be 'cancel', 'overlay',
   		  // 'close', and 'timer'
   		  if (dismiss === 'cancel') {
   		    swal(
   		      '취소',
   		      '댓글삭제를 취소하셨습니다.',
   		      'error'
   		    )
   		  }
   		})
   	}
   	
   	function orderRe(){
   	$("#currentPage").val("${resultPage.currentPage}");
	$("form").attr("method" , "POST").attr("action" , "/community/getBoard?boardNo="+"${board.boardNo}").submit();
   	}
   	
   	function updateForm(J,temp){
   		var huck = '#'+temp;
			var updateHuck = '<div class="alert alert-success" >'+
		'<div class="row">'+
			'<div class="col-md-6 text-left">'+
				'<h3 class="text-primary" >수정</h3>'+  
			'</div>'+    
			'<div class="col-md-6 text-right">'+
				'<label class="btn btn-success">'+
					'<input type="checkbox" autocomplete="off" name="privateComment" value="1" id="private"> 비밀댓글'+
					'</label>'+
			'</div>'+
		'</div>'+
			'<textarea class="form-control" rows="5" maxlength="200" name="commentContent" id="updateText" >'+J.result.commentContent+'</textarea>'+
			'<div>200 / <span id="upChars">200</span><div class="btn btn-success" style="margin-top:10px; float: right;" id="goUpdate">댓글수정</div></div>'+
		'<br/><br/>'+
		'</div>';
				$(huck).html(updateHuck);
				if(J.result.privateComment == 1){
					$('#private').attr('checked','checked');
				}	
				 var maxlength = 200;
				    $('#updateText').keyup(function() {
				      var length = $(this).val().length;
				      var length = maxlength-length;
				      $('#upChars').text(length);
				    }); 
				$( "#goUpdate" ).on('click',function(){
					 swal(
					   		    '수정성공',
					   		    '선택하신 댓글이 수정되었습니다',
					   		    'success'
					   		  ) 
					   		updateSubmit(temp)
				});
				 				
   	}
   	
   	function updateSubmit(temp){
   		
   	 var check = $('#updateText').val().length;
   	 
   	var updateCotent = $('#updateText').text();
   	var updatePrivate = $('#private').is(':checked');
   	var flag;
   	
   	if(updatePrivate == true){
   		flag = 1;
   	}else{
   		flag = 0;
   	}
   	if(check == null || check<1){
   		swal(
   				  '댓글을 적지않으셨네요',
   				  '댓글을 작성한후 클릭해주세요',
   				  'error'
   				);				
		}else{
			
			$.ajax( {type:"POST",  
    	        url:"/community/updateCommentJSON",
			data:{
				commentNo:temp,
				privateComment:flag,
				commentContent:updateCotent
			},
	        success : re()
							}); 
		}    
   	   		
   	}
   	
  </script>
  <style type="text/css">
  body{font-family: "arial", dotum, "굴림", gulim, arial, helvetica, sans-serif;}
  </style>
  </head>
<body>

<jsp:include page="/view/common/toolbar.jsp" />

	<div class="container" >
	
		<div class="jumbotron" 
			style="margin-top:150px;
			 background-image:url('http://cfile1.uf.tistory.com/image/1462BE384FFD98AE042149' );
			 background-size: cover;
			 background-position: center bottom ;
			 height:400px;
			 opacity: 0.8;">
						 
	  <h1 style="color:white;">동행구하기 게시판</h1>
	  <p style="color:white; margin-top:130px;">같이 여행할 동행을 구해보세요!</p>
		</div> 
	</div>

	<div class="row" >
		<div class="col-md-2" style="margin-left:60px; margin-top:34px;">        
			<div class="list-group">
				<a class="list-group-item list-group-item-info" id="men" style="font-size:20px;"><i class="glyphicon glyphicon-star"></i> 멘토링</a>
				<a class="list-group-item list-group-item-warning" id="part" style="font-size:20px;"><i class="glyphicon glyphicon-heart"></i> 동행구하기</a>
				<a class="list-group-item list-group-item-success" id="write" style="font-size:20px;"><i class="glyphicon glyphicon-list-alt"></i> 게시글작성</a> 
			</div>        
		</div>
    <div class="col-md-9" style="margin-left:10px;">
    
    <!-- 게시판 디테일 페이지  -->
    <div class="row" style="margin-top:34px;">
    <div class="col-md-12" >
    
    <div class="panel panel-warning" >
		<div class="panel-heading">
                     
       	<div class="row" >
	         <div class="col-md-2" align="left" style="font-size : 15px; line-height : 1.6; font-weight : bolder;">[ 멘토링 ]</div>
	         <div class="col-md-3" align="center" >작성일 : <fmt:formatDate value="${board.regDate}" pattern="yyyy/MM/dd"/></div>
	         <div class="col-md-3" align="center" ></div>
	         <div class="col-md-2" align="center" >작성자 : ${board.nickName}</div>
	         <div class="col-md-2" align="center">조회수 : ${board.hits}</div>
         </div> 
            
		</div>
	<div class="panel-body">
		<div class="row">
			<div class="col-md-6 text-left text-danger">${board.boardTitle}</div>
			<div class="col-md-6 text-right text-danger" id="tossComment"> 댓글 <i class="glyphicon glyphicon-comment"></i> : ${board.countComment}</div>
		</div>
	<hr/>
		<div class="row">
			<div class="col-md-4">
	             <img src="http://cfile29.uf.tistory.com/image/2162AF34573DC7E42789C1" style="height:400px; width:350px;">
	        </div>
	        <div class="col-md-8">${board.boardContent}</div>
	     </div>
	     <div id="topComment"></div>
	<hr/>
         <h6 align="right" >${board.countComment} 개의 댓글이 달려있습니다.</h6>		
				
				<c:set var="i" value="0" />
		<c:forEach var="comment" items="${comments}">
		
			<c:if test='${comment.privateComment==0}'>	
			<hr class="thick-line">
			<div id="${comment.commentNo}">
			<div class="row">
				<div class="col-md-1">
					<img class="img-circle" src="http://cfile29.uf.tistory.com/image/2162AF34573DC7E42789C1" style="float:left; margin:12px 12px 20px 0; height:90px; width:80px;">
				</div>
			<div class="col-sm-10">
				<strong style="font-size: 20px;" class="text-danger">${comment.nickName}</strong>
				<div style="margin-top:8px;">${comment.commentContent}</div>
			</div>
			<div class="col-md-1" align="right">
				<i class="glyphicon glyphicon-edit" temp="${comment.commentNo}"></i> / <i class="glyphicon glyphicon-remove" temp="${comment.commentNo}"></i>
				<h6 align="right"><fmt:formatDate value="${comment.regDate}" pattern="yyyy/MM/dd"/></h6>
			</div>
			</div>
			</div>
           </c:if>
           
           <c:if test='${comment.privateComment==1}'>	
           <div class="jumbotron alert alert-warning">
           <h3 align="center">비밀댓글입니다.</h3>
           </div>
           </c:if>
           
		</c:forEach>	
								
			<form id="addComment" >				
			<div class="alert alert-warning" >
			<div class="row">
    			<div class="col-md-6 text-left">
					<h3 class="text-danger" >댓글작성</h3>  
				</div>    
				<div class="col-md-6 text-right">
					<label class="btn btn-danger">
   					<input type="checkbox" autocomplete="off" name="privateComment" value="1"> 비밀댓글
  					</label>
				</div>
			</div>
				<textarea class="form-control" rows="5" maxlength="200" name="commentContent"></textarea>
				<div>200 / <span id="chars">200</span><div class="btn btn-danger" style="margin-top:10px; float: right;" id="goSubmit">댓글등록</div></div>
			<br/><br/>
			</div>
			<input type="hidden" name="boardNo" value="${board.boardNo}"> 
			<input type="hidden" name="nickName" value="user001">            
            </form>              
                
	</div>
     </div>    
                
    </div>
    </div>
    <!--디테일페이지 끝 -->
       <hr/>
    <div class="row">
    	<div class="col-md-6 text-left">
		    	<p class="text-danger">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
    <div class="col-md-6 text-right" >
    <form class="form-inline" name="detailForm" id="searchForm">
	    <select class="form-control" name="searchCondition"  id="searchCondition" style="width:130px;">
		  <option value="0" ${ (search.searchCondition=="0" ? "selected" : "")}>게시물 번호</option>
		  <option value="1" ${ (search.searchCondition=="1" ? "selected" : "")}>게시물 제목</option>
		  <option value="2" ${ (search.searchCondition=="2" ? "selected" : "")}>작성자 이름</option>
		</select>
	
		<input style="width:250px;" type="text" class="form-control" id="searchKeyword" name="searchKeyword" 
		 placeholder="검색조건을 선택하고 검색하세요." value="${! empty search.searchKeyword ? search.searchKeyword : '' }" >
	    <input type="hidden" id="currentPage" name="currentPage" value=""/>  
	    <input type="hidden" id="boardCategory" name="boardCategory" value="1"/>
	    <input type="hidden" id="order" name="order" value=""/>
		<button class="btn btn-danger" type="button" id="search">검색</button>
		</form>
    	</div>
    </div>
    
    <!-- /input-group -->
 
	<div class="panel panel-warning" id="board">
	 <div class="panel-heading">
                     
       <div class="row" >
	         <div class="col-md-2" align="left" >번호</div>
	         <div class="col-md-6" align="center">제목</div>
	         <div class="col-md-2" align="center" >작성자</div>
	         <div class="col-md-1" align="center" id="orderby">등록일 <i id ="simbol" class="glyphicon glyphicon-arrow-up"></i></div>
	         <div class="col-md-1" align="center">조회수</div>
         </div> 
            
	</div>
	
		          
		<ul class="list-group"> 
		    
		<c:set var="i" value="0" />
		<c:forEach var="board" items="${list}">
		  	<li class="list-group-item">		
			<div class="row">
				<div class="col-md-2 text-default" align="left">${board.numbering}</div>
				<div class="col-md-6" align="left" style="display: flex; justify-content: left;">
				<b class="text-default" style="width: 400px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;"  id="${board.boardNo}">${board.boardTitle}<c:if test='${board.countComment > 0}'> [ ${board.countComment} ]</c:if></b>
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