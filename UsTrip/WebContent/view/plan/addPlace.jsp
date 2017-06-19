<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
	
	<title>UsTrip</title>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBlWKR_u9NsT-3h0mdZ_5gg-aB4Eh58Ajo&v=3.exp&libraries=places&region=kr"></script>
	<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/blitzer/jquery-ui.css">
	<style type="text/css">
        html, body {
			height: 100%;
			margin: 0;
			padding: 0;
			overflow:hidden;        
        }
 
 		#mainPlace {
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
        
         #temp {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 300px;
      }
      #temp:focus {
        border-color: #4d90fe;
      }
      .temp-container {
        font-family: Roboto;
      }
      
      	#duration, #distance{
			border:none;
      	}  
		
    </style>

    <script>
    var directionsDisplay;
    var directionsService = new google.maps.DirectionsService();
    var map;
    var geocoder;
    var temp;
    var start;
    var end;
	var tempNum = 0;
	
	var startCityX =  document.location.href.split("?")[1]*1;  
	var startCityY =  document.location.href.split("?")[2]*1;  
	var cityValue = decodeURIComponent(document.location.href.split("?")[3]); 
	
	
	
	$(document).ready(function() {
		
		
	setTemp();
		var startPlace = "${sessionScope.city.city}";	
		var strArray = startPlace.split('_');
		startPlace = strArray[0];
		$("#f0 input[name='startPlace']").val(startPlace); 
		
	});		
	
	function moveStart(){
		
		//self.location = "/view/plan/addPlace.jsp";
		
	}
		
	function movePlace(){ 
		/* 
		for(var i = 0; i < tempNum-1; i++){
			
			$("#f"+(i)+" input[name='stayStart']").val(stayStart);
			var stayDate = $("#f"+(i)+" input[name='stayDate']").val();
			var stayEnd = new Date(stayStart);
	   		stayEnd.setDate((stayEnd.getDate()*1 + stayDate*1));
	   		stayEnd = stayEnd.getFullYear()+"-"+(stayEnd.getMonth()*1+1)+"-"+stayEnd.getDate();
			$("#f"+(i)+" input[name='stayEnd']").val(stayEnd)
			stayStart = stayEnd;
		}
		 */
		//json으로 담기
      /* 
        for(var i = 0; i < tempNum-1; i++){
        	
	        var placeObj = new Object();
	        
	        placeObj.startCity = $("#f"+(i)+" input[name='startCity']").val();
	        placeObj.city = $("#f"+(i)+" input[name='city']").val();
	        placeObj.city = $("#f"+(i)+" input[name='city']").val();
	        placeObj.travelNo = travelNo;
	        placeObj.cityId = $("#f"+(i)+" input[name='cityId']").val();
	        placeObj.cityX = $("#f"+(i)+" input[name='cityX']").val();
	        placeObj.cityY = $("#f"+(i)+" input[name='cityY']").val();
	        placeObj.preCityNo = $("#f"+(i)+" input[name='preCityNo']").val();
	        placeObj.nextCityNo = $("#f"+(i)+" input[name='nextCityNo']").val();
	        placeObj.stayStart = $("#f"+(i)+" input[name='stayStart']").val();
	        placeObj.stayDate = $("#f"+(i)+" input[name='stayDate']").val();
	        placeObj.stayEnd = $("#f"+(i)+" input[name='stayEnd']").val();
	        placeArray.push(placeObj);
        }
        
		placeObj = placeArray;
        var jsonPlace = JSON.stringify(placeObj);
        $("#jsonC").val(jsonPlace);
		
		  */
		fncAddPlace();
	}
	function fncAddPlace() {
		
		$("form").attr("method", "POST").attr("action", "/plan/addPlace").submit();
				
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
			
		/* cityX = cityX*1; 
		cityY = cityY*1; */
		
		var currentLocation = [];
		
      var currentLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
    
      var mapOptions = {
        zoom:13,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
      /*   center: currentLocation */
        center : { lat: startCityX ,  lng: startCityY} 
      }
      map = new google.maps.Map(document.getElementById('map'), mapOptions);
      directionsDisplay.setMap(map);
      var markers = [];
      
      google.maps.event.addListener(map, 'click', function(e) {
          getAddress(e.latLng);
          
          
          
      });
      
          // Create the search box and link it to the UI element.
          var input = document.getElementById('temp');
          var searchBox = new google.maps.places.SearchBox(input);
          map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
          // Bias the SearchBox results towards current map's viewport.
          map.addListener('bounds_changed', function() {
            searchBox.setBounds(map.getBounds());
          });
          var markers = [];
          // Listen for the event fired when the user selects a prediction and retrieve
          // more details for that place.
          searchBox.addListener('places_changed', function() {
            var places = searchBox.getPlaces();
            if (places.length == 0) {
              return;
            }
            // Clear out the old markers.
            markers.forEach(function(marker) {
              marker.setMap(null);
            });
            markers = [];
            // For each place, get the icon, name and location.
            var bounds = new google.maps.LatLngBounds();
            places.forEach(function(place) {
              if (!place.geometry) {
                console.log("Returned place contains no geometry");
                return;
              }
              var icon = {
                url: place.icon,
                size: new google.maps.Size(71, 71),
                origin: new google.maps.Point(0, 0),
                anchor: new google.maps.Point(17, 34),
                scaledSize: new google.maps.Size(25, 25)
              };
              // Create a marker for each place.
              markers.push(new google.maps.Marker({
                map: map,
                icon: icon,
                title: place.name,
                position: place.geometry.location
              }));
              if (place.geometry.viewport) {
                // Only geocodes have viewport.
                bounds.union(place.geometry.viewport);
              } else {
                bounds.extend(place.geometry.location);
              }
            });
            map.fitBounds(bounds);
          });
      
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////      
      poly = new google.maps.Polyline({
  	    strokeColor: '#000000',
  	    strokeOpacity: 1.0,
  	    strokeWeight: 3
  	  });
  	  poly.setMap(map);
  	  // Add a listener for the click event
  	  map.addListener('click', addLatLng);
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
    					new google.maps.InfoWindow({
    						content: address + "<br>(Lat, Lng) = " + latlng
    					}).open(map, new google.maps.Marker({
    						position: latlng,
    						map: map
    					}));
    					
    				//	 alert(JSON.stringify(results[0]));
    					
    					markers.push(JSON.stringify(results[0].address_components[3].long_name)); 
    					/* alert(markers.length); */
    					if($('#startPlace').val() == ""){
  	  					$('#startPlace').val(results[0].address_components[3].long_name);
    					}else{
    						$('#place').val(results[0].address_components[3].long_name);
    					}
    				//	 alert(markers.length); //마커 갯수
    					if(markers.length%2==0){
    			    		
    			    		end = document.getElementById('place').value;
    			    		Javascript:calcRoute();
    			    		
    			    		var newUpButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"    			    		
    			    		var newLeftButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button></br>"
    			    			
    						$("#btn").append(newUpButton);
    			    		$("#formTag").append(newLeftButton);			  
    					
    			    	}else if(markers.length%2!=0){
    			    		start = document.getElementById('startPlace').value;
    			    		
    			    		
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
/////////////////////////////////////////////////////////////////////////////////////////////////////////      
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////    
    function setTemp() {
    	
    	if(tempNum==0){
    		
    		start = cityValue;
    		//start = document.getElementById('temp').value;
    		
    		var newUpButton = "<button>"+start+"</button>"
    		var newLeftButton = "<button>"+start+"</button>"
    		
    		$("#btn").append(newUpButton);
    		$("#mainPlace").append(newLeftButton);
			$("#temp").val(null);
			
			tempNum++;
			return;
    	}
    		tempNum++;	
    	
    		end = document.getElementById('temp').value;
    		
    		$("#temp").val(null);
    		
    		var newUpButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"    			    		
    		var newLeftButton = "<form id = 'f"+(tempNum-2)+"'>"    //여긴 하나 있어서 1부터			
    			+"<input type='text' id='visitDate' name='visitDate'/>"
    			+"<input type='text' id='startPlace' name='startPlace'/>"
    			+"<input type='text' id='place' name='place'/>"
    			+"<input type='text' id='memo' name='memo'/>"
    			+"<input type='text' id='distance' name='distance'/>"
    			+"<input type='text' id='duration' name='duration'/>"
    			+"<input type='hidden' id='cityNo' name='cityNo' value='${sessionScope.city.cityNo}'/>"
    			+"<input type='hidden' id='travelNo' name='travelNo' value='${sessionScope.city.travelNo}'/>"
    			+"<input type='hidden' id='placeId' name='placeId'/>"
    			+"<input type='hidden' id='placeX' name='placeX'/>"
    			+"<input type='hidden' id='placeY' name='placeY'/>"
    			+"<input type='hidden' id='prePlaceNo' name='prePlaceNo'/>"
    			+"<input type='hidden' id='nextPlaceNo' name='nextPlaceNo'/>"
    			+"<button  style='WIDTH: 170pt; HEIGHT: 20pt' onclick=\"movePlace('"+end+"')\">"+end+"</button>"
    			+"</form>"
    			+"<br></br>";
			$("#btn").append(newUpButton);
			if(tempNum>1){
				
    		$("#formTag").append(newLeftButton);
			}
    		
    		$("#start").val(start);
    		$("#end").val(end);    		
    		
    		$("#f"+(tempNum-2)+" input[name='startPlace']").val(document.querySelector('#start').value);
    		$("#f"+(tempNum-2)+" input[name='place']").val(document.querySelector('#end').value);
    		$("#f"+(tempNum-2)+" input[name='prePlaceNo']").val(tempNum-2);
    		$("#f"+(tempNum-2)+" input[name='nextPlaceNo']").val(tempNum);
    		
   			Javascript:calcRoute();
    		start = end;
    		
    }// setTemp() 끝
/////////////////////////////////////////////////////////////////////////////////////////////////////////
  function addLatLng(event) {
	//	alert(event); // 뭔진 모르겠고 [object Object] 이렇게 나옴
	//	alert(JSON.stringify(event));
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
	}
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
            directionsDisplay.setDirections(response);
        }
     	
       
        var place_x = JSON.stringify(response.routes[0].legs[0].end_location);
        place_x = place_x.replace(/[^0-9]/g,'');
        
        $("#f"+(tempNum-2)+" input[name='placeX']").val(place_x);
        var place_y = JSON.stringify(response.routes[0].legs[0].start_location);
        place_y = place_y.replace(/[^0-9]/g,'');
         
        $("#f"+(tempNum-2)+" input[name='placeY']").val(place_y);
        
        $("#f"+(tempNum-2)+" input[name='placeId']").val(response.geocoded_waypoints[1].place_id);
         $("#formTag input[name='duration']").eq(tempNum-2).val(JSON.stringify(response.routes[0].legs[0].duration.text));
        $("#formTag input[name='distance']").eq(tempNum-2).val(JSON.stringify(response.routes[0].legs[0].distance.text)); 
		
      });
    }//end of calcRoute()
///////////////////////////////////////////////////////////////////////////////////////////////////////// 
	
	google.maps.event.addDomListener(window, 'load', getLocation);
	
    </script>
    
    </head>

<body>

		<div id="panel" >
            <input type="hidden" id="jsonC" value=""/>
            <input type="hidden" id="start" value=""/>
            <input type="hidden" id="end" value=""/>
            <input type="hidden" id="startX" value=""/>
            <input type="hidden" id="startY" value=""/>
            <input id="temp" class="controls" type="text" onkeypress=
        "if(document.querySelector('#temp').value != ''&&event.keyCode==13) {Javascript:setTemp();}"/>
           
        </div>
        
		<div id="mainPlace">
       		<h3>Place테이블입력</h3>
       		<br>
    	</div>
		
		<div id="btn">
			<button onclick="moveStart()">전체루트</button>
		</div>		
		<div id="formTag" class="formC">
		
	<%-- 	<form id = "f0">
		<input type="text" id="visitDate"  name="visitDate" value="${sessionScope.city.stayEnd}"/>
        <input type="text" id="startPlace" name="startPlace"/>
        <input type="text" id="place"  name="place"/>
        <input type="text" id="memo"  name="memo"/>
		<input type="hidden" id="cityNo" name="cityNo" value="${sessionScope.city.cityNo}"/>
		<input type="hidden" id="travelNo" name="travelNo" value="${sessionScope.city.travelNo}"/>
		<input type="hidden" id="placeId" name="placeId"/>
		<input type="hidden" id="placeX" name="placeX"/>
		<input type="hidden" id="placeY" name="placeY"/>
		<input type="hidden" id="prePlaceNo" name="prePlaceNo"/>
		<input type="hidden" id="nextPlaceNo" name="nextPlaceNo"/>
		</form>		
		<br></br> --%>
		 
		 
		</div>
		 	
		<div id="map"></div>
		
</body>
</html>
