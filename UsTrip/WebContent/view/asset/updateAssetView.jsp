<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
	<script type="text/javascript">		
		
		    $(function() {		    		
		    	 
                /////////////////////���������� ����˾� ��������â 
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
		            "�� ��": function() {
		            	
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
		            	window.setTimeout("newGraph("+4/* trvNo�� �־��ش� */+")", 1000);	            	
		            },
		            "�� ��": function() {
		            	innerlog.dialog( "close" );
		            }
		          }
		        });
		    	 ////////////////////////// ���������� �̺�Ʈ ��
		    	 
		     	//////////////////////////����Ȥ�� ���� Ȯ�� �޼���	    	
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
		    	          "�� ��": function() {
		    	        	  
		    	        	  $( this ).dialog( "close" );  	        	 
		    		     		    	        	
		    	        	  innerlog.dialog( "open" );
		    	        	            
		    	            
		    	          },
 						"�� ��": function() {
 							 
 						    if (confirm("������ �����Ͻʴϱ�?!") == true) {
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
 	 							window.setTimeout("newGraph("+4/* trvNo�� �־��ش� */+")", 1000);	
 						    } else {
 						    	 $( this ).dialog( "close" ); 
 						    }
 							     
		    	          },
		    	          "�� ��": function() {
		    	            $( this ).dialog( "close" );
		    	          }
		    	        }
		    	    });
		     	////////////////////////////////////Ȯ�� �޽��� ��		    			    	   					
		    		});		  
		    
///////////////////////////////����� ������ ���� ��ư�� �̺�Ʈ
			function conform(conAssetNo){
				$("#assetNo").val(conAssetNo);
				updateAsset(conAssetNo);  					
	    		 $( "#dialog-confirm" ).dialog( "open" );
	    	
				}
	    	////////////////////////////////�̺�Ʈ�ɱⳡ
		    
		    /////////////////////////ajax ���� asset class�� �ϳ� �ҷ��� ��ĭ�� ü���־��ش�.
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
	    	 ////////////////////////////////////ajax ��		 
		  
	</script>


	<div id="dialog-confirm" title="����� ����">
  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>������ ����� ����θ�<br/><strong> ����</strong> �Ǵ�<strong> ����</strong>�Ͻðڽ��ϱ�?</p>
</div>	


	<!-- �׽�Ʈ������ ������� ��ư �ϼ��Ǹ� ����� �߰��� �̺�Ʈ�� �ɾ��ش� -->
<!-- <button id="create-user">Create new user</button> -->
<div id="dialog-form" title="����� ����">
   
  <form >
    <fieldset>
     <div class="container-fluid">  
  <div class="row">
    <div class="col-sm-4" >    
      <label>����</label><br/>
      <input type="text"  id="plan" value="Jane Smith" class="text ui-widget-content ui-corner-all"><br/><br/> <!-- ���߿� ��Ʈ�ѷ��� plan�� ������ �����ǽ��Ѽ� ajax�� �����ü��ֵ����ϰ� select �ٷ� �����Ҽ��ְ� �ٲ��ش� -->
      
      </div>      
      
    <div class="col-sm-4" >
    <label>��볯¥</label><br/>
    <input id="datepicker" class="text ui-widget-content ui-corner-all"  value=""><br/><br/>
     <label>��볻��</label><br/>
      <input type="text"  id="usage" value="xxxxxxx" class="text ui-widget-content ui-corner-all"><br/><br/>
    </div>    
    
    <div class="col-sm-4" >
    <label>���з�</label><br/>
      <select id="category">
   	  <option id="food" value="�ĺ�">�ĺ�</option>
      <option id="traffic" value="�����">�����</option>
      <option id="room" value="���ں�">���ں�</option>
      <option id="enterance" value="�����">�����</option>
      <option id="shopping" value="����">����</option>
      <option id="etc" value="��Ÿ">��Ÿ</option>
      </select><br/><br/>     
      <label>���ݾ�</label><br/>
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
