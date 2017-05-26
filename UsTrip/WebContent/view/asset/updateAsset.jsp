<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>여행가계부</title>	
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
    <script src="/js/canvasjs.min.js"></script>
      
	<style>
 		body {
            padding-top : 50px;
        }
        .overlay
{
padding-left:5px;
position: absolute;
margin-left: 3px;
margin-top: 15px;
}
#abc{
    font:Verdana, Geneva, sans-serif;
    font-size:18px;
    text-align:left;
    background-color:#0F0;
    height:50px;
    vertical-align:middle;
}
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">		
		
		    $(function() {		
		    	
		    	 var innerlog;
		     	
		    	 innerlog = $( "#dialog-form" ).dialog({
		          autoOpen: false,
		          height: 400,
		          width: 350,
		          modal: true,
		          buttons: {
		            "Create an account": function() {
		            	innerlog.dialog( "close" );
		            },
		            Cancel: function() {
		            	innerlog.dialog( "close" );
		            }
		          }
		        });
		     		    	
		    	$( "#dialog-confirm" ).dialog({
		    	      autoOpen: false,
		    	      modal: true,
		    	      show: {
		    	        effect: "blind",
		    	        duration: 1000,		    	        
		    	      },
		    	      hide: {
		    	        effect: "blind",
		    	        duration: 1000
		    	      },
		    	      buttons: {
		    	          "추가한다": function() {
		    	        	  
		    	        	  $( this ).dialog( "close" );  	        	 
		    		     
		    		      
		    	        	  innerlog.dialog( "open" );
		    		            	           
		    	            
		    	          },
		    	          "취소": function() {
		    	            $( this ).dialog( "close" );
		    	          }
		    	        }
		    	    });
		    	
		    	 $( "#create-user" ).on("click" , function() {
		    		 $( "#dialog-confirm" ).dialog( "open" );
		    	 });
		    		});		  
	</script>
	
</head>

<body>

	<div id="dialog-confirm" title="가계부 추가">
  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>여행중 사용한 가계부를 추가하시겠습니까?</p>
</div>	


	<!-- 테스트용으로 사용중인 버튼 완성되면 가계부 추가에 이벤트를 걸어준다 -->
<button id="create-user">Create new user</button>
<div id="dialog-form" title="Create new user">
  <p class="validateTips">All form fields are required.</p>
  
  
 
  <form>
    <fieldset>
      <label for="name">Name</label><br/>
      <input type="text" name="name" id="name" value="Jane Smith" class="text ui-widget-content ui-corner-all"><br/>
      <label for="email">Email</label><br/>
      <input type="text" name="email" id="email" value="jane@smith.com" class="text ui-widget-content ui-corner-all"><br/>
      <label for="password">Password</label><br/>
      <input type="password" name="password" id="password" value="xxxxxxx" class="text ui-widget-content ui-corner-all">
 
      <!-- Allow form submission with keyboard without duplicating the dialog button -->
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    </fieldset>
  </form>
</div>

</body>

</html>