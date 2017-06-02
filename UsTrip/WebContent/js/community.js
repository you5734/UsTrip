function mentor(){
	 $.ajax("/community/getCommunityListJSON/0",{
			method : "GET" ,
			dataType : "json" ,
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(J , status) { 
				
			$('#event').remove();
				var list = '';
				for(var i in J.board){
					list = list+
				'<div class="panel panel-default" id="event">'+
				'<div class="panel-heading">'+                
                '<b id="#'+J.board[i].boardNo+'" >'+
	             J.board[i].boardTitle+' ['+J.board[i].countComment+']'+
		         '</b></div>'+
	             '<div id="'+J.board[i].boardNo+'" class="panel-collapse collapse"><div class="panel-body">'+
	             '<div class="row"><div class="col-md-4">'+
	             '<img src="http://cfile29.uf.tistory.com/image/2162AF34573DC7E42789C1" style="height:400px; width:350px;">'+
	             '</div><div class="col-md-8">'+
         		J.board[i].boardContent+
         		'</div></div><hr/><div id="appendcom"><h6 align="right">'+
         		J.board[i].countComment+' Comments'+
				'</h6>'+
				'<div id="'+J.board[i].boardNo+'c"></div>'+
				'<hr/>'+ 
                '<h4><i class="fa fa-paper-plane-o"></i>Your Comment</h4>'+        
                '<textarea class="form-control" rows="3"  id="'+J.board[i].boardNo+'cal" maxlength="200"></textarea>'+
                '<div>200 / <span id="'+J.board[i].boardNo+'chars">200</span><button class="comment-btn " style="margin-top:10px; float: right;" >Comment</button></div>'+
                '</div></div></div>'
					
				}
				$('.panel-group').html(list);
				countChar(J);
				comment(J);
				selectCate();
			}						
							})
}

function party(){
	 $.ajax("/community/getCommunityListJSON/1",{
			method : "GET" ,
			dataType : "json" ,
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(J , status) { 
				$('#event').remove();
				var list = '';				
				for(var i in J.board){
					var reg = new Date(J.board[i].regDate);
					list = list+
				'<div class="panel panel-default" id="event">'+
				'<div class="panel-heading">'+                
                '<b id="#'+J.board[i].boardNo+'" >'+
	             J.board[i].boardTitle+' ['+J.board[i].countComment+']'+
		         '</b></div>'+
	             '<div id="'+J.board[i].boardNo+'" class="panel-collapse collapse"><div class="panel-body">'+
	             '<div class="row"><div class="col-md-4">'+
	             '<img src="http://cfile29.uf.tistory.com/image/2162AF34573DC7E42789C1" style="height:400px; width:350px;">'+
	             '</div><div class="col-md-8">'+
         		J.board[i].boardContent+
         		'</div></div><hr/><div id="appendcom"><h6 align="right">'+
         		J.board[i].countComment+' Comments'+
				'</h6>'+
				'<div id="'+J.board[i].boardNo+'c"></div>'+
				'<hr/>'+ 
                '<h4><i class="fa fa-paper-plane-o"></i>Your Comment</h4>'+        
                '<textarea class="form-control" rows="3"  id="'+J.board[i].boardNo+'cal" maxlength="200"></textarea>'+
                '<div>200 / <span id="'+J.board[i].boardNo+'chars">200</span><button class="comment-btn " style="margin-top:10px; float: right;" >Comment</button></div>'+
                '</div></div></div>'
					
				}
				$('.panel-group').html(list);
				countChar(J);
				comment(J);
				selectCate();
			}						
							})
}

function selectCate(){
	$('b').on('click',function(){
		
		var objectID=$(this).attr('id');
		
						if($(objectID).hasClass('in'))
						{
	                        $(objectID).collapse('hide');
					}
					
					else{
	                        $(objectID).collapse('show');
					}
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