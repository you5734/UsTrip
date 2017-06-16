<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
	
	<title>UsTrip</title>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maps.googleapis.com/maps/api/js?
    key=AIzaSyBlWKR_u9NsT-3h0mdZ_5gg-aB4Eh58Ajo&v=3.exp&region=kr"></script>
	<style type="text/css">
        html, body {
			height: 100%;
			margin: 0;
			padding: 0;
			overflow:hidden;        
        }
 
 		#mainCity {
			width: 17%;
			height: 15%;
			float:left;
 		}
 		
 		#btn {
			width: 83%;
			height: 15%;
			float:left;
        }
 
 		#formTag {			
			width:17%;
			height:85%;
			float:left;
			overflow:auto;
		}
		
		#map {
			width:  83%;
			height: 85%;
        }
        
        #panel{
			position: fixed;
			margin-left: 25%;
          	margin-top: 9%;
			z-index: 5;
			background-color: #fff;
			padding: 3px;
        }
        
        #duration, #distance{
       		border:none;
        }
		
    </style>
	



    <script>
	var travelNo = "${sessionScope.travel.travelNo}";
	var stayStart = "${sessionScope.travel.startDate}";
	stayStart = new Date(stayStart);
	stayStart = stayStart.getFullYear()+"-"+(stayStart.getMonth()*1+1)+"-"+stayStart.getDate();
    var directionsDisplay;
    var directionsService = new google.maps.DirectionsService();
    var map;
    var geocoder;//
    var temp;
    var start;
    var end;
	var tempNum = 0;
	var XValue;
	var YValue;
	var cityValue;
	var routes = [];
	var stayStart;
	var stayDate;
	var stayEnd;
    
    $(function(){
  	  $(document).on("click","#btn-test",function(){
  			XValue = $(this).parent().find(".cityX").val();
		  	YValue = $(this).parent().find(".cityY").val();	
		  	cityValue = encodeURIComponent($(this).parent().find(".city").val());
			stayStart = encodeURIComponent($(this).parent().find(".stayStart").val());
			stayDate = encodeURIComponent($(this).parent().find(".stayDate").val());
			stayEnd = encodeURIComponent($(this).parent().find(".stayEnd").val());
			
			var lct = "/view/plan/addPlace.jsp?"+XValue+"?"+YValue+"?"+cityValue+"?"+stayStart+"?"+stayDate+"?"+stayEnd;
			
			self.location = lct;
  	  });
  	  
  	$(document).on("click","#전체루트",function(){
		
	  	/* 	alert("CB()")
	    	var latlng= "(37.55002139332707, 125.84461212158203)";
	    	alert(latlng)
	    	getAddress(latlng); */
		  });
    });
    
	function movePlace(){ 
		
		 for(var i = 0; i < tempNum-1; i++){
			
			
			$("#f"+(i)+" input[name='stayStart']").val(stayStart);
			var stayDate = $("#f"+(i)+" select[name='stayDate']").val();
			var stayEnd = new Date(stayStart);
	   		stayEnd.setDate((stayEnd.getDate()*1 + stayDate*1));
	   		stayEnd = stayEnd.getFullYear()+"-"+(stayEnd.getMonth()*1+1)+"-"+stayEnd.getDate();
			$("#f"+(i)+" input[name='stayEnd']").val(stayEnd)
			stayStart = stayEnd;
	    	
        	eval("var cityObj"+i+"= new Object()");
				    
			eval("cityObj"+i).city = $("#f"+(i)+" input[name='city']").val();
			eval("cityObj"+i).travelNo = travelNo;
			eval("cityObj"+i).cityId = $("#f"+(i)+" input[name='cityId']").val();
			eval("cityObj"+i).cityX = $("#f"+(i)+" input[name='cityX']").val();
			eval("cityObj"+i).cityY = $("#f"+(i)+" input[name='cityY']").val();
			eval("cityObj"+i).preCityNo = $("#f"+(i)+" input[name='preCityNo']").val();
			eval("cityObj"+i).nextCityNo = $("#f"+(i)+" input[name='nextCityNo']").val();
			eval("cityObj"+i).stayStart = $("#f"+(i)+" input[name='stayStart']").val();
			eval("cityObj"+i).stayDate = $("#f"+(i)+" select[name='stayDate']").val();
			eval("cityObj"+i).stayEnd = $("#f"+(i)+" input[name='stayEnd']").val();
			 
			//cityArray.push();
			
			var jsonCity = JSON.stringify(eval("cityObj"+i));
		        	
	        $.ajax({
	        	type : "POST",
	        	url : "/plan/addCity",
	        	data :{ a:jsonCity},
	        	datatype : "json",
	        	context: this,
	        	success: function(result)
	        	{
	        		alert(result);
	        	}
	        }); 	        
        }  
		//"/product/listProduct?menu=${param.menu}"
		//var XValue = $(this).parent().find(".cityX").val();

		 
		// $(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		
		
       
		//$("form").attr("method", "POST").attr("action", "/plan/addPlace").submit();
		
		//self.location = "/product/listProduct?menu=search";
		
	
	}
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////
    function getLocation(){
        if(navigator.geolocation){
            navigator.geolocation.getCurrentPosition(initialize);
        }else{
            alert("Not Support Browser");
        }
    }        
///////////////////////////////////////////////////////////////////////////////////////////////////////// 
    function initialize(position) {
      directionsDisplay = new google.maps.DirectionsRenderer();
      geocoder = new google.maps.Geocoder();
    
      var currentLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
    
      var mapOptions = {
        zoom:8,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        center: currentLocation
      }
      map = new google.maps.Map(document.getElementById('map'), mapOptions);
      directionsDisplay.setMap(map);
      var markers = [];
      
      google.maps.event.addListener(map, 'click', function(e) {
          getAddress(e.latLng);
          
      });
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////      
     /*  poly = new google.maps.Polyline({
  	    strokeColor: '#000000',
  	    strokeOpacity: 1.0,
  	    strokeWeight: 3
  	  });
  	  poly.setMap(map);

  	  // Add a listener for the click event
  	  map.addListener('click', addLatLng); */
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  	
      function getAddress(latlng) {
    		var geocoder = new google.maps.Geocoder();
    		geocoder.geocode({
    			latLng: latlng
  				
    		}, function(results, status) {
    			
    			var marker = new google.maps.Marker;
    			if (status == google.maps.GeocoderStatus.OK) {
    				if (results[0].geometry) {
    					
    					var address = results[0].formatted_address.replace(/^日本, /, '');
    					address = address.split(' ');
    					
    					address = address[1]+" " +address[2]
    					new google.maps.InfoWindow({
    						content: address + "<br>(Lat, Lng) = " + latlng
    					})/* .open(map, new google.maps.Marker({//맵에 박스 뜨는거
    						position: latlng,
    						map: map
    					}) ); */
    					
    					$("#temp").val(address);
    					setTemp()
    					/* 
    				//	 alert(JSON.stringify(results[0]));
    					
    					markers.push(JSON.stringify(results[0].address_components[3].long_name)); 
    					/* alert(markers.length); 
    					if($('#startCity').val() == ""){
  	  					$('#startCity').val(results[0].address_components[3].long_name);
    					}else{
    						$('#city').val(results[0].address_components[3].long_name);
    					}
    				//	 alert(markers.length); //마커 갯수
    					if(markers.length%2==0){
    			    		
    			    		end = document.getElementById('city').value;
    			    		Javascript:calcRoute();
    			    		
    			    		var newUpButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"    			    		
    			    		var newLeftButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button></br>"
    			    			
    						$("#btn").append(newUpButton);
    			    		$("#formTag").append(newLeftButton);			  
    					
    			    	}else if(markers.length%2!=0){
    			    		start = document.getElementById('startCity').value;
    			    		
    			    		
    			    		var newUpButton = "<button  onclick=\"movePlace('"+start+"')\">"+start+"</button>"
    			    		var newLeftButton = "<button  onclick=\"movePlace('"+start+"')\">"+start+"</button></br>"
    			    			
    						$("#btn").append(newUpButton);				
    			    		$("#formTag").append(newLeftButton);
    			    	} */
    			    }
    				}		
    			 
    		});    
      }
  }// end of initialize() 
/////////////////////////////////////////////////////////////////////////////////////////////////////////      
    

    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////    
    function setTemp() {
    	
    	if(tempNum==0){

    		start = document.getElementById('temp').value;
    		
    		var newUpButton = "<button>"+start+"</button>"
    		var newLeftButton = "<button style='WIDTH: 170pt;'>"+start+"</button>"
    		
    		
    		    var address1 = document.getElementById('temp').value;
    		    geocoder.geocode( { 'address': address1}, function(results, status) {
    		      if (status == 'OK') {
    		        map.setCenter(results[0].geometry.location);
    		        var marker = new google.maps.Marker({
    		            map: map,
    		            position: results[0].geometry.location
    		        });
    		      } else {
    		        alert('Geocode was not successful for the following reason: ' + status);
    		      }
    		    /*   alert(results[0].geometry.location);
    		      alert(JSON.stringify(results[0].geometry.location)); */
    		     //routes.push(JSON.stringify(results[0].geometry.location));
    		     routes.push(results[0].geometry.location);
    		     
    		    });
    		  
    		
    		$("#btn").append(newUpButton);
    		$("#mainCity").append(newLeftButton);
			$("#temp").val(null);
			
			tempNum++;
			return;
    	}
    		tempNum++;	
    	
    		end = document.getElementById('temp').value;
    		
    		$("#temp").val(null);
    		
    		
    		var newUpButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"    			    		
    		
    		var newLeftButton = "<div id = 'f"+(tempNum-2)+"'>"    
    			+"<input type='text' id='duration' name='duration'/>"
				+"<input type='text' id='distance' name='distance'/>"
    			+"<input type='hidden' id='startCity' name='startCity'/>"
    			+"<input type='hidden' id='city' name='city' class='city'/>"
    			+"</br>"
    			+"<label>숙박일</label>"
    		    +"<select id='stayDate' name='stayDate'>"
    		    +"<option>1</option>"
    		    +"<option selected='selected'>2</option>"
    		    +"<option>3</option>"
    		    +"<option>4</option>"
    		    +"<option>5</option>"
    		    +"<option>6</option>"
    		    +"<option>7</option>"
    		    +"<option>8</option>"
    		    +"<option>9</option>"
    		    +"<option>10</option>"
    		    +"</select>"
    			+"<input type='hidden' id='travelNo' name='travelNo' class='travelNo' value='"+travelNo+"'/>"
    			+"<input type='hidden' id='cityId' name='cityId'/>"
    			+"<input type='hidden' id='cityX' name='cityX' class='cityX'/>"
    			+"<input type='hidden' id='cityY' name='cityY' class='cityY'/>"
    			+"<input type='hidden' id='preCityNo' name='preCityNo'/>"
    			+"<input type='hidden' id='nextCityNo' name='nextCityNo'/>"
    			+"<input type='hidden' id='stayStart' name='stayStart'/>"
    			+"<input type='hidden' id='stayEnd' name='stayEnd'/>"
    			+"</br>"
    			+"<button type='button' id = 'btn-test' style='WIDTH: 170pt;'>"+end+"</button>"
    			+"</div>";
    			
    			
    			

			$("#btn").append(newUpButton);
			
    		$("#formTag").append(newLeftButton);
    		
    		
    		$("#start").val(start);
    		$("#end").val(end);    		
    		
    		$("#f"+(tempNum-2)+" input[name='startCity']").val(document.querySelector('#start').value);
    		$("#f"+(tempNum-2)+" input[name='city']").val(document.querySelector('#end').value);
    		$("#f"+(tempNum-2)+" input[name='preCityNo']").val(tempNum-2);
    		$("#f"+(tempNum-2)+" input[name='nextCityNo']").val(tempNum);
    		
    		
    	    Javascript:calcRoute();
    		
    		start = end;
    		
    }// setTemp() 끝
/////////////////////////////////////////////////////////////////////////////////////////////////////////
 /*  function addLatLng(event) {
	//	alert(event); // 뭔진 모르겠고 [object Object] 이렇게 나옴
	//	alert(JSON.stringify(event)); // 좌표값~~~~
	
	  var path = poly.getPath();

	  // Because path is an MVCArray, we can simply append a new coordinate
	  // and it will automatically appear.
	  path.push(event.latLng);

	  // Add a new marker at the new plotted point on the polyline.
	  var marker = new google.maps.Marker({
	    position: event.latLng,
	    title: '#' + path.getLength(),
	    map: map
	  });
	} */
/////////////////////////////////////////////////////////////////////////////////////////////////////////
    function calcRoute() {
   
      var start = document.querySelector('#start').value;
      var end = document.querySelector('#end').value;
      
      var mode = "TRANSIT";
 
      var request = {
          origin:start,
          destination:end,
          travelMode: eval("google.maps.DirectionsTravelMode."+mode)
      }; 
     
      directionsService.route(request, function(response, status) {
    	 	  
        if (status == google.maps.DirectionsStatus.OK) {
          // directionsDisplay.setDirections(response);//네비게이션 지도 루트 변경되는거
        }  	
        var cityX = response.routes[0].legs[0].end_location.lat();
        var cityY = response.routes[0].legs[0].end_location.lng();
        
        $("#f"+(tempNum-2)+" input[name='cityX']").val(cityX);
        $("#f"+(tempNum-2)+" input[name='cityY']").val(cityY);
        $("#f"+(tempNum-2)+" input[name='cityId']").val(response.geocoded_waypoints[1].place_id);
        
        var rere = JSON.stringify(response.routes[0].legs[0].duration.text);
        
        var cityXY = new Object();
        cityXY.lat = cityX;
        cityXY.lng = cityY;
      
       var marrk = cityXY;
        routes.push(cityXY);
   
         $("#f"+(tempNum-2)+" input[name='duration']").val(JSON.stringify(
        		 response.routes[0].legs[0].duration.text).replace("\"",'').replace("\"",''));
        $("#f"+(tempNum-2)+" input[name='distance']").val(JSON.stringify(
        		response.routes[0].legs[0].distance.text).replace("\"",'').replace("\"",'')); 
        
      			  var marker = new google.maps.Marker({
    	    		position: marrk,
    	    		map: map
    	  			}); 
                                   var CBroute = new google.maps.Polyline({
                                     path: routes,
                                     geodesic: true,
                                     strokeColor: '#b31543',
                                     strokeOpacity: 1.0,
                                     strokeWeight: 2
                                   });

                                   CBroute.setMap(map);
        
      });
    }//end of calcRoute()
///////////////////////////////////////////////////////////////////////////////////////////////////////// 
/* $('#123').val(JSON.stringify(results[0])); */
	//alert(JSON.stringify(request));
     // alert(request.origin);
//출발지      $('#a1').val(request.origin); 
      
//도착지     $('#nextCity').val(request.destination);
      /* alert(response.routes[0].duration); */
//    alert("스트링파이 리스폰\n"+JSON.stringify(response));
//    alert(JSON.stringify(response.routes[0]));
//    alert(JSON.stringify(response.routes[0]));
//    alert(JSON.stringify(response.routes[0].legs[0].duration.text))
//   alert(JSON.stringify(response.routes[0].legs[0].distance.text))
//alert(response.geocoded_waypoints[0].place_id);
       // alert(response.geocoded_waypoints[1].place_id);
       //$('#a2').val(response.duration.text);
        //$('#fortDetail').val(JSON.stringify(response.routes));
	
	google.maps.event.addDomListener(window, 'load', getLocation);
	
    </script>
    
    </head>

<body>
		<div id="panel" >
            <input type="hidden" id="start" value=""/>
            <input type="hidden" id="end" value=""/>
            <input type="text" id="temp" value="" onkeypress=
        "if(document.querySelector('#temp').value != ''&&event.keyCode==13) {Javascript:setTemp();}"/>
           
        </div>
        
		<div id="mainCity">
       		<h3>City테이블입력</h3>
       		
		</div>
		
		<div id="btn">
			<button onclick="moveStart()">전체루트</button>
			
			<button type='button' id = 'insert' style='WIDTH: 170pt; float:right; ' onclick= "{Javascript:movePlace();}">등록하기</button>
		</div>		
		<form id="formTag">
		<input type="hidden" id="jsonC" name="jsonC" value="우아아"/>
		</form>
 		<div id="map"></div>
		
</body>
</html>