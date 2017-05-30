<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
	<script type="text/javascript">
///////////////////////////////가계부 수정을 묻는 버튼에 이벤트
			function conform(conAssetNo){
				
				$("#assetNo").val(conAssetNo);
				
				 swal({
				        title: '가계부 수정',
				        type: 'info',
				        html: "여행중 사용한 가계부를<br/><strong>수정</strong> 또는 <strong>삭제</strong>하시겠습니까?" +
				            "<br/><br/><br/>" +
				            ' <button type="button" id="okdel" class="btn btn-info">' + '<strong>수 정</strong>' + '</button>' +
				            ' <button type="button" id="condel" class="btn btn-danger">' + '<strong>삭 제</strong>' + '</button>'+
				            ' <button type="button" id="candel" class="btn btn-warning">' + '<strong>Cancle</strong>' + '</button>',
				        showCancelButton: false,
				        showConfirmButton: false
				    });
	    		 
	    		 $( "#condel" ).on("click" , function() {
			    		swal({
			    			  title: '정말로 삭제하시겠습니까?',
			    			  text: "삭제한 데이터는 되돌릴수 없습니다.",
			    			  type: 'warning',
			    			  showCancelButton: true,
			    			  confirmButtonColor: '#3085d6',
			    			  cancelButtonColor: '#d33',
			    			  confirmButtonText: '삭제합니다!'
			    			}).then(function () {
			    			  var asno = $("#assetNo").val();
			    			 
								$.ajax("/asset/deleteAssetJSON/"+asno,{
									method : "GET" ,
									dataType : "json" ,
									headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
									}								
								})		
								
			    			  swal(
			    			    '삭 제!',
			    			    '선택하신 소비내역이 삭제되었습니다.',
			    			    'success'
			    			  )
								window.setTimeout("newGraph("+4/* trvNo를 넣어준다 */+")", 1000);	
			    			})
					});
	    		 
	    		 $( "#candel" ).on("click" , function() {
	    			 swal(
	    					  '취소...',
	    					  '가계부 수정 또는 삭제를 취소하셨습니다!',
	    					  'error'
	    					)
	    		 });
	    		 
	    		 $( "#okdel" ).on("click" , function() {
	    			 swal({
					        title: '가계부 수정',
					        width: 800,
					        background: '#fff url(https://icons.wxug.com/data/wximagenew/s/skyguy4/100-800.jpg)',
					        html: 
   ' <div class="col-sm-4">'+    
      '<label>여행</label><br/>'+
     ' <b  id="plan" ></b><br/><br/> '+
     ' </div>   '+   
   ' <div class="col-sm-4">'+
    '<label>사용날짜</label><br/>'+
    '<input id="datepicker" class="text ui-widget-content ui-corner-all"  value=""><br/><br/><br/><br/>'+
     '<label>사용내용</label><br/>'+
      '<input type="text"  id="usage" value="xxxxxxx" class="text ui-widget-content ui-corner-all" autofocus><br/><br/>'+
   ' </div>   '+ 
    '<div class="col-sm-4">'+
    '<label>사용분류</label><br/>'+
      '<select id="category">'+
   	  '<option value="식비">식비</option>'+
      '<option value="교통비">교통비</option>'+
     ' <option value="숙박비">숙박비</option>'+
      '<option value="입장료">입장료</option>'+
      '<option value="쇼핑">쇼핑</option>'+
    '  <option value="기타">기타</option>'+
      '</select><br/><br/><br/><br/> '+    
     ' <label>사용금액</label><br/>'+
      '<input type="text"  id="charge" value="xxxxxxx" class="text ui-widget-content ui-corner-all"><br/><br/>'+
   ' <br/><br/><br/><br/><br/><br/><br/></div> '+  
' <div><button type="button" id="conupdate" class="btn btn-info">' + '<strong>수 정</strong>' + '</button>' +
' <button type="button" id="canupdate" class="btn btn-danger">' + '<strong>Cancle</strong>' + '</button></div>',
					        showCancelButton: false,
					        showConfirmButton: false
					    });
	    			 updateAsset(conAssetNo); 
	    			 
	    			 $( "#conupdate" ).on("click" , function() {
	    				 $.ajax( {type:"POST",  
		            	        url:"/asset/updateAssetJSON",
							data:{
								travNo:$("#travNo").val(),
								assetNo:$("#assetNo").val(),
								blogNo:$("#blogNo").val(),
								assetCategory:$("#category").val(),	  
								usage:$("#usage").val(),	  		
								charge:$("#charge").val(),	 
								visitDate:	$("#datepicker").val()
							}			
											})
											swal(
												  '수정되었습니다!',
												  '변경된 정보를 확인하세요!',
												  'success'
												)
		            	window.setTimeout("newGraph("+4/* trvNo를 넣어준다 */+")", 1000);	
		    		 });
	    			 
	    			 $( "#canupdate" ).on("click" , function() {
	    				 swal(
		    					  '취소...',
		    					  '가계부 수정 또는 삭제를 취소하셨습니다!',
		    					  'error'
		    					)
		    		 });
	    			 
	    		 });
	    	
				}
	    	////////////////////////////////이벤트걸기끝
		    
		    /////////////////////////ajax 시작 asset class를 하나 불러와 빈칸에 체워넣어준다.
		    function updateAsset(conAssetNo){	    				   
				$.ajax("/asset/getAssetOneJSON/"+conAssetNo,{
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(J , status) {
							var startDate = new Date(J.asset.startDate).format("yyyy/MM/dd");
							var endDate = new Date(J.asset.endDate).format("yyyy/MM/dd");
								
							$("#plan").html(J.asset.travTitle);
							$("#travNo").val(J.asset.travNo);
							$("#assetNo").val(J.asset.assetNo);
							$("#blogNo").val(J.asset.blogNo);
							$("#category").val(J.asset.assetCategory);	  
							$("#usage").val(J.asset.usage);	  		
							$("#charge").val(J.asset.charge);	 
							$("#datepicker").val(new Date(J.asset.visitDate).format("yyyy/MM/dd"));
							$( '#datepicker' ).pickadate({		
								format: 'yyyy/mm/dd',
								min: startDate,
								max: endDate
					        });
							
							}								
					})
		    }
	    	 ////////////////////////////////////ajax 끝		 
		  
	</script>

<input type="hidden" id="assetNo" value="">
<input type="hidden" id="travNo" value="">
<input type="hidden" id="blogNo" value="">