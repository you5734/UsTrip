<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
	<script type="text/javascript">		
		
		    $(function() {		    		
		    	 
                /////////////////////수정페이지 모달팝업 가져오는창 
		    	 var innerlog;
		     	
		    	 innerlog = $( "#dialog-form" ).dialog({
		          autoOpen: false,
		          maxWidth:600,
                  maxHeight: 250,
                  width: 600,
                  height: 250,    
                  show: {
	    	          effect: "blind",
	    	          duration: 300
	    	        },
	    	        hide: {
	    	          effect: "blind",
	    	          duration: 300
	    	        },
		          modal: true,
		          buttons: {
		            "수 정": function() {
		            	
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
						innerlog.dialog( "close" );	
		            	window.setTimeout("newGraph("+4/* trvNo를 넣어준다 */+")", 1000);	            	
		            },
		            "취 소": function() {
		            	innerlog.dialog( "close" );
		            }
		          }
		        });
		    	 ////////////////////////// 수정페이지 이벤트 끝
		    	 
		     	//////////////////////////수정혹은 삭제 확인 메세지	    	
		    	$( "#dialog-confirm" ).dialog({
		    	      autoOpen: false,
		    	      modal: true,		
		    	      show: {
		    	          effect: "blind",
		    	          duration: 300
		    	        },
		    	        hide: {
		    	          effect: "blind",
		    	          duration: 300
		    	        },
		    	      buttons: {
		    	          "수 정": function() {
		    	        	  
		    	        	  $( this ).dialog( "close" );  	        	 
		    		     		    	        	
		    	        	  innerlog.dialog( "open" );
		    	        	            
		    	            
		    	          },
 						"삭 제": function() {
 							 
 						    if (confirm("정말로 삭제하십니까?!") == true) {
 						    	var asno = $("#assetNo").val();
 	 							$.ajax("/asset/deleteAssetJSON/"+asno,{
 	 								method : "GET" ,
 	 								dataType : "json" ,
 	 								headers : {
 	 									"Accept" : "application/json",
 	 									"Content-Type" : "application/json"
 	 								}
 	 							})		    	        	  
 			    	        	  $( this ).dialog( "close" );  	
 	 							window.setTimeout("newGraph("+4/* trvNo를 넣어준다 */+")", 1000);	
 						    } else {
 						    	 $( this ).dialog( "close" ); 
 						    }
 							     
		    	          },
		    	          "취 소": function() {
		    	            $( this ).dialog( "close" );
		    	          }
		    	        }
		    	    });
		     	////////////////////////////////////확인 메시지 끝		    			    	   					
		    		});		  
		    
///////////////////////////////가계부 수정을 묻는 버튼에 이벤트
			function conform(conAssetNo){
				$("#assetNo").val(conAssetNo);
				updateAsset(conAssetNo);  					
	    		 $( "#dialog-confirm" ).dialog( "open" );
	    	
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
							$("#travNo").val(J.asset.travNo);
							$("#assetNo").val(J.asset.assetNo);
							$("#blogNo").val(J.asset.blogNo);
							$("#category").val(J.asset.assetCategory);	  
							$("#usage").val(J.asset.usage);	  		
							$("#charge").val(J.asset.charge);	 
							$("#datepicker").val(new Date(J.asset.visitDate).format("yyyy/MM/dd"));
							$( '#datepicker' ).pickadate({		
								format: 'yyyy/mm/dd'
					        });
							
							}								
											})
		    }
	    	 ////////////////////////////////////ajax 끝		 
		  
	</script>


	<div id="dialog-confirm" title="가계부 수정">
  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>여행중 사용한 가계부를<br/><strong> 수정</strong> 또는<strong> 삭제</strong>하시겠습니까?</p>
</div>	


	<!-- 테스트용으로 사용중인 버튼 완성되면 가계부 추가에 이벤트를 걸어준다 -->
<!-- <button id="create-user">Create new user</button> -->
<div id="dialog-form" title="가계부 수정">
   
  <form >
    <fieldset>
     <div class="container-fluid">  
  <div class="row">
    <div class="col-sm-4" >    
      <label>여행</label><br/>
      <input type="text"  id="plan" value="Jane Smith" class="text ui-widget-content ui-corner-all"><br/><br/> <!-- 나중에 컨트롤러에 plan쪽 정보를 인젝션시켜서 ajax로 가져올수있도록하고 select 바로 선택할수있게 바꿔준다 -->
      
      </div>      
      
    <div class="col-sm-4" >
    <label>사용날짜</label><br/>
    <input id="datepicker" class="text ui-widget-content ui-corner-all"  value=""><br/><br/>
     <label>사용내용</label><br/>
      <input type="text"  id="usage" value="xxxxxxx" class="text ui-widget-content ui-corner-all"><br/><br/>
    </div>    
    
    <div class="col-sm-4" >
    <label>사용분류</label><br/>
      <select id="category">
   	  <option id="food" value="식비">식비</option>
      <option id="traffic" value="교통비">교통비</option>
      <option id="room" value="숙박비">숙박비</option>
      <option id="enterance" value="입장료">입장료</option>
      <option id="shopping" value="쇼핑">쇼핑</option>
      <option id="etc" value="기타">기타</option>
      </select><br/><br/>     
      <label>사용금액</label><br/>
      <input type="text"  id="charge" value="xxxxxxx" class="text ui-widget-content ui-corner-all"><br/><br/>
    </div>         
    
    <input type="hidden" id="assetNo" value="">
    <input type="hidden" id="travNo" value="">
    <input type="hidden" id="blogNo" value="">
    
  </div>
</div>
    </fieldset>
  </form>
</div>
