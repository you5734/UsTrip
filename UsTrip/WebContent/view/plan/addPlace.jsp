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
    
    var directionsDisplay;
    var directionsService = new google.maps.DirectionsService();
    var map;
    var geocoder;
    var temp;
    var start;
    var end;
	var tempNum = 0;
	var tempNumNum = 0;
	var travelNo = document.location.href.split("?")[1]*1;
	var cityNo = document.location.href.split("?")[2]; 
	var startCityX =  document.location.href.split("?")[3]*1;  
	var startCityY =  document.location.href.split("?")[4]*1;  
	var stayStart = decodeURIComponent(document.location.href.split("?")[5]); 
	var stayDate = decodeURIComponent(document.location.href.split("?")[6]); 
	var stayEnd = decodeURIComponent(document.location.href.split("?")[7]); 
	var defaultVisitDate = stayStart;
	var visitDate = stayStart;
	var visitDay;
	var appendDiv = "#dd1";
	var XValue;
	var YValue;
	var placeValue;
	var routes = [];
	var infowindow;
	var places, infoWindow;
	var markers = [];
	var autocomplete;
	var iconColor="";
	var markerPath="http://maps.google.com/mapfiles/ms/icons/";
	var hostnameRegexp = new RegExp('^https?://.+?/');
	var CBroute;
	var line = [];
	var marrk = [];
	
	 $(function(){
	  	  $(document).on("click","#btn-route",function(){
			
				startRoute = encodeURIComponent($(this).parent().find(".startPlace").val());
				endRoute = encodeURIComponent($(this).parent().find(".place").val());
				
				window.open('/view/plan/placeRoute.jsp?'+startRoute+"?"+endRoute);
	 
	    });
	   });
	
	function openCity(cityName) {
		 
		 for (var i = 0; i < markers.length; i++) {
             markers[i].setMap(null);
		 } markers.length = 0;
		 
		 for (i=0; i<line.length; i++){                           
		   line[i].setMap(null); 
		 }line.length = 0;
		 routes.length = 0;
		
		 var formLength = 0; 
		 
		formLength = $("#"+cityName).find($("form[name='ddform']")).length;
		
		for ( var xx = 0; xx < formLength; xx++ ) {
			
			placeX = $("#"+cityName).find($(".f"+(xx))).find($(".placeX")).val()*1;
			placeY = $("#"+cityName).find($(".f"+(xx))).find($(".placeY")).val()*1;
		
			var placeXY = new Object();
	        
	        placeXY.lat = placeX*1;
	        placeXY.lng = placeY*1;
	      
	        var marrk = placeXY;
	       	 routes.push(placeXY);
	       	
	       	var marker = new google.maps.Marker({
	    		position: marrk,
	    		map: map
	  			}); 
	       	markers.push(marker);
	       	      	
		}
                        	
                	                           var CBroute = new google.maps.Polyline({
                	                             path: routes,
                	                             geodesic: true,
                	                             strokeColor: '#b31543',
                	                             strokeOpacity: 1.0,
                	                             strokeWeight: 2
                	                           });
                	                           CBroute.setMap(map);
                	                           line.push(CBroute); 
        var i;
        var x = document.getElementsByClassName("dd");
        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none"; 
        }
        document.getElementById(cityName).style.display = "block"; 
    }
	
	function len_chk(){  
		  var frm = document.insertFrm.test; 
		  
		  if(frm.value.length > 4000){  
		       alert("글자수는 영문100, 한글50자로 제한됩니다.!");  
		       frm.value = frm.value.substring(0,100);  
		       frm.focus();  
		  } 

		} 
	
	$(function(){// 
		$(document).on("click","#cch",function(){
			
			start = null;
			end = null;
			
			appendDiv = '#d'+$(this).attr('class')+'';
			
			tempNum = 0;
			
			visitDay = $(this).attr('class').split("d")[1];
			
			visitDate = defaultVisitDate;
			
			if(visitDay==null){
				visitDay = 1;
    		}
			
			visitDate = new Date(visitDate);
			visitDate.setDate((visitDate.getDate()*1 + (visitDay-1)*1));
			visitDate = visitDate.getFullYear()+"-"+(visitDate.getMonth()*1+1)+"-"+visitDate.getDate();
			
		});
	
		$(document).on("click","#insert",function(){
			
			movePlace()
			
		});
		
    });

	var btnDay;// day 찾아가는 버튼
	var divDay;// day 폼 입력하는 div
	
	$(document).ready(function() {
		

		for (var i=0; i<stayDate; i++){
		
			btnDay = "<button id='cch' class='"+"d"+(i+1)+"' onclick=\"openCity('"+"dd"+(i+1)+"')\">"+"d"+(i+1)+"</button>";
			$("#btnClass").append(btnDay);
			
			divDay = "<div id="+"dd"+(i+1)+" class='dd'></div>";
			
			$("#cityOOO").append(divDay);
			
		}// end of for
		
	});		
	
	function moveStart(){
		
		//self.location = "/view/plan/addPlace.jsp";
		
	}
		
	function movePlace(){ 
		
for(var h = 0; h < stayDate; h++){
			
			var addId = '#dd' ;
			
			addId = eval('addId+(h+1)');
			
		for(var i = 0; i < $(addId).find( $("#f1 input[name='tempCount']")).val(); i++){
			
	        	eval("var placeObj"+i+"= new Object()");
		        
		        eval("placeObj"+i).visitDate = $(addId).find($("#f"+(i)+" input[name='visitDate']")).val();
		        eval("placeObj"+i).place =$(addId).find( $("#f"+(i)+" input[name='place']")).val();
		        eval("placeObj"+i).memo = $(addId).find($("#f"+(i)+" textarea[name='memo']")).val();
		        eval("placeObj"+i).cityNo = cityNo;
		        eval("placeObj"+i).travelNo = travelNo;
		        eval("placeObj"+i).placeId = $(addId).find($("#f"+(i)+" input[name='placeId']")).val();
		        eval("placeObj"+i).placeX = $(addId).find($("#f"+(i)+" input[name='placeX']")).val();
		        eval("placeObj"+i).placeY = $(addId).find($("#f"+(i)+" input[name='placeY']")).val();
		        eval("placeObj"+i).prePlaceNo = $(addId).find($("#f"+(i)+" input[name='prePlaceNo']")).val();
		        eval("placeObj"+i).nextPlaceNo = $(addId).find($("#f"+(i)+" input[name='nextPlaceNo']")).val();

	        	var jsonPlace = JSON.stringify(eval("placeObj"+i));
			        	
		        $.ajax({
		        	type : "POST",
		        	url : "/plan/addPlace",
		        	async: false,
		        	data :{ a:jsonPlace},
		        	datatype : "json",
		        	context: this,
		        	success: function(result)
		        	{
		        		alert(result);
		        	}
		        }); 
	        	
	        }//end of for()
	        
		}//end of for()
	        
			fncAddPlace();
		}

		function fncAddPlace() {
			
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
			
		
		var currentLocation = [];
		
      var currentLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
      
      var mapStyles = [{
          "featureType": "poi.attraction",
              "elementType": "labels",
              "stylers": [{
              "visibility": "on",
               "color": "#99FF33" 
          }]
      }];
    
      var mapOptions = {
        zoom:14,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
      /*   center: currentLocation */
        center :{ lat: startCityX ,  lng: startCityY} ,
      styles: mapStyles
      }
    //  { lat: 35.7090 ,  lng: 139.7319} ,
     // { lat: startCityX ,  lng: startCityY} ,
      map = new google.maps.Map(document.getElementById('map'), mapOptions);
      
      infowindow = new google.maps.InfoWindow();
      ////////////////////공원에 마커 생성//////////////////////
   /*    var service = new google.maps.places.PlacesService(map);
      service.nearbySearch({
        location: { lat: startCityX ,  lng: startCityY},
        radius: 20000,
        types: ["park"]
        
      }, callback);
       */
      directionsDisplay.setMap(map);
      
      
     /*  google.maps.event.addListener(map, 'click', function(e) {
          getAddress(e.latLng);
          
      }); */
      infoWindow = new google.maps.InfoWindow({
          content: document.getElementById('info-content')
          });
      places = new google.maps.places.PlacesService(map);
      google.maps.event.addDomListener(document.getElementById('interest'),'change',setAutocompleteUsername);
          // Create the search box and link it to the UI element.
          var input = document.getElementById('temp');
          var options = {
        		  /////////////////////////////type[] 지정/////////////////////////////////////////////////////////////////
        	        componentRestrictions: {country: 'kr'}
        	      };
         var autocomplete = new google.maps.places.Autocomplete(input, options);
          map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

          // Bias the SearchBox results towards current map's viewport.
          map.addListener('bounds_changed', function() {
        	  autocomplete.setBounds(map.getBounds());
          });

          
          // Listen for the event fired when the user selects a prediction and retrieve
          // more details for that place.
          autocomplete.addListener('places_changed', function() {
            var places = autocomplete.getPlaces();

            if (places.length == 0) {
              return;
            }

            // Clear out the old markers.
            markers.forEach(function(marker) {
              marker.setMap(null);
            });
            

            // For each place, get the icon, name and location.
            var bounds = new google.maps.LatLngBounds();
            places.forEach(function(place) {
              if (!place.geometry) {
                console.log("Returned place contains no geometry");
                return;
              }
              alert(JSON.stringify(place));
              alert(JSON.stringify(places));
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
      
      function getAddress(latlng) {
    		var geocoder = new google.maps.Geocoder();
    		geocoder.geocode({
    			latLng: latlng
  				
    		}, function(results, status) {
    			
    			var marker = new google.maps.Marker;
    			if (status == google.maps.GeocoderStatus.OK) {
    				if (results[0].geometry) {
    					
    					var address = results[0].formatted_address.replace(/^日本, /, '');
							/* address = address.split(' ');
	    					
	    					address = address[1]+" " +address[2] */
    					new google.maps.InfoWindow({
    						content: address + "<br>(Lat, Lng) = " + latlng
    					})/* .open(map, new google.maps.Marker({
    						position: latlng,
    						map: map
    					})); *///인포박스
    				 	alert(JSON.stringify(results[0]));
    					$("#temp").val(address);
    					setTemp()
    					
    				//	 alert(JSON.stringify(results[0]));
    					/* 
    					markers.push(JSON.stringify(results[0].address_components[3].long_name)); 
    				
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
    			    	} */
    			    }
    				}		
    			 
    		});    
      }
  }// end of initialize() 
/////////////////////////////////////////////////////////////////////////////////////////////////////////    

///// 유형별로 마커 생성//////////////////
    /*  function callback(results, status) {
        if (status === google.maps.places.PlacesServiceStatus.OK) {
          for (var i = 0; i < results.length; i++) {
            createMarker(results[i]);
          }
        }
      }

      function createMarker(place) {
        var placeLoc = place.geometry.location;
        var marker = new google.maps.Marker({
          map: map,
          position: place.geometry.location
        });

        google.maps.event.addListener(marker, 'click', function() {
          infowindow.setContent(place.name);
          infowindow.open(map, this);
        });
      } */
/////////////////////////////////////////////////////////////////////////////////////////////////////////    
      function setTemp() {
    	
    	if(tempNum==0){
    		
    		
    		start = document.getElementById('temp').value;
    		
    		var newUpButton = "<button>"+start+"</button>"
    		var newLeftButton = "<button style='WIDTH: 170pt;'>"+start+"</button>"
    		
    		var newLeftDiv = "<form id = 'f0' class = 'f0' name='ddform' value='yyyyyyyy' style='display:none'>"
    			+"<input type='hidden' id='visitDate' name='visitDate'/>"
    			+"<input type='hidden' id='place' name='place' class='place'/>"
    			+"<textarea onKeyup='len_chk()' rows='3.4' cols='29' style='resize:none;' type='text' id='memo' name='memo' class='memo'/>"
    			+"<input type='hidden' id='cityNo' name='cityNo' class='cityNo'/>"
    			+"<input type='hidden' id='travelNo' name='travelNo' class='travelNo'/>"
    			+"<input type='hidden' id='placeId' name='placeId' class='placeId'/>"
    			+"<input type='hidden' id='placeX' name='placeX' class='placeX'/>"
    			+"<input type='hidden' id='placeY' name='placeY' class='placeY'/>"
    			+"<input type='hidden' id='placeXY' name='placeXY' class='placeXY'/>"
    			+"<input type='hidden' id='prePlaceNo' name='prePlaceNo' class='prePlaceNo' value='0'/>"
    			+"<input type='hidden' id='nextPlaceNo' name='nextPlaceNo' class='nextPlaceNo' value='2'/>"
    			+"</form>";
    			
    		var address1 = document.getElementById('temp').value;
		    geocoder.geocode( { 'address': address1}, function(results, status) {
		      if (status == 'OK') {
		        map.setCenter(results[0].geometry.location);
		        var marker = new google.maps.Marker({
		            map: map,
		            position: results[0].geometry.location
		        });
		        markers.push(marker);
		      } else {
		        alert('Geocode was not successful for the following reason: ' + status);
		      }
		      routes.push(results[0].geometry.location);
 		     
		    });
    		
    		$("#btn").append(newUpButton);
    		
    		//
        		$(appendDiv).append(newLeftButton);
        		$(appendDiv).append(newLeftDiv);
    		
			$("#temp").val(null);
			$("#start").val(start);
    		$("#end").val(start);    		
    		
    		$(appendDiv).find($("#f"+(tempNum)+" input[name='visitDate']")).val(visitDate);
    		$(appendDiv).find( $("#f"+(tempNum)+" input[name='startPlace']")).val(document.querySelector('#start').value);
    		$(appendDiv).find( $("#f"+(tempNum)+" input[name='place']")).val(document.querySelector('#start').value); 
    	    Javascript:calcRoute();
    		
			tempNum++;
			return;
    	}
    		tempNum++;	
    	
    		end = document.getElementById('temp').value;
    		
    		$("#temp").val(null);
    		
    		var newUpButton = "<button  onclick=\"movePlace('"+end+"')\">"+end+"</button>"    			    		
    		var newLeftButton = "<form id = 'f"+(tempNum-1)+"' class = 'f"+(tempNum-1)+"' name='ddform' value='xxxxx'>"		    //여긴 하나 있어서 1부터			
    			+"<input type='hidden' id='startPlace' name='startPlace' class='startPlace'/>"
    			+"<input type='hidden' id='visitDate' name='visitDate'/>"
    			+"<input type='hidden' id='place' name='place' class='place'/>"
    			+"<textarea onKeyup='len_chk()' rows='3.4' cols='29' style='resize:none;' type='text' id='memo' name='memo' class='memo' placeholder='방문지에서의 계획등 간단한 메모를 입력하세요.'/>"
    			+"<input type='text' id='distance' name='distance'/>"
    			+"<input type='text' id='duration' name='duration'/>"
    			+"<button type='button' id = 'btn-route'>교통정보 보기</button>"
    			+"<input type='hidden' id='cityNo' name='cityNo' class='cityNo' value='${sessionScope.city.cityNo}'/>"
    			+"<input type='hidden' id='travelNo' name='travelNo' class='travelNo' value='${sessionScope.city.travelNo}'/>"
    			+"<input type='hidden' id='placeId' name='placeId' class='placeId'/>"
    			+"<input type='hidden' id='placeX' name='placeX' class='placeX'/>"
    			+"<input type='hidden' id='placeY' name='placeY' class='placeY'/>"
    			+"<input type='hidden' id='placeXY' name='placeXY' class='placeXY'/>"
    			+"<input type='hidden' id='prePlaceNo' name='prePlaceNo' class='prePlaceNo'/>"
    			+"<input type='hidden' id='nextPlaceNo' name='nextPlaceNo' class='nextPlaceNo'/>"
    			+"<input type='hidden' id='tempCount' name='tempCount' class='tempCount'/>"
    			+"<button  style='WIDTH: 170pt;' onclick=\"movePlace('"+end+"')\">"+end+"</button>"
    			+"</form>"
    			+"<br></br>";
			$("#btn").append(newUpButton);
			if(tempNum>1){
	        		$(appendDiv).append(newLeftButton);
			}
			

    		$("#start").val(start);
    		$("#end").val(end);    		

    		$(appendDiv).find($("#f"+(tempNum-1)+" input[name='visitDate']")).val(visitDate);
    		$(appendDiv).find( $("#f"+(tempNum-1)+" input[name='startPlace']")).val(document.querySelector('#start').value);
     		$(appendDiv).find( $("#f"+(tempNum-1)+" input[name='place']")).val(document.querySelector('#end').value);
     		$(appendDiv).find( $("#f"+(tempNum-1)+" input[name='prePlaceNo']")).val(tempNum-1);
     		$(appendDiv).find( $("#f"+(tempNum-1)+" input[name='nextPlaceNo']")).val(tempNum+1);
     		$(appendDiv).find( $("#f"+(tempNum-1)+" input[name='tempCount']")).val(tempNum);
     		
   			Javascript:calcRoute();

    		start = end;
    		
    }// setTemp() 끝

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
          //    directionsDisplay.setDirections(response);//네비게이션
          }
          var placeX = response.routes[0].legs[0].end_location.lat();
          var placeY = response.routes[0].legs[0].end_location.lng();
          

          $(appendDiv).find( $("#f"+(tempNum-1)+" input[name='placeX']")).val(placeX);
          $(appendDiv).find(  $("#f"+(tempNum-1)+" input[name='placeY']")).val(placeY);
          $(appendDiv).find(  $("#f"+(tempNum-1)+" input[name='placeId']")).val(response.geocoded_waypoints[1].place_id);
          $(appendDiv).find( $("#f"+(tempNum-1)+" input[name='duration']")).val(JSON.stringify(response.routes[0].legs[0].duration.text));
          $(appendDiv).find( $("#f"+(tempNum-1)+" input[name='distance']")).val(JSON.stringify(response.routes[0].legs[0].distance.text));  
                   
          var placeXY = new Object();
          
          placeXY.lat = placeX;
          placeXY.lng = placeY;
        
        	 var marrk = placeXY;
         	 routes.push(placeXY);
         	
           //$("#f"+(tempNum-2)+" input[name='placeXY']").val(placeXY);

         	var marker = new google.maps.Marker({
      		position: marrk,
      		map: map
    			}); 
         	markers.push(marker);
                             var CBroute = new google.maps.Polyline({
                               path: routes,
                               geodesic: true,
                               strokeColor: '#b31543',
                               strokeOpacity: 1.0,
                               strokeWeight: 2
                             });
                             CBroute.setMap(map);
                             line.push(CBroute);
        });
      }//end of calcRoute()
///////////////////////////////////////////////////////////////////////////////////////////////////////// 
 function setAutocompleteUsername() {

	var interest = document.getElementById('interest').value;
   
   if (interest == 'bank'){
       searchBank();
	}
	if (interest == 'school'){
       searchSchool();
	}
    if (interest == 'hospital'){
       searchHospital();
	}
	if (interest == 'restaurant'){
       searchRestaurant();
	}
	if (interest == 'all'){
       searchAll();
	}
  
   clearResults();
   clearMarkers();
}
// [END seting username and interest]
// Search for bank in the selected username
function searchBank() {
  var search = {
    bounds: map.getBounds(),
    types: ['bank']
  };
    places.nearbySearch(search, function(results, status) {
        if (status == google.maps.places.PlacesServiceStatus.OK) {
        clearResults();
        clearMarkers();
        for (var i = 0; i < results.length; i++) {
		    iconColor="blue";
		    icon = markerPath + iconColor + ".png";
            markers[i] = new google.maps.Marker({
                position: results[i].geometry.location,
                animation: google.maps.Animation.DROP,
                icon: new google.maps.MarkerImage(icon)
            });
            markers[i].placeResult = results[i];
            google.maps.event.addListener(markers[i], 'click', showInfoWindow);
            setTimeout(dropMarker(i), i * 100);
        }
    }
  });
}

// Search for school in the selected username
function searchSchool() {
  var search = {
    radius: 30000,
    location: { lat: startCityX ,  lng: startCityY},
    type: ['point_of_interest'],
  rankBy: google.maps.places.RankBy.PROMINENCE
  };
    places.nearbySearch(search, function(results, status) {
        if (status == google.maps.places.PlacesServiceStatus.OK) {
        clearResults();
        clearMarkers();
        for (var i = 0; i < results.length; i++) {
		    iconColor="green";
		    icon = markerPath + iconColor + ".png";
            markers[i] = new google.maps.Marker({
                position: results[i].geometry.location,
                animation: google.maps.Animation.DROP,
                icon: new google.maps.MarkerImage(icon)
            });
            markers[i].placeResult = results[i];
            google.maps.event.addListener(markers[i], 'click', showInfoWindow);
            setTimeout(dropMarker(i), i * 100);
          }
    }
  });
}

// Search for Hospitals in the selected username
function searchHospital() {
  var search = {
    bounds: map.getBounds(),
    types: ['hospital']
  };
    places.nearbySearch(search, function(results, status) {
        if (status == google.maps.places.PlacesServiceStatus.OK) {
           clearResults();
           clearMarkers();
           for (var i = 0; i < results.length; i++) {
                iconColor="red";
		        icon = markerPath + iconColor + ".png";
                markers[i] = new google.maps.Marker({
                    position: results[i].geometry.location,
                    animation: google.maps.Animation.DROP,
                    icon: new google.maps.MarkerImage(icon)
                });
           markers[i].placeResult = results[i];
           google.maps.event.addListener(markers[i], 'click', showInfoWindow);
           setTimeout(dropMarker(i), i * 100);
 
           }
        }
  });
}

// Search for Restaurant in the selected username

function searchRestaurant() {
var search = {
    bounds: map.getBounds(),
    types: ['restaurant']
  };
    places.nearbySearch(search, function(results, status) {
        if (status == google.maps.places.PlacesServiceStatus.OK) {
            clearResults();
            clearMarkers();
            for (var i = 0; i < results.length; i++) {
                iconColor="yellow";
		        icon = markerPath + iconColor + ".png";
                markers[i] = new google.maps.Marker({
                    position: results[i].geometry.location,
                    animation: google.maps.Animation.DROP,
                    icon: new google.maps.MarkerImage(icon)
                });
                markers[i].placeResult = results[i];
                google.maps.event.addListener(markers[i], 'click', showInfoWindow);
                setTimeout(dropMarker(i), i * 100);
            }
        }
  });
}


function clearMarkers() {
  for (var i = 0; i < markers.length; i++) {
    if (markers[i]) {
      markers[i].setMap(null);
    }
  }
  markers = [];
}

function dropMarker(i) {
  return function() {
    markers[i].setMap(map);
  };
}

function addResult(result, i) {
  var results = document.getElementById('results');
  var markerLetter = String.fromCharCode('A'.charCodeAt(0) + i);
  var markerIcon = MARKER_PATH + markerLetter + '.png';
  markerIcon.onclick = function() {
    google.maps.event.trigger(markers[i], 'click');
  };
 
}
function clearResults() {
  var results = document.getElementById('results');
  while (results.childNodes[0]) {
    results.removeChild(results.childNodes[0]);
  }
}

// Get the place details. Show the information in an info window,
function showInfoWindow() {
  var marker = this;
  places.getDetails({placeId: marker.placeResult.place_id},
      function(place, status) {
        if (status != google.maps.places.PlacesServiceStatus.OK) {
          return;
        }
        infoWindow.open(map, marker);
        buildIWContent(place);
      });
}

// Load the place information into the HTML elements used by the info window.
function buildIWContent(place) {
  document.getElementById('iw-icon').innerHTML = '<img class="hotelIcon" ' +
      'src="' + place.icon + '"/>';
  document.getElementById('iw-url').innerHTML = '<b><a href="' + place.url +
      '">' + place.name + '</a></b>';
  document.getElementById('iw-address').textContent = place.vicinity;

  if (place.formatted_phone_number) {
    document.getElementById('iw-phone-row').style.display = '';
    document.getElementById('iw-phone').textContent =
        place.formatted_phone_number;
  } else {
    document.getElementById('iw-phone-row').style.display = 'none';
  }

  // The regexp isolates the first part of the URL (domain plus subdomain)
  // to give a short URL for displaying in the info window.
  if (place.website) {
    var fullUrl = place.website;
    var website = hostnameRegexp.exec(place.website);
    if (website == null) {
      website = 'http://' + place.website + '/';
      fullUrl = website;
    }
    document.getElementById('iw-website-row').style.display = '';
    document.getElementById('iw-website').textContent = website;
  } else {
    document.getElementById('iw-website-row').style.display = 'none';
  }
}
 
	
	google.maps.event.addDomListener(window, 'load', getLocation);
	
    </script>
    
    </head>

<body>

		<div id="panel" >
            <input type="hidden" id="start" value=""/>
            <input type="hidden" id="end" value=""/>
            <input id="temp" class="controls" type="text"  placeholder="장소명 혹은 주소를 입력하세요" onkeypress=
        "if(document.querySelector('#temp').value != ''&&event.keyCode==13) {Javascript:setTemp();}"/>
       
           
        </div>
        
		<div id="mainPlace">
       		<h3>Place테이블입력</h3>
       		<br>
    	</div>
		
		<div id="btn">
			<button onclick="moveStart()">전체루트</button>
			<button type='button' id = 'insert' style='WIDTH: 170pt; float:right;'>등록하기</button>
		</div>		
		<div id="formTag" class="formC">
 
		<div id="btnClass" class="btnClass">
		  
		</div> 
		 
		<div id="cityOOO" class="cityOOO">

		</div> 		 

		</div>
		 <div id="near"></div>
	  <select id="interest" style="width:140px">
		<option value="bank">Bank</option>
        <option value="school">School</option>
        <option value="restaurant">Restaurant</option>
        <option value="hospital">Hospitals</option>
       <option value="default" selected> Select Interest </option>
      </select>
   		<div id="listing">
      <table id="resultsTable">
        <tbody id="results"></tbody>
      </table> 
    </div>
   	
	    <div id="info-content">
      <table>
        <tr id="iw-url-row" class="iw_table_row">
          <td id="iw-icon" class="iw_table_icon"></td>
          <td id="iw-url"></td>
        </tr>
        <tr id="iw-address-row" class="iw_table_row">
          <td class="iw_attribute_name">Address:</td>
          <td id="iw-address"></td>
        </tr>
        <tr id="iw-phone-row" class="iw_table_row">
          <td class="iw_attribute_name">Contact No:</td>
          <td id="iw-phone"></td>
        </tr>
         <tr id="iw-website-row" class="iw_table_row">
          <td class="iw_attribute_name">Website:</td>
          <td id="iw-website"></td>
        </tr>
      </table>
    </div>
		 	
		<div id="map"></div>
		
</body>
</html>
