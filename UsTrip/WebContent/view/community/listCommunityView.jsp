<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.4/sweetalert2.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.4/sweetalert2.min.css">
	
	<script src="/js/community.js"></script>
	<script src="/js/dateFormat.js"></script>
	
	<script>
	$(function () {	
	 	  mentor();
        $('#men').on('click',function(){
        	mentor();
        });
        
        $('#part').on('click',function(){
        	party();
        });   
        
        $('#expandAll').on('click',function(){
            
            $('b').each(function(){
                var objectID=$(this).attr('id');
                if($(objectID).hasClass('in')===false)
                {
                     $(objectID).collapse('show');
                }
            });
        });
        
        $('#collapseAll').on('click',function(){
            
            $('b').each(function(){
                var objectID=$(this).attr('id');
                $(objectID).collapse('hide');
            });
        });       
        
       var maxLength = 200;
        $('textarea').keyup(function() {
          var length = $(this).val().length;
          var length = maxLength-length;
          $('#chars').text(length);
        }); 
               
});
  </script>
  <style type="text/css">
   body {
            padding-top : 50px;
        }
       
        </style>
</head>
<body>
        <div class="container">
        <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#home" id="men">멘토링</a></li>
    <li><a data-toggle="tab" href="#menu1" id="part">동행구하기</a></li>   
  </ul>
  		<div class="row">
        <div class="col-md-12">
            <div class="pull-right">
             <a id="expandAll" href="#" class="btn btn-default" role="button">Expand All</a>
             <a id="collapseAll" href="#" class="btn btn-default" role="button">Collapse All</a>
            </div><br/>
        </div></div>
        
             <div class="panel-group" style="margin-top:50px;">
             <div class="row" >
	         <div class="col-md-1" align="left" style="margin-left:10px;"><h4>번호</h4></div>
	         <div class="col-md-5" align="center"><h4>제목</h4></div>
	         <div class="col-md-2" align="left" ><h4>닉네임</h4></div>
	         <div class="col-md-2" align="left"><h4>등록일짜</h4></div>
	         <div class="col-md-1" align="left"><h4>조회수</h4></div>
	         </div><div id="body">
          <!--   여기부터 반복구간 -->
         
               <!--  <div class="panel panel-default">
                    <div class="panel-heading">
                     <div class="row">
			         <div class="col-md-1" align="left">번호</div>
			         <div class="col-md-5" align="center"><b id="#collapseThree">Collapsible Group Item #3</b></div>
			         <div class="col-md-2" align="left" style="margin-left:13px;">닉네임</div>
			         <div class="col-md-2" align="left" style="margin-left:5px;">등록일짜</div>
			         <div class="col-md-1" align="left" style="margin-left:5px;">조회수</div>
			         </div>
                              
</div>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse">
                        <div class="panel-body">
                        <div class="row">
						  <div class="col-md-4"><img src="http://cfile29.uf.tistory.com/image/2162AF34573DC7E42789C1" style="margin:12px 12px 20px 0; height:400px; width:350px;"></div>
						  <div class="col-md-8">Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry
                            richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard
                            dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf
                            moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla
                            assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore
                            wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher
                            vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic
                            synth nesciunt you probably haven't heard of them accusamus labore sustainable
                            VHS.</div>
						</div>
						
						<hr/>
                            <div id="appendcom">                                  
                                     <h6 align="right">22개의 댓글이 있습니다.</h6>
                                      </div>
                            
                            <hr class="thick-line">
                            <div class="row">
                             <div class="col-md-1"><img class="img-circle" src="http://cfile29.uf.tistory.com/image/2162AF34573DC7E42789C1" style="float:left; margin:12px 12px 20px 0; height:90px; width:80px;"></div>
                            <div class="col-sm-10">
                            <strong style="font-size: 20px;">배인호</strong>
                            <div style="margin-top:8px;">김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김김</div>               
                            </div>
                             <div class="col-md-1" align="right"><i class="glyphicon glyphicon-edit"></i> / <i class="glyphicon glyphicon-remove"></i><h6 align="right">2017.05.15</h6>
                             </div>
                            </div>                         
                            
                            <hr/> 
                            <h4><i class="fa fa-paper-plane-o"></i>댓글작성</h4>        
                            <div><textarea class="form-control" rows="3"  id="textareaChars" maxlength="200"></textarea>
                            200 / <span id="chars">200</span> 글자 남았습니다.<button class="comment-btn " style="margin-top:10px; float: right;" >댓글등록</button></div>
                                                                
                </div>
            </div>
        </div> -->
         <!--반복구간끝-->
        </div>
        </div>
        </div>
			
</body>
</html>