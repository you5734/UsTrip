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
		    	
                /////////////////////���������� ����˾� ��������â 
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
		            "Ȯ ��": function() {
		            	
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
		            "�� ��": function() {
		            	innerlog.dialog( "close" );
		            }
		          }
		        });
		    	 ////////////////////////// ���������� �̺�Ʈ ��
		    	 
		     	//////////////////////////����Ȥ�� ���� Ȯ�� �޼���	    	
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
		    	          "�ۼ��Ѵ�": function() {
		    	        	  
		    	        	  $( this ).dialog( "close" );  	        	 
		    		     		    	        	
		    	        	  innerlog.dialog( "open" );
		    	        	            
		    	            
		    	          },
		    	          "�� ��": function() {
		    	            $( this ).dialog( "close" );
		    	          }
		    	        }
		    	    });
		     	////////////////////////////////////Ȯ�� �޽��� ��		    			    	   					
		    		});		  
	</script>


	<div id="addconfirm" title="����� �߰�">
  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>������ ����� ����θ� �ۼ��Ͻðڽ��ϱ�?</p>
</div>	


	<!-- �׽�Ʈ������ ������� ��ư �ϼ��Ǹ� ����� �߰��� �̺�Ʈ�� �ɾ��ش� -->
<!-- <button id="create-user">Create new user</button> -->
<div id="addform" title="����� �߰�">
   
  <form >
    <fieldset>
     <div class="container-fluid">  
  <div class="row">
    <div class="col-sm-4" >    
      <label>����</label><br/>
      <input type="text"  id="plan" value="Jane Smith" class="text ui-widget-content ui-corner-all"><br/><br/> <!-- ���߿� ��Ʈ�ѷ��� plan�� ������ �����ǽ��Ѽ� ajax�� �����ü��ֵ����ϰ� select �ٷ� �����Ҽ��ְ� �ٲ��ش� -->
      <label>��α�</label><br/>
      <input type="text"  id="plan" value="����ȣ" class="text ui-widget-content ui-corner-all"><br/><br/>
      </div>      
      
    <div class="col-sm-4" >
    <label>��볯¥</label><br/>
    <input id="datepicker1" class="text ui-widget-content ui-corner-all"  value=""><br/><br/>
     <label>��볻��</label><br/>
      <input type="text"  id="usage" value="xxxxxxx" class="text ui-widget-content ui-corner-all"><br/><br/>
    </div>    
    
    <div class="col-sm-4" >
    <label>���з�</label><br/>
      <select id="category">
      <option>�����ϼ���</option>
   	  <option value="�ĺ�">�ĺ�</option>
      <option value="�����">�����</option>
      <option value="���ں�">���ں�</option>
      <option value="�����">�����</option>
      <option value="����">����</option>
      <option value="��Ÿ">��Ÿ</option>
      </select><br/><br/>     
      <label>���ݾ�</label><br/>
      <input type="text"  id="charge" value="xxxxxxx" class="text ui-widget-content ui-corner-all"><br/><br/>
    </div>             
    
  </div>
</div>
    </fieldset>
  </form>
</div>
