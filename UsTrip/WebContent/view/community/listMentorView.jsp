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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>
	
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
		
		$('li').hover(function(){			
			$(this).css('background-color','lightblue');		
		},function(){
			$(this).css('background-color','white');
		});
		
		$('b').hover(function(){
			$(this).attr('class','text-primary');
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
			/* alert(adad); */
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
			alert();
		});
		
		$('#orderby').hover(function(){
			$(this).attr('class','col-md-1 text-warning');
		},function(){
			$(this).attr('class','col-md-1');
		});
		
		$('font').hover(function(){
			$(this).attr('class','text-primary');
		},function(){
			$(this).attr('class','text-default');
		}); 
		
		$('#men').on('click',function(){
			$('#searchKeyword').val(null);
        	$('#searchCondition').val(null);
			fncGetList(1);
        });
        
        $('#part').on('click',function(){
        	$('#searchKeyword').val(null);
        	$('#searchCondition').val(null);
        	$('#boardCategory').val(1);
        	fncGetList(1);
        }); 
        
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
	            	$('#boardCategory').val('0');
	            	fncGetList(1);
	            }else if(key == '2'){
	            	swal({
	            		  title: userId+'님의 \n여행페이지로 이동하시겠습니까?',
	            		  text: userId+"님의 여행페이지로가서 다른여행도 구경해보세요",
	            		  type: 'question',
	            		  showCancelButton: true,
	            		  confirmButtonColor: '#3085d6',
	            		  cancelButtonColor: '#d33',
	            		  confirmButtonText: '간다'
	            		}).then(function () {
	            		  swal(
	            		    '성공!',
	            		    '페이지가 완성되면 연결합니다.',
	            		    'success'
	            		  )
	            		})
	            }else{
	            	swal({
	            		  title: userId+' 님을\n Follow 하시겠습니까?',
	            		  text: userId+" 님을 Follow해서 여행을 함께하세요!",
	            		  type: 'question',
	            		  showCancelButton: true,
	            		  confirmButtonColor: '#3085d6',
	            		  cancelButtonColor: '#d33',
	            		  confirmButtonText: 'Follw'
	            		}).then(function () {
	            			//ajax으로 follow추가
	            			swal({
	            				  title: userId+'님을 Follow를 했습니다',
	            				  text: "Follow화면으로 가시겠습니까?",
	            				  type: 'success',
	            				  showCancelButton: true,
	            				  confirmButtonColor: '#3085d6',
	            				  cancelButtonColor: '#d33',
	            				  confirmButtonText: '간다'
	            				}).then(function () {
	            				  swal(
	            				    '성공!',
	            				    '마이페이지 완성되면 그쪽으로 보냅니다..',
	            				    'success'
	            				  )
	            				})
	            		})
	            }
	        },
	        items: {
	            "1": {name: "작성자의 글 모두보기"},
	            "2": {name: "작성자의 여행페이지로"},
	            "3": {name: "작성자를 Follow 하기"}
	        }
	    });
	}
	
	function today(){

		var date = new Date();
		 
	    var year = date.getFullYear(); //년도
	    var month = date.getMonth()+1; //월
	    var day = date.getDate(); //일
	 
	    if ((day+"").length < 2) {       // 일이 한자리 수인 경우 앞에 0을 붙여주기 위해
	        day = "0" + day;
	    }
	    
	    if ((month+"").length < 2) {       // 일이 한자리 수인 경우 앞에 0을 붙여주기 위해
	    	month = "0" + month;
	    }
	 
	    var getToday = year+"/"+month+"/"+day;
		
		return getToday;
		
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
			 background-image:url('http://www.gaviota.kr/xe/files/attach/images/58/700/007/131024%EA%B2%BD%EB%B3%B5%EA%B6%8118.jpg' );
			 background-size: cover;
			 background-position: center center ;
			 height:400px;
			 opacity: 0.8;">
						 
	  <h1 style="color:white;">멘토링 게시판</h1>
	  <p style="color:white; margin-top:130px;">계획한 여행의 모든것을 물어보세요!</p>
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
    <div class="row">
    	<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
    <div class="col-md-6 text-right" >
    <form class="form-inline" name="detailForm" id="searchForm">
	    <select class="form-control" name="searchCondition"  id="c"   style="width:130px;">
		  <option value="0" ${ (search.searchCondition=="0" ? "selected" : "")}>게시물 번호</option>
		  <option value="1" ${ (search.searchCondition=="1" ? "selected" : "")}>게시물 제목</option>
		  <option value="2" ${ (search.searchCondition=="2" ? "selected" : "")}>작성자 이름</option>
		</select>
	
		<input style="width:250px;" type="text" class="form-control" id="searchKeyword" name="searchKeyword" 
		 placeholder="검색조건을 선택하고 검색하세요." value="${! empty search.searchKeyword ? search.searchKeyword : '' }" >
	    <input type="hidden" id="currentPage" name="currentPage" value=""/>  
	    <input type="hidden" id="boardCategory" name="boardCategory" value="0"/>
	    <input type="hidden" id="order" name="order" value=""/>
		<button class="btn btn-primary" type="button" id="search">검색</button>
		</form>
    	</div>
    </div>
    
    <!-- /input-group -->
	<div class="panel panel-info" id="board">
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