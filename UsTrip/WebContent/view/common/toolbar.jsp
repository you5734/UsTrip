<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<div class="navbar  navbar-inverse navbar-fixed-top" >

      <div class="container">
      
      <a class="navbar-brand navbar-left" ><i class="glyphicon glyphicon-gift"></i> Model2 MVC Shop</a>
     
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>          
        </div>
        
        <!-- �α����� ���� �ʾ������  -->
         <c:if test="${ empty user }">
        <div id="navbar" class="navbar-collapse collapse">
      
          <ul class="nav navbar-form navbar-nav navbar-right" >
       <li>
            <form class="navbar-form">
              <input type="text" placeholder="ID" class="form-control"/>
            </form></li>
            <li><form class="navbar-form">
              <input type="password" placeholder="Password" class="form-control"/></form>
           </li>
            
      <li id="login"><a>Log in</a></li>
      <li id=""><a>Sign up</a></li>      
    
          </ul>
          
        </div><!--/.navbar-collapse -->
        </c:if>
      <!-- ******************************************************************************************************** -->  
        
        <!--�α����� �������  -->
          <c:if test="${ !empty user }">
         
          		
          		 <div 	class="collapse navbar-collapse" id="navbar" >      
      
	  <ul class="nav navbar-nav navbar-left navbar-form" data-toggle="dropdown" data-hover="dropdown" >
	
	  <li class="dropdown">
          <a class="dropdown-toggle"  data-toggle="dropdown" >�������� ����<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a >�������� ��ȸ</a></li>  
           <%--  <c:if test="${user.role == 'admin' }">        
            <li class="divider"></li>           
            <li><a>ȸ������ ��ȸ</a></li>
            </c:if>  --%>
          </ul>
        </li> 
        
         <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >�ǸŻ�ǰ����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">�ǸŻ�ǰ���</a></li>
		                         <li class="divider"></li>  
		                         <li><a href="#">�ǸŻ�ǰ����</a></li>
		                         <li class="divider"></li>  
		                         <li><a href="#">���Ÿ����ȸ</a></li>
		                      
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- ���Ű��� DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >�� ǰ �� ��</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">�� ǰ �� ��</a></li> 
	                         <c:if test="${user.role == 'user' }">  
	                         <li class="divider"></li>  
		                         <li><a href="#">���Ż�ǰ��ȸ</a></li>   
		                         </c:if>       	                     
	                     </ul>
	                 </li>
        
        </ul>
        
           <ul class="nav navbar-nav navbar-right navbar-form" >
           
           <c:if test="${user.role == 'admin' }">   
         <li> <a id="ment">������:: ${user.userName}�� ȯ���մϴ�</a> </li>
          </c:if>
          
          <c:if test="${user.role == 'user' }">   
            <li> <a id="ment">${user.userName}�� ȯ���մϴ�</a> </li>
          </c:if>

<li><a>Log out</a></li>
</ul>    

         </div>
      		    </c:if>
        </div><!--/.navbar-collapse -->
       
      </div>
<style>

</style>
<script type="text/javascript">
$(function() {
	
	$('#ment').css('color','white').css('font-size','130%');
	
	$('.navbar-brand').css('font-size','220%');
	
	$('.navbar-brand').on("click" , function() {
 		$(window.parent.document.location).attr("href","../index.jsp");
 	}); 
	
	/* �α��� �� �������̼�üũ */
	$('li:contains("Log in")').on("click" , function() {
		
		var id=$('input[placeholder="ID"]').val();
		var pw=$('input[placeholder="Password"]').val();
		
		if(id == null || id.length <1) {
			alert('ID �� �Է����� �����̽��ϴ�.');
			$("input:text").focus();
			return;
		}
		
		if(pw == null || pw.length <1) {
			alert('�н����带 �Է����� �����̽��ϴ�.');
			$("input:password").focus();
			return;
		}
		$.ajax( 
				{
					url : "/user/jsonLogin",
					method : "POST" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						userId : id,
						password : pw
					}),
					success : function(JSONData , status) {
						if( JSONData.user != null ){
							$(window.parent.document.location).attr("href","/index.jsp");
						}else{
							alert("���̵� , �н����带 Ȯ���Ͻð� �ٽ� �α���...");
						}
					}
			}); 
	});
	/* �α��ι� �������̼�üũ ��  */
	
		$('li:contains("Sign up")').on("click" , function() {
			self.location = "/user/addUser"
		});

		$('li:contains("Log out")').on("click", function(){
			$(window.parent.document.location).attr("href","/user/logout");
		});
			 
		 $("a:contains('ȸ������ ��ȸ')").on("click" , function() {
			
				self.location = "/user/listUser"
			}); 
		 
			$( "a:contains('�������� ��ȸ')" ).on("click" , function() {
		 
				$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
			});
			
			$( "a:contains('�ǸŻ�ǰ���')").on("click" , function() {
				$(self.location).attr("href","../product/addProductView.jsp;");
		 	}); 
			
			$( "a:contains('�ǸŻ�ǰ����')").on("click" , function() {
				$(self.location).attr("href","/Product/listProduct?menu=manage");
		 	}); 
			
			$( "a:contains('�� ǰ �� ��')").on("click" , function() {
				$(self.location).attr("href","/Product/listProduct?menu=search");
		 	}); 
			
			$( "a:contains('���Ÿ����ȸ')").on("click" , function() {
				$(self.location).attr("href","/Purchase/listSale");
		 	}); 
			
			$( "a:contains('���Ż�ǰ��ȸ')").on("click" , function() {
				$(self.location).attr("href","/Purchase/listPurchase?userId=${sessionScope.user.userId}");
		 	}); 
		
	
});	
</script>

