<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
   
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">		
		
		    $(function() {		    		
		    	
		    	$("#add").on("click" , function() {
		    		 $( "#addconfirm" ).dialog( "open" )
		    	})
		    	
		    	$( '#datepicker1' ).pickadate({		
								format: 'yyyy/mm/dd'
					        })
		    	
                /////////////////////수정페이지 모달팝업 가져오는창 
		    	 var innerlog;
		     	
		    	 innerlog = $( "#addform" ).dialog({
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
		            "확 인": function() {
		            	
		            	$.ajax( {type:"POST",  
		            	        url:"/asset/updateAssetJSON",
							data:{
								travNo:$("#travNo").val(),
								blogNo:$("#blogNo").val(),
								assetCategory:$("#category").val(),	  
								usage:$("#usage").val(),	  		
								charge:$("#charge").val(),	 
								visitDate:	$("#datepicker1").val()
							}			
											})
						innerlog.dialog( "close" );	
		            	window.setTimeout("newGraph()", 1000);	            	
		            },
		            "취 소": function() {
		            	innerlog.dialog( "close" );
		            }
		          }
		        });
		    	 ////////////////////////// 수정페이지 이벤트 끝
		    	 
		     	//////////////////////////수정혹은 삭제 확인 메세지	    	
		    	$( "#addconfirm" ).dialog({
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
		    	          "작성한다": function() {
		    	        	  
		    	        	  $( this ).dialog( "close" );  	        	 
		    		     		    	        	
		    	        	  innerlog.dialog( "open" );
		    	        	            
		    	            
		    	          },
		    	          "취 소": function() {
		    	            $( this ).dialog( "close" );
		    	          }
		    	        }
		    	    });
		     	////////////////////////////////////확인 메시지 끝		    			    	   					
		    		});		  
	</script>


	<div id="addconfirm" title="가계부 추가">
  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>여행중 사용한 가계부를 작성하시겠습니까?</p>
</div>	


	<!-- 테스트용으로 사용중인 버튼 완성되면 가계부 추가에 이벤트를 걸어준다 -->
<!-- <button id="create-user">Create new user</button> -->
<div id="addform" title="가계부 추가">
   
  <form >
    <fieldset>
     <div class="container-fluid">  
  <div class="row">
    <div class="col-sm-4" >    
      <label>여행</label><br/>
      <input type="text"  id="plan" value="Jane Smith" class="text ui-widget-content ui-corner-all"><br/><br/> <!-- 나중에 컨트롤러에 plan쪽 정보를 인젝션시켜서 ajax로 가져올수있도록하고 select 바로 선택할수있게 바꿔준다 -->
      <label>블로그</label><br/>
      <input type="text"  id="plan" value="배인호" class="text ui-widget-content ui-corner-all"><br/><br/>
      </div>      
      
    <div class="col-sm-4" >
    <label>사용날짜</label><br/>
    <input id="datepicker1" class="text ui-widget-content ui-corner-all"  value=""><br/><br/>
     <label>사용내용</label><br/>
      <input type="text"  id="usage" value="xxxxxxx" class="text ui-widget-content ui-corner-all"><br/><br/>
    </div>    
    
    <div class="col-sm-4" >
    <label>사용분류</label><br/>
      <select id="category">
      <option>선택하세요</option>
   	  <option value="식비">식비</option>
      <option value="교통비">교통비</option>
      <option value="숙박비">숙박비</option>
      <option value="입장료">입장료</option>
      <option value="쇼핑">쇼핑</option>
      <option value="기타">기타</option>
      </select><br/><br/>     
      <label>사용금액</label><br/>
      <input type="text"  id="charge" value="xxxxxxx" class="text ui-widget-content ui-corner-all"><br/><br/>
    </div>             
    
  </div>
</div>
    </fieldset>
  </form>
</div>
