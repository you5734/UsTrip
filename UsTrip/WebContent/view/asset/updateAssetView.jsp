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
				            ' <button type="button" id="okdel" class="btn btn-info" data-toggle="modal" data-target="#exampleModalLong">' + '<strong>�� ��</strong>' + '</button>' +
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
	    			 swal.close();
	    			/*  swal({
					        title: '����� ����',
					        width: 800,
					        html: 
   '<div class="row"><div class="col-md-4">'+    
      '<div>����</div><br/>'+
     ' <b  id="upPlan" ></b><br/><br/> '+
     ' </div>   '+   
   ' <div class="col-md-4">'+
    '<div>��볯¥</div><br/>'+
    '<input id="upDatepicker" value="" class="text ui-widget-content ui-corner-all"><br/><br/><br/><br/>'+
     '<div>��볻��</div><br/>'+
      '<input type="text"  id="upUsage" value="" class="text ui-widget-content ui-corner-all" autofocus><br/><br/>'+
   ' </div>   '+ 
    '<div class="col-md-4">'+
    '<div>���з�</div><br/>'+
      '<select id="upCategory">'+
   	  '<option value="�ĺ�">�ĺ�</option>'+
      '<option value="�����">�����</option>'+
     ' <option value="���ں�">���ں�</option>'+
      '<option value="�����">�����</option>'+
      '<option value="����">����</option>'+
    '  <option value="��Ÿ">��Ÿ</option>'+
      '</select><br/><br/><br/><br/> '+    
     ' <div>���ݾ�</div><br/>'+
      '<input type="text"  id="upCharge" value="" class="text ui-widget-content ui-corner-all"><br/><br/>'+
   ' <br/><br/><br/><br/><br/><br/><br/></div> '+  
' <div><button type="button" id="conupdate" class="btn btn-info">' + '<strong>�� ��</strong>' + '</button>' +
' <button type="button" id="canupdate" class="btn btn-danger">' + '<strong>Cancle</strong>' + '</button></div></div>',
					        showCancelButton: false,
					        showConfirmButton: false
					    }); */
	    			 updateAsset(conAssetNo); 
	    			 
	    			 $( "#conupdate" ).on("click" , function() {
	    				 $.ajax( {type:"POST",  
		            	        url:"/asset/updateAssetJSON",
							data:{
								travNo:$("#travNo").val(),
								assetNo:$("#assetNo").val(),
								blogNo:$("#blogNo").val(),
								assetCategory:$("#upCategory").val(),	  
								usage:$("#upUsage").val(),	  		
								charge:$("#upCharge").val(),	 
								visitDate:	$("#upDatepicker").val()
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
								
							$("#upPlan").html(J.asset.travTitle);
							$("#travNo").val(J.asset.travNo);
							$("#assetNo").val(J.asset.assetNo);
							$("#blogNo").val(J.asset.blogNo);
							$("#upCategory").val(J.asset.assetCategory);	  
							$("#upUsage").val(J.asset.usage);	  		
							$("#upCharge").val(J.asset.charge);	 
							$("#upDatepicker").val(new Date(J.asset.visitDate).format("yyyy/MM/dd"));
							$( '#upDatepicker' ).pickadate({		
								format: 'yyyy/mm/dd',
								min: startDate,
								max: endDate
					        }); 
							
							}								
					})
		    }
	    	 ////////////////////////////////////ajax ��		 
		  
	</script>
	<!-- Button trigger modal -->

<!-- Modal -->
<div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content" style="margin-top:200px;">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLongTitle">����� ����</h4>
      </div>
      <div class="modal-body">
        <div class="row"><div class="col-md-4">  
     <div>����</div><br/>
     <b  id="upPlan" ></b><br/><br/>
     </div>    
   <div class="col-md-4">
    <div>��볯¥</div><br/>
    <input type="text" id="upDatepicker" value="" class="text ui-widget-content ui-corner-all"><br/><br/><br/><br/>
     <div>��볻��</div><br/>
      <input type="text"  id="upUsage" value="" class="text ui-widget-content ui-corner-all" autofocus><br/><br/>
       </div>  
    <div class="col-md-4">
    <div>���з�</div><br/>
      <select id="upCategory">
   	  <option value="�ĺ�">�ĺ�</option>
      <option value="�����">�����</option>
    <option value="���ں�">���ں�</option>
      <option value="�����">�����</option>
     <option value="����">����</option>
    <option value="��Ÿ">��Ÿ</option>
      </select><br/><br/><br/><br/>   
     <div>���ݾ�</div><br/>
      <input type="text"  id="upCharge" value="" class="text ui-widget-content ui-corner-all"><br/><br/>
  </div></div>
      </div>
      <div class="modal-footer">
        <div><button type="button" id="conupdate" class="btn btn-info" data-dismiss="modal"><strong>�� ��</strong></button>
				<button type="button" id="canupdate" class="btn btn-danger" data-dismiss="modal"><strong>�� ��</strong></button></div></div>
      </div>
    </div>
  </div>

<input type="hidden" id="assetNo" value="">


	<script src="/js/picker.js"></script>
	<script src="/js/picker.date.js"></script>
	<script src="/js/legacy.js"></script>