<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
	
	<title>UsTrip</title>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/blitzer/jquery-ui.css">
	<style type="text/css">
        html, body {
          height: 100%;
          margin: 0;
          padding: 0;
          overflow:hidden
        }
 
        #map {
          height: 100%;
          margin-left: 18%;
          margin-top: 4%;
        }
 
 
        #panel{
          position: absolute;
          margin-top: 3.2%;
          left: 38%;
          margin-left: -180px;
          z-index: 5;
          background-color: #fff;
          padding: 5px;
          border: 1px solid #999;
        }
        
        #btn {
          position: absolute;
          top: 10px;
          left: 32%;
          margin-left: -180px;
          z-index: 5;
          background-color: #fff;
          padding: 5px;
          border: 1px solid #999;
        }
        form {
		  width:16.5%;
  		  height:600px;
		  float:left;
		}
    </style>
     
<script type="text/javascript">

		
	$( function() {
	    $( "#visitDate" ).datepicker({
	      dateFormat : "yy-mm-dd",
		  minDate: 0,
		  showOn: "button",
		  buttonImage: "http://kr.seaicons.com/wp-content/uploads/2015/06/calendar-icon.png",
	      buttonImageOnly: true,
	      showButtonPanel: true,
	      buttonText: "Select date" 
	    });
	    $("img.ui-datepicker-trigger").attr("style", "width:40px; vertical-align:middle; cursor: Pointer;");
	});
	
	function moveStart(){
		
		self.location = "/view/plan/addPlace.jsp";
		
	}
	
	function movePlace(){ 
		
		fncAddPlace();
		 
	}


	function fncAddPlace() {
		/* if($("#prePlaceNo").text()==""){			
		$("#prePlaceNo").val(555);
		}
		if($("#nextPlaceNo").text()==""){
		$("#nextPlaceNo").val(555);			
		} */
		$("#prePlaceNo").val(555);
		$("#nextPlaceNo").val(555);
		
		$("form").attr("method", "POST").attr("action", "/plan/addPlace")
				.submit();
	}

		
</script>
<script src="https://maps.googleapis.com/maps/api/js?
    key=AIzaSyBlWKR_u9NsT-3h0mdZ_5gg-aB4Eh58Ajo&v=3.exp&sensor=false&region=kr"></script>
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
        zoom:16,
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
    					if($('#startPlace').val() == ""){
  	  					$('#startPlace').val(results[0].address_components[3].long_name);
  	  					  
  	  					 
    					}else{
    						$('#place').val(results[0].address_components[3].long_name);
    					}
    					 alert(markers.length);
    					if(markers.length%2==0){
    			    		
    			    		end = document.getElementById('place').value;
    			    		Javascript:calcRoute();
    			    		
    			    		var newUpButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"    			    		
    			    		var newLeftButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"
    			    			
    						$("#btn").append(newUpButton);
    			    		$(".form-horizontal").append(newLeftButton);			  
    					
    			    	}else if(markers.length%2!=0){
    			    		start = document.getElementById('startPlace').value;
    			    		
    			    		var newUpButton = "<button  onclick=\"movePlace('"+start+"')\">"+start+"</button>"
    			    		var newLeftButton = "<button  onclick=\"movePlace('"+start+"')\">"+start+"</button>"
    			    			
    						$("#btn").append(newUpButton);				
    			    		$(".form-horizontal").append(newLeftButton);
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
    		$('#place').val(end);
    		Javascript:calcRoute();
    		$("#temp").val(null);
    		var nc = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"
    		
    		var newUpButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"    			    		
    		var newLeftButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"
    		
			$("#btn").append(newUpButton);
    		$(".form-horizontal").append(newLeftButton);
		
    	}else if(tempNum%2!=0){
    		start = document.getElementById('temp').value;
    		$('#startPlace').val(start);
    		
    		var newUpButton = "<button  onclick=\"movePlace('"+start+"')\">"+start+"</button>"    			    		
    		var newLeftButton = "<button  onclick=\"movePlace('"+start+"')\">"+start+"</button>"
    		
			$("#btn").append(newUpButton);
    		$(".form-horizontal").append(newLeftButton);
    		
			$("#temp").val(null);
    	}
    }// setTemp() 끝
    
    function calcRoute() {
   
      var start = document.getElementById('startPlace').value;
      var end = document.getElementById('place').value;
      
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
        $('#placeX').val(place_x);
       
        var place_y = JSON.stringify(response.routes[0].legs[0].start_location);
        place_y = place_y.replace(/[^0-9]/g,'');
        $('#placeY').val(place_y); 
        
        $('#placeId').val(response.geocoded_waypoints[1].place_id);
   
      });
    }
 
    google.maps.event.addDomListener(window, 'load', getLocation);
 
    </script>
    </head>

<body>
	<div class="container">
		
		<div class="page-header text-info">
       		<h3>Place테이블입력</h3>
    	</div>
			
		<form class="form-horizontal">
		  
		<input type="hidden" id="cityNo" name="cityNo" value="${sessionScope.city.cityNo}"/>
		<input type="hidden" id="travelNo" name="travelNo" value="${sessionScope.city.travelNo}"/>
		<input type="hidden" id="placeId" name="placeId"/>
		<input type="hidden" id="placeX" name="placeX"/>
		<input type="hidden" id="placeY" name="placeY"/>
		<input type="hidden" id="prePlaceNo" name="prePlaceNo"/>
		<input type="hidden" id="nextPlaceNo" name="nextPlaceNo"/>
					  
		<div class="form-group">
		    <label for="visitDate" class="col-xs-4 col-md-2">방문날짜</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="visitDate"  name="visitDate" placeholder="">
		    </div>
		</div>
		  
		<div class="form-group">
		    <label for="startPlace" class="col-xs-4 col-md-2">출발장소</label>
		    <div class="col-sm-4">
		        <input type="text" class="form-control" id="startPlace" name="startPlace" placeholder="">
		    </div>
		</div>
		  
		<div class="form-group">
		    <label for="place" class="col-xs-4 col-md-2">도착장소</label>
		    <div class="col-sm-4">
		        <input type="text" class="form-control" id="place"  name="place" placeholder="">
		    </div>
		</div>
		  
		<div class="form-group">
		    <label for="memo" class="col-xs-4 col-md-2">메모</label>
		    <div class="col-sm-4">
		        <input type="text" class="form-control" id="memo"  name="memo" placeholder="">
		    </div>
		</div>
		  
		  		  
		</form>
 	</div>
	
	<div id="panel" >
            <input type="hidden" id="start" value=""/>
            <input type="hidden" id="end" value=""/>
            <input type="text" id="temp" value="" onkeypress=
        "if(document.querySelector('#temp').value != ''&&event.keyCode==13) {Javascript:setTemp();}"/>	
           
        </div>
        
        <div id="map">
        </div>
        
        <div id="btn">
			<button onclick="moveStart()">전체루트</button>
		</div>	
	
</body>
</html>



