<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
	<script type="text/javascript">
///////////////////////////////����� ������ ���� ��ư�� �̺�Ʈ
			function conform(conAssetNo){
				
				$("#assetNo").val(conAssetNo);
				
				 swal({
				        title: '����� ����',
				        type: 'info',
				        html: "������ ����� ����θ�<br/><strong>����</strong> �Ǵ� <strong>����</strong>�Ͻðڽ��ϱ�?" +
				            "<br/><br/><br/>" +
				            ' <button type="button" id="okdel" class="btn btn-info">' + '<strong>�� ��</strong>' + '</button>' +
				            ' <button type="button" id="condel" class="btn btn-danger">' + '<strong>�� ��</strong>' + '</button>'+
				            ' <button type="button" id="candel" class="btn btn-warning">' + '<strong>Cancle</strong>' + '</button>',
				        showCancelButton: false,
				        showConfirmButton: false
				    });
	    		 
	    		 $( "#condel" ).on("click" , function() {
			    		swal({
			    			  title: '������ �����Ͻðڽ��ϱ�?',
			    			  text: "������ �����ʹ� �ǵ����� �����ϴ�.",
			    			  type: 'warning',
			    			  showCancelButton: true,
			    			  confirmButtonColor: '#3085d6',
			    			  cancelButtonColor: '#d33',
			    			  confirmButtonText: '�����մϴ�!'
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
			    			    '�� ��!',
			    			    '�����Ͻ� �Һ񳻿��� �����Ǿ����ϴ�.',
			    			    'success'
			    			  )
								window.setTimeout("newGraph("+4/* trvNo�� �־��ش� */+")", 1000);	
			    			})
					});
	    		 
	    		 $( "#candel" ).on("click" , function() {
	    			 swal(
	    					  '���...',
	    					  '����� ���� �Ǵ� ������ ����ϼ̽��ϴ�!',
	    					  'error'
	    					)
	    		 });
	    		 
	    		 $( "#okdel" ).on("click" , function() {
	    			 swal({
					        title: '����� ����',
					        width: 800,
					        background: '#fff url(https://icons.wxug.com/data/wximagenew/s/skyguy4/100-800.jpg)',
					        html: 
   ' <div class="col-sm-4">'+    
      '<label>����</label><br/>'+
     ' <b  id="plan" ></b><br/><br/> '+
     ' </div>   '+   
   ' <div class="col-sm-4">'+
    '<label>��볯¥</label><br/>'+
    '<input id="datepicker" class="text ui-widget-content ui-corner-all"  value=""><br/><br/><br/><br/>'+
     '<label>��볻��</label><br/>'+
      '<input type="text"  id="usage" value="xxxxxxx" class="text ui-widget-content ui-corner-all" autofocus><br/><br/>'+
   ' </div>   '+ 
    '<div class="col-sm-4">'+
    '<label>���з�</label><br/>'+
      '<select id="category">'+
   	  '<option value="�ĺ�">�ĺ�</option>'+
      '<option value="�����">�����</option>'+
     ' <option value="���ں�">���ں�</option>'+
      '<option value="�����">�����</option>'+
      '<option value="����">����</option>'+
    '  <option value="��Ÿ">��Ÿ</option>'+
      '</select><br/><br/><br/><br/> '+    
     ' <label>���ݾ�</label><br/>'+
      '<input type="text"  id="charge" value="xxxxxxx" class="text ui-widget-content ui-corner-all"><br/><br/>'+
   ' <br/><br/><br/><br/><br/><br/><br/></div> '+  
' <div><button type="button" id="conupdate" class="btn btn-info">' + '<strong>�� ��</strong>' + '</button>' +
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
												  '�����Ǿ����ϴ�!',
												  '����� ������ Ȯ���ϼ���!',
												  'success'
												)
		            	window.setTimeout("newGraph("+4/* trvNo�� �־��ش� */+")", 1000);	
		    		 });
	    			 
	    			 $( "#canupdate" ).on("click" , function() {
	    				 swal(
		    					  '���...',
		    					  '����� ���� �Ǵ� ������ ����ϼ̽��ϴ�!',
		    					  'error'
		    					)
		    		 });
	    			 
	    		 });
	    	
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
	    	 ////////////////////////////////////ajax ��		 
		  
	</script>

<input type="hidden" id="assetNo" value="">
<input type="hidden" id="travNo" value="">
<input type="hidden" id="blogNo" value="">