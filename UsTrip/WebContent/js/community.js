function boardList(con){
	 $.ajax("/community/getCommunityListJSON/"+con,{
			method : "GET" ,
			dataType : "json" ,
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(J , status) { 
				
				$('#body').empty();

				var list = '';				
				for(var i in J.board){
					var regdate = new Date(J.board[i].regDate).format("yyyy/MM/dd");
					 var adid = '';
					 var adchar = '';
					list = list+
				'<li class="list-group-item"><div class="row" >'+
				'<div class="panel-heading">'+                
				'<div class="row">'+
		         '<div class="col-md-2" align="left">'+J.board[i].boardNo+'</div>'+
		         '<div class="col-md-6" align="left" style="display: flex; justify-content: left;"><b style="width: 400px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;" id="'+J.board[i].boardNo+'">'+J.board[i].boardTitle+'</b></div>'+
		         '<div class="col-md-2" align="left"><c>'+J.board[i].nickName+'</c></div>'+
		         '<div class="col-md-1" align="left">'+regdate+'</div>'+
		         '<div class="col-md-1" align="center">'+J.board[i].hits+
		         '</div></li>'
	             '<div id="'+J.board[i].boardNo+'" class="panel-collapse collapse"><div class="panel-body">'+
	             '<div class="row"><div class="col-md-4">'+
	             '<img src="http://cfile29.uf.tistory.com/image/2162AF34573DC7E42789C1" style="height:400px; width:350px;">'+
	             '</div><div class="col-md-8">'+
         		J.board[i].boardContent+
         		'</div></div><hr/><div id="appendcom"><h6 align="right">'+
         		J.board[i].countComment+'  개의 댓글이 달려있습니다.'+
				'</h6>'+
				'<div id="'+J.board[i].boardNo+'c"></div>'+
				'<hr/>'+ 
                '<h4><i class="fa fa-paper-plane-o"></i>댓글작성</h4>'+        
                '<textarea class="form-control" rows="3"  id="'+J.board[i].boardNo+'cal" maxlength="200"></textarea>'+
                '<div>200 / <span id="'+J.board[i].boardNo+'chars">200</span><button class="comment-btn " style="margin-top:10px; float: right;" >댓글등록</button></div><br/><br/>'+
                '</div></div></div>'
                '<script type="text/javascript">'+
                'var maxLength = 200;'+					
					 'for(var i in J.board){'+
						 'adid= #'+J.board[i].boardNo+'cal;'+
						 'adchar = #'+J.board[i].boardNo+'chars;'+
				     '$(adid).keyup(function() {'+
				       'var length = $(this).val().length;'+
				       'var length = maxLength-length;'+
				       '$(adchar).text(length);'+
				     '});}</script>'
				}
				
				$('#body').html(list);
				for(var i in J.board){
					if(J.board[i].countComment > 0) {
						var find = '#'+J.board[i].boardNo;;
						var count = ' ['+J.board[i].countComment+']';
						$(find).append(count);
					}
					}		
				
				selectCate();
				
			}//success 끝						
							})//ajax끝
}//function 끝

function selectCate(){
	
	$('li').hover(function(){
		if($('#board').attr('class') == 'panel panel-info'){
			$(this).css('background-color','lightblue');
		}else{
			$(this).css('background-color','PeachPuff ');
		}
	},function(){
		$(this).css('background-color','white');
	});
	
	$('b').hover(function(){
		$(this).css('color','white');
	},function(){
		$(this).css('color','black');
	});
	
	$('b').on('click',function(){
		
		var objectID=$(this).attr('id');
		
		alert(objectID);
	        });
	
	$('c').on('click',function(){
		var adad = $(this).text();
		alert(adad);
	});	
	
	$('c').hover(function(){
		$(this).css('color','white');
	},function(){
		$(this).css('color','black');
	});
}

function countChar(J){
	 var maxLength = 200;
	 var adid = '';
	 var adchar = '';
	 for(var i in J.board){
		 adid= '#'+J.board[i].boardNo+'cal';
		 adchar = '#'+J.board[i].boardNo+'chars';
     $(adid).keyup(function() {
       var length = $(this).val().length;
       var length = maxLength-length;
       $(adchar).text(length);
     });
	 }
}

function comment(J){
	
	var comid = '';
	
	for(var i in J.board){
		comid = '#'+J.board[i].boardNo+'c';
		var ment = '';
		for(var j in J.board[i].myComment){
			var regCom = new Date(J.board[i].myComment[j].regDate).format("yyyy/MM/dd");
			var ment = ment+
			'<hr class="thick-line"><div class="row">'+
            '<div class="col-md-1"><img class="img-circle" src="http://cfile29.uf.tistory.com/image/2162AF34573DC7E42789C1" style="float:left; margin:12px 12px 20px 0; height:90px; width:80px;"></div>'+
            '<div class="col-sm-10"><strong style="font-size: 20px;">'+
            J.board[i].myComment[j].nickName+
            '</strong><div style="margin-top:8px;">'+
            J.board[i].myComment[j].commentContent+
            '</div></div>'+
            '<div class="col-md-1" align="right"><i class="glyphicon glyphicon-edit"></i> / <i class="glyphicon glyphicon-remove"></i><h6 align="right">'+
            regCom+
            '</h6></div></div>';
		}	
		$(comid).html(ment);	
	}
	
}