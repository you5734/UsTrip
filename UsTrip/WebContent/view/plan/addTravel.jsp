<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	
	<link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	
	<script src="/js/jquery.min.js"></script>
	<script src="/js/jquery.scrolly.min.js"></script>
	<script src="/js/skel.min.js"></script>
	<script src="/js/util.js"></script>
	<script src="/js/main.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>UsTrip</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/blitzer/jquery-ui.css">
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
	<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>


	<style>
 		body {
            padding-top : 70px;
        }
     </style>
     
	<script type="text/javascript">


	$( function() {
	    $( "#startDate" ).datepicker({
	      dateFormat : "yy-mm-dd",
	      minDate: 0,
		  showOn: "button",
	      buttonImage: "http://kr.seaicons.com/wp-content/uploads/2015/06/calendar-icon.png",
	      buttonImageOnly: true,
	      showButtonPanel: true,
	      buttonText: "Select date" 
	    });
	    $("img.ui-datepicker-trigger").attr("style", "width:40px; cursor: Pointer;");
	});
	
	
	
			

	function fncAddTravel() {
		
		if($( "#userId" ).val()=='' ){
			alert("�α��� �� �̿� �����մϴ�.")
			self.location = "/index.jsp";
			return;
		}
		
		if($( "#startDate" ).val()=='' ){
			$( "#startDate" ).val(new Date());
		}else{
			$( "#startDate" ).val(new Date($( "#startDate" ).val()));
		}
		if($( "#memberCount" ).val()=='' ){
			$( "#memberCount" ).val(1)
		}
		if($( "#totalDate" ).val()=='' ){
			$( "#totalDate" ).val(1)
		}
					
		//$("#startDate").val((new Date().getYear()-100)+"-"+(new Date().getMonth() + 1)+"-"+new Date().getDate());
		$("form").attr("method", "POST").attr("action", "/plan/addTravel").submit();
	}

	$(function() {
	
		$("button[name='���']").on("click", function() {
			
			fncAddTravel();
		});

		$("button[name='���']").on("click", function() {
			$("form")[0].reset();
		});
		
		
		
		
	});	
		
</script>
</head>

<body>
<jsp:include page="/common/toolbar.jsp"/>
<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">

	<div class="page-header text-info">
       <h3>Travel���̺��Է�</h3>
    </div>
		
		<!-- form Start /////////////////////////////////////-->
		<!-- <form class="form-horizontal" name="detailForm"> -->
		<form class="form-horizontal">
			
			<!-- ���������ִ���	 -->		
		  <div class="form-group">
		    <input type="hidden" id="userId" name="userId" value="${sessionScope.user.userId}"/>
		  </div>			
		
			
		  
		  <div class="form-group">
		    <label for="travTitle" class="col-xs-4 col-md-2">��������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="travTitle" name=travTitle placeholder="��������">
		    </div>
		  </div>

		  
		  <div class="form-group">
		    <label for="startDate" class="col-xs-4 col-md-2">�����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="startDate"  name="startDate" placeholder="�޷� �̹��� Ŭ��">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="memberCount" class="col-xs-4 col-md-2">�ο���</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="memberCount" name="memberCount" placeholder="�ο���">
		    </div>
		  </div>
		  		  
		  <div class="form-group">
		  	 <label for="travTheme" class="col-xs-4 col-md-2">�����׸�</label>
		    <div class="col-sm-4">
		      <select name="travTheme" style="width: 85px; height: 28px" >
				<option value="��������">��������</option>
				<option value="Ŀ�ÿ���">Ŀ�ÿ���</option>
				<option value="��ȥ����">��ȥ����</option>
				<option value="��������">��������</option>
				<option value="�ַο���">�ַο���</option>
				<option value="�賶����">�賶����</option>
			</select>
		    </div>
		  </div>
	
		  <div class="form-group">
		    <label for="totalDate" class="col-xs-4 col-md-2">�� ������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="totalDate" name="totalDate" placeholder="�� ������">
		    </div>
		  </div>
			<!-- 
		  <div class="form-group">
		    <label for="isBlogStart" class="col-xs-4 col-md-2">��α� ���� ����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="isBlogStart" name="isBlogStart">
		    </div>
		  </div>
		  	 -->
		  
		  
		  <br/>
		  <hr/>
		  
		 
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  name="���">��&nbsp;��</button>
		      <button type="button" class="btn btn-primary"  name="���">��&nbsp;��</button>
		    </div>
		  </div>
		</form>
		<!-- form End /////////////////////////////////////-->
		
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
	
</body>
</html>



