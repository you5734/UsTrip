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
    key=AIzaSyBlWKR_u9NsT-3h0mdZ_5gg-aB4Eh58Ajo&v=3.exp&sensor=false&region=kr"></script>
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
 
 		form {			
			width:17%;
			height:85%;
			float:left;
		}
		
		#map {
			width:  83%;
			height: 85%;
        }
        
		#next1 {
			top: 50px;	
			height:600px;
			float:left;
		}
 
        #panel{
			position: fixed;
			margin-left: 25%;
          	margin-top: 9%;
			z-index: 5;
			background-color: #fff;
			padding: 3px;
        }
		
    </style>
	
     
	<script type="text/javascript">
	
	function moveStart(){
		
		self.location = "/view/plan/addCity.jsp";
		
	}
	
	function movePlace(){ 
		
		fncAddCity();
		 
	}

	function fncAddCity() {
		
		
		/* if($("#stayDate").text()==""){			
		$("#stayDate").val(2);
		}
		if($("#preCityNo").text()==""){			
		$("#preCityNo").val(555);
		}
		if($("#nextCityNo").text()==""){
		$("#nextCityNo").val(555);			
		} */
		
		$("#stayDate").val(2);
		$("#preCityNo").val(555);
		$("#nextCityNo").val(555);			
		
		var stayStart = "${sessionScope.travel.startDate}";
		var stayStart = new Date(stayStart);
		var stayStart = stayStart.getFullYear()+"-"+(stayStart.getMonth()*1+1)+"-"+stayStart.getDate();
		$("#stayStart").val(stayStart);
		var stayDate = $("input[name='stayDate']").val() * 1;
		var stayEnd = new Date(stayStart);
		stayEnd.setDate((stayEnd.getDate()*1 + stayDate*1));
		var stayEnd = stayEnd.getFullYear()+"-"+(stayEnd.getMonth()*1+1)+"-"+stayEnd.getDate();
		$("#stayEnd").val(stayEnd);
		
				
		$("form").attr("method", "POST").attr("action", "/plan/addCity")
				.submit();
	}
</script>


    <script>
    var directionsDisplay;
    var directionsService = new google.maps.DirectionsService();
    var map;
    var geocoder;//
    var temp;
    var start;
    var end;
	var tempNum = 0;
	

    function getLocation(){
        if(navigator.geolocation){
            navigator.geolocation.getCurrentPosition(initialize);
        }else{
            alert("Not Support Browser");
        }
    }        
 
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
      function getAddress(latlng) {
    		var geocoder = new google.maps.Geocoder();
    		geocoder.geocode({
    			latLng: latlng
  				
    		}, function(results, status) {
    			
    			var marker = new google.maps.Marker;
    			if (status == google.maps.GeocoderStatus.OK) {
    				if (results[0].geometry) {
    					
    					var address = results[0].formatted_address.replace(/^日本, /, '');
    					new google.maps.InfoWindow({
    						content: address + "<br>(Lat, Lng) = " + latlng
    					}).open(map, new google.maps.Marker({
    						position: latlng,
    						map: map
    					}));
    					
    					 alert(JSON.stringify(results[0]));
    					
    					markers.push(JSON.stringify(results[0].address_components[3].long_name)); 
    					/* alert(markers.length); */
    					if($('#startCity').val() == ""){
  	  					$('#startCity').val(results[0].address_components[3].long_name);
  	  					  
  	  					 
    					}else{
    						$('#city').val(results[0].address_components[3].long_name);
    					}
    					 alert(markers.length);
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
    			    	}
    			    }
    				}		
    			 
    		});    
      }
  }// end of initialize() 
      
    
    
    function setTemp() {
    	
    	tempNum++;
    		
		if(tempNum%2==0){
    		
    		end = document.getElementById('temp').value;
    		$('#city').val(end);
    		Javascript:calcRoute();
    		$("#temp").val(null);
    		
    		var newUpButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"    			    		
    		var newLeftButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button></br>"
    		
			$("#btn").append(newUpButton);
    		$("#formTag").append(newLeftButton);
		
    	}else if(tempNum%2!=0){
    		start = document.getElementById('temp').value;
    		$('#startCity').val(start);
    		
    		var newUpButton = "<button  onclick=\"movePlace('"+start+"')\">"+start+"</button>"    			    		
    		var newLeftButton = "<button  onclick=\"movePlace('"+start+"')\">"+start+"</button></br>"
    		
			$("#btn").append(newUpButton);
    		if(tempNum==1){
    			$("#mainCity").append(newLeftButton);
    		}else{
    		$("form").append(newLeftButton);
    		}
    		
			$("#temp").val(null);
    	}
    }// setTemp() 끝
    
    function calcRoute() {
   
      var start = document.getElementById('startCity').value;
      var end = document.getElementById('city').value;
      
      var mode = "TRANSIT";
 
      var request = {
          origin:start,
          destination:end,
          travelMode: eval("google.maps.DirectionsTravelMode."+mode)
      }; 
      
     
      directionsService.route(request, function(response, status) {
        
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
        }
     
       
        var city_x = JSON.stringify(response.routes[0].legs[0].end_location);
        city_x = city_x.replace(/[^0-9]/g,'');
        $('#cityX').val(city_x);
       
        var city_y = JSON.stringify(response.routes[0].legs[0].start_location);
        city_y = city_y.replace(/[^0-9]/g,'');
        $('#cityY').val(city_y); 
        
        $('#cityId').val(response.geocoded_waypoints[1].place_id);
        
   
      });
    }//end of calcRoute()
 
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
		</div>		
		 
		<form id="formTag">
		<input type="text" id="startCity" name="startCity">
    	<input type="text" id="city" name="city">
		<input type="text" class="form-control" id="stayDate" name="stayDate" >
		<input type="hidden" id="travelNo" name="travelNo" value="${sessionScope.travel.travelNo}"/>
		<input type="hidden" id="cityId" name="cityId"/>
		<input type="hidden" id="cityX" name="cityX"/>
		<input type="hidden" id="cityY" name="cityY"/>
		<input type="hidden" id="preCityNo" name="preCityNo"/>
		<input type="hidden" id="nextCityNo" name="nextCityNo"/>  
		<input type="hidden" id="stayStart" name="stayStart"/>
		<input type="hidden" id="stayEnd" name="stayEnd"/>    
		<br></br>
 		<div id="next1"></div>
		</form>
 	
 	<div id="map"></div>
		
</body>
</html>