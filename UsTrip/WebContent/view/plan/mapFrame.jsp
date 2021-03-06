<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBlWKR_u9NsT-3h0mdZ_5gg-aB4Eh58Ajo&v=3.exp&libraries=places&region=kr&callback=initMap"  defer></script>
<script src="/js/dateFormat.js"></script>
	<style type="text/css">
        #map{
        height: 100%;
      }
      html, body, div{
        height: 100%;
      }
      
        </style>
	<script>
	
	 function setMap(zoomLevel,mapCenter,target,titles,days){
	       map = new google.maps.Map(document.getElementById('map'), {
	         center: mapCenter,
	         zoom: zoomLevel,
	         scrollwheel: true,
	         navigationControl: false,
	         mapTypeControl: false,
	         scaleControl: true,
	         draggable: true,
	         disableDoubleClickZoom: true
	       });
	       for (var i in target) { 
	         eval('marker'+[i]+' = new google.maps.Marker({position: new google.maps.LatLng(target[i]),map: map});');
	         eval('marker'+[i]).setMap(map);
	         var infowindow = new google.maps.InfoWindow();	 		
	  		eval('marker'+[i]+'.infowindow = infowindow;');
	  		infowindow.setContent('<div><strong>'+titles[i]+'</strong><br/>'+days[i]+'</div>');
	  		eval('infowindow.open(map,marker'+[i]+');');
	       }	         
	                   var polylinePath = new google.maps.Polyline({
	                    path: target,
	                    geodesic: true,
	                    strokeColor: '#FF0000',
	                    strokeOpacity: 1.0,
	                    strokeWeight: 2
	                  });

						polylinePath.setMap(map);
	                } 
			 
     function initMap(){
       map = new google.maps.Map(document.getElementById('map'), {
         center: {lat: 36.4488, lng: 127.7792} ,
         zoom: 7
       });
       /* 
       var target = [
                          {lat: 36.8488, lng: 127.7792},
                          {lat:37.4923, lng:127.0292},
                          {lat: 36.4488, lng: 127.7792}
                        ];	
       for (var i = 0; i < target.length; i++) { 
         marker = new google.maps.Marker({
           position: new google.maps.LatLng(target[i]),
           map: map
         });
         marker.setMap(map);
       }
         
                   var polylinePath = new google.maps.Polyline({
                    path: target,
                    geodesic: true,
                    strokeColor: '#FF0000',
                    strokeOpacity: 1.0,
                    strokeWeight: 2
                  });

					polylinePath.setMap(map); */
                } 
   
     $(function() {	
    	
    	 //initMap();
    	 $('button[name="city"]').on('click',function(){
    		var travNo = $(this).val();
    		var zoomLevel = 7;
    		var mapCenter = {lat: 36.4488, lng: 127.7792} ;
    		var target = [];
    		var titles =[];
    		var days = [];
    		
    		$.ajax( 
					{
						url : "/blog/getMapCity/"+travNo,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						context : this,
						success : function(J , status) {	
							
							for(var i in J.listCity){
								eval('var cityXY'+[i]+' = new Object()');					
								eval('cityXY'+[i]).lat = J.listCity[i].cityX;
								eval('cityXY'+[i]).lng = J.listCity[i].cityY;
								target.push(eval('cityXY'+[i]));					
							}
							
							for(var i in J.listCity){										
								titles.push(J.listCity[i].city);					
							}
							
							for(var i in J.listCity){
								//var tranDate = J.listCity[i].stayStart.replace(/-/gi,'/');
								days.push(J.listCity[i].stayStart);					
							}
				    		setMap(zoomLevel,mapCenter,target,titles,days);
						}
					});    	
    	 });
    	 
    	 $('button[name="place"]').on('click',function(){
    		 var placeNo = $(this).val();
     		var zoomLevel = 15;     		
     		var x = $(this).attr('tempX');
     		var y = $(this).attr('tempY');
     		x *= 1;
     		y *= 1;
     		var mapCenter = {lat: x, lng: y} ;
     		 var target = [];
     		var titles =[];
    		var days = [];
     		$.ajax( 
 					{
 						url : "/blog/getMapPlace/"+placeNo,
 						method : "GET" ,
 						dataType : "json" ,
 						headers : {
 							"Accept" : "application/json",
 							"Content-Type" : "application/json"
 						},
 						context : this,
 						success : function(J , status) { 	
 							
 							for(var i in J.listPlace){
 								eval('var placeXY'+[i]+' = new Object();');
 								eval('placeXY'+[i]).lat = J.listPlace[i].placeX;
 								eval('placeXY'+[i]).lng = J.listPlace[i].placeY;
 								target.push(eval('placeXY'+[i]));		
 							}
 							
 							for(var i in J.listPlace){										
								titles.push(J.listPlace[i].place);				
								
							}
 							
							for(var i in J.listPlace){
								var tranDate = new Date(J.listPlace[i].visitDate).format("yyyy/MM/dd");								
								days.push(tranDate);	
								
							}
							//alert(JSON.stringify(days));
				    		setMap(zoomLevel,mapCenter,target,titles,days);
						}
 						 				    	
 					});    	
     	 });
     })
	
	</script>
</head>
<body>

<div class="row" >
<div class="col-md-10">
<div id="map" ></div>
</div>
<div class="col-md-2">
<button value="${travNo}" name="city" class="btn btn-info">전체경로 보기</button><br/>
<c:forEach items="${listCity}" var="city" varStatus="status">
<button name="place" class="btn btn-info" value="${city.cityNo}" tempX="${city.cityX}" tempY="${city.cityY}">${city.city}</button><br/>
</c:forEach>
</div>
</div>
</body>
</html>