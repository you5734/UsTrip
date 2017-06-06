<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
	<title>UsTrip</title>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/sunny/jquery-ui.css">
	<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<style type="text/css">
        html, body {
          height: 100%;
          margin: 0;
          padding: 0;
          overflow:hidden
        }
 
        #map {
          height: 100%;
          margin-left: 20%;
        }
 
 
        #panel{
          position: absolute;
          top: 90px;
          left: 47%;
          margin-left: -180px;
          z-index: 5;
          background-color: #fff;
          padding: 5px;
          border: 1px solid #999;
        }
        
        #btn {
          position: absolute;
          top: 10px;
          left: 34%;
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
	
	function moveStart(){
		
		self.location = "/view/plan/addCity.jsp";
		
	}
	
	function movePlace(){ 
		
		fncAddCity();
		 
	}

	function fncAddCity() {
		
		var stayStart = $("input[name='stayStart']").val();
		var stayDate = $("input[name='stayDate']").val();
		var stayEnd = stayStart;
		var year = stayEnd.substr(0,4);
		var month = stayEnd.substr(5,2);
		var day = parseInt(stayEnd.substr(8,2))+parseInt(stayDate);
		stayEnd = year+"-"+month+"-"+day;
		$("#stayEnd").val(stayEnd);
		
				
		$("form").attr("method", "POST").attr("action", "/plan/addCity")
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
    					/* $('#123').val(JSON.stringify(results[0])); */
    					markers.push(JSON.stringify(results[0].address_components[3].long_name)); 
    					/* alert(markers.length); */
    					if($('#123').val() == ""){
  	  					$('#123').val(results[0].address_components[3].long_name);
  	  					  
  	  					 
    					}else{
    						$('#city').val(results[0].address_components[3].long_name);
    					}
    					 alert(markers.length);
    					if(markers.length%2==0){
    			    		
    			    		end = document.getElementById('city').value;
    			    		Javascript:calcRoute();
    			    		
    			    		var nc = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"    			    		
    			    		  			    		
    						$("#btn").append(nc);
    					
    			    	}else if(markers.length%2!=0){
    			    		start = document.getElementById('123').value;
    			    		
    			    		
    			    		//$("#temp").val(null);
    			    		var nc = "<button  onclick=\"movePlace('"+start+"')\">"+start+"</button>"
    						  			    		
    						$("#btn").append(nc);				
    						
    			    	}
    			    }
    				}		
    			 /* alert(markers[0]);
    			alert(markers[1]); */		 
    		});    
      }
  } 
      
    
    
    function setTemp() {
    	
    	tempNum++;
    	
    		
if(tempNum%2==0){
    		
    		end = document.getElementById('temp').value;
    		$('#city').val(end);
    		Javascript:calcRoute();
    		$("#temp").val(null);
    		var nc = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"
    		
    		
    		
			$("#btn").append(nc);
			
			
		
    	}else if(tempNum%2!=0){
    		start = document.getElementById('temp').value;
    		$('#123').val(start);
    		
    		//$("#temp").val(null);
    		var nc = "<button  onclick=\"movePlace('"+start+"')\">"+start+"</button>"
			
    		
			$("#btn").append(nc);
			
			$("#temp").val(null);
    	}
    }// setTemp() 끝
    
    function calcRoute() {
   // 	$('#a5').val(this.temp);
      var start = document.getElementById('123').value;
      var end = document.getElementById('city').value;
      
      var mode = "TRANSIT";
 
      var request = {
          origin:start,
          destination:end,
          travelMode: eval("google.maps.DirectionsTravelMode."+mode)
      }; //alert(JSON.stringify(request));
     // alert(request.origin);
//출발지      $('#a1').val(request.origin);
      
//도착지     $('#nextCity').val(request.destination);
      
     
      directionsService.route(request, function(response, status) {
        
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
        }
        
       /*  $('#cityId').val(JSON.stringify(response)); */
       // alert("좌표"+JSON.stringify(response.geocoded_waypoints.geometry));
       
        var city_x = JSON.stringify(response.routes[0].legs[0].end_location);
        city_x = city_x.replace(/[^0-9]/g,'');
        $('#cityX').val(city_x);
       
        var city_y = JSON.stringify(response.routes[0].legs[0].start_location);
        city_y = city_y.replace(/[^0-9]/g,'');
        $('#cityY').val(city_y); 
        
        $('#cityId').val(response.geocoded_waypoints[1].place_id);
        
       // alert(response.geocoded_waypoints);
         
    /* alert(response.routes[0].duration); */
//    alert("스트링파이 리스폰\n"+JSON.stringify(response));
//    alert(JSON.stringify(response.routes[0]));
//    alert(JSON.stringify(response.routes[0]));
//    alert(JSON.stringify(response.routes[0].legs[0].duration.text))
//   alert(JSON.stringify(response.routes[0].legs[0].distance.text))
    var route = response.routes[0];
    $('#a2').val(route.legs[0].duration.text);
    $('#a3').val(route.legs[0].distance.text);
        //alert(response.geocoded_waypoints[0].place_id);
       // alert(response.geocoded_waypoints[1].place_id);
       //$('#a2').val(response.duration.text);
        //$('#fortDetail').val(JSON.stringify(response.routes));
   
      });
    }
 
    google.maps.event.addDomListener(window, 'load', getLocation);
 
    </script>
    </head>

<body>

	<div class="container">
		  
		  <div class="page-header text-info">
       		<h3>City테이블입력</h3>
    	  </div>
		  
		<form class="form-horizontal">
		  <input type="hidden" id="travelNo" name="travelNo" value="${sessionScope.travel.travelNo}"/>
		  
		   <div class="form-group">
		    <label for="123" class="col-xs-4 col-md-2">출발도시</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="123" name="123" placeholder="">
		    </div>
		  </div>
		  		  
		  <div class="form-group">
		    <label for="cityId" class="col-xs-4 col-md-2">도시아이디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="cityId" name="cityId" placeholder="">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="city" class="col-xs-4 col-md-2">도시명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="city" name="city" placeholder="">
		    </div>
		  </div>

		  <div class="form-group">
		    <label for="preCityNo" class="col-xs-4 col-md-2">이전도시번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="preCityNo" name="preCityNo" placeholder="">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="nextCityNo" class="col-xs-4 col-md-2">다음도시번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="nextCityNo" name="nextCityNo" placeholder="">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="cityX" class="col-xs-4 col-md-2">도시X좌표</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="cityX" name="cityX" placeholder="">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="cityY" class="col-xs-4 col-md-2">도시Y좌표</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="cityY" name="cityY" placeholder="">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="stayDate" class="col-xs-4 col-md-2">숙박일</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="stayDate" name="stayDate" >
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="stayStart" class="col-xs-4 col-md-2">숙박시작일</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="stayStart"  name="stayStart" value="${sessionScope.travel.startDate}">
		    </div>
		  </div>
		  	  
		  <div class="form-group">
		    <label for="stayEnd" class="col-xs-4 col-md-2">숙박종료일</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="stayEnd"  name="stayEnd">
		    </div>
		  </div>
		    
		  <br/>
		  <hr/>
	
		</form>
		
 	</div>
	
		<div id="panel" >
            <input type="hidden" id="start" value=""/>
            <input type="hidden" id="end" value=""/>
            <input type="text" id="temp" value="" onkeypress=
            	"if(event.keyCode==13) {Javascript:setTemp();}"/>	
           
        </div>
        
        <div id="map">
        </div>
        
        <div id="btn">
			<!-- <button onclick="openCity('London')">London</button> -->
			<button onclick="moveStart()">전체루트</button>
		</div>		
		
</body>
</html>