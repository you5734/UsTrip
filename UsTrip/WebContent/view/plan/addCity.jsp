<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="/css/main.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="/js/jquery.min.js"></script>
<script src="/js/jquery.scrolly.min.js"></script>
<script src="/js/skel.min.js"></script>
<script src="/js/util.js"></script>
<script src="/js/main.js"></script>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">

<title>UsTrip</title>
<script src="/js/html2canvas.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?
    key=AIzaSyDgS9rLrRIo9sBKIyAK7Opc5fMeVvbzhy4&v=3.exp&libraries=places&region=kr"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.4/sweetalert2.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.4/sweetalert2.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/core-js/2.4.1/core.js"></script>


<style type="text/css">
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	overflow: hidden;
}

#mainCity {
	width: 17%;
	height: 10.5%;
	float: left;
}

#btn {
	width: 83%;
	height: 10.5%;
	float: left;
}

#formTag {
	width: 17%;
	height: 85%;
	float: left;
	overflow: auto;
}

#map {
	width: 83%;
	height: 90%;
}

#btn-route {
	color: #fff;
	height: 30px;
	width: 100px !important;
	margin-left: 5px;
	padding-left: 5px;
}

#panel {
	position: fixed;
	margin-left: 25%;
	margin-top: 5.9%;
	z-index: 5;
	background-color: #fff;
	padding: 3px;
}

#insert {
	position: fixed;
	margin-top: -35px;
	margin-left: 65%;
	z-index: 5;
	color: #fff;
	padding: none;
	border: none;
}

#moveList {
	width: 155px !important; 
	position: fixed;
	margin-top: 15px;
	margin-left: 65%;
	z-index: 5;
	color: #fff;
	padding: none;
	border: none;
}

#duration, #distance, #stayDate {
	border: none;
}
</style>


<script>
	var travelNo = "${sessionScope.travel.travelNo}";
	var stayStart = String("${sessionScope.travel.startDate}").replace("KST", "GMT");
	stayStart = new Date(stayStart.replace(/-/g, '/'));
	stayStart = stayStart.getFullYear()+"-"+(stayStart.getMonth()*1+1)+"-"+stayStart.getDate();
    var directionsDisplay;
    var directionsService = new google.maps.DirectionsService();
    var map;
    var geocoder;//
    var temp;
    var start;
    var end;
	var tempNum = 0;
	var cityId;
	var XValue;
	var YValue;
	var cityValue;
	var routes = [];
	var stayStart;
	var stayDate;
	var stayEnd;
	var totalDate = 0;
	
	 $(function(){
	  	  $(document).on("click","#btn-route",function(){
			
				startRoute = encodeURIComponent($(this).parent().find(".startCity").val());
				endRoute = encodeURIComponent($(this).parent().find(".city").val());
				
				window.open('/view/plan/route.jsp?'+startRoute+"?"+endRoute);
	 
	    });
	   });
    $(function(){
  	  $(document).on("click","#btn-test",function(){
  		XValue = $(this).parent().find(".cityX").val();
	  	YValue = $(this).parent().find(".cityY").val();	
		stayStart = encodeURIComponent($(this).parent().find(".stayStart").val());
		stayDate = encodeURIComponent($(this).parent().find(".stayDate").val());
		stayEnd = encodeURIComponent($(this).parent().find(".stayEnd").val());
		cityId = $(this).parent().find(".cityId").val();
		
		var lct = "/plan/addPlace?data="+travelNo+"/"+cityId+"/"
				+XValue+"/"+YValue+"/"+stayStart+"/"+stayDate+"/"+stayEnd;
			
	/* 		self.location = lct; */
	window.open(lct);
  	  });
    });

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    

    	

		 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/* function capture() {
		
            html2canvas($("#map"), {
                  onrendered: function(canvas) {
                    //document.body.appendChild(canvas);
                    //alert(canvas.toDataURL("image/png"));
                    
                    $("#imgSrc").val(canvas.toDataURL("image/png"));
                    
                    $.ajax({
                        type:     "post",
                        data : { imgSrc:$("#imgSrc").val()},
                        url:     "/plan/imageCreate.ajax",
                        error: function(a, b, c){        
                        //    alert("fail!!");
                        },
                        success: function (data) {
                            try{
                                
                            }catch(e){                
                                alert('server Error!!');
                            }
                        }
                    });
                  }
            });
        } */
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    function moveList(){
    	//self.location = "/index.jsp";
    	self.location = "/user/allListTravel";
	}
    
    function movePlace(){
    	  
    	swal({
			title:"���� ����Ͻðڽ��ϱ�?",
	   		  type: 'question',
	   		  showCancelButton: true,
	   		  confirmButtonColor: '#3085d6',
	   		  cancelButtonColor: '#d33',
	   		  confirmButtonText: '���',
	   		  cancelButtonText:'���'
	   		}).then(function () {		   			
				button_event();
	   			swal("��ϵǾ����ϴ�. \n�������� Ȯ�� �� ���� ��� \n���� ��ư�� �����ּ���.")
	   			.then(function () {	
		   			//capture();//ȭ��ĸ��
		   			addTotalDate();
		   		})
	   		})
	   	 		
    	
    	
	}
    
    function button_event(){ 
    	
		 for(var i = 0; i < tempNum; i++){
			
			
			$("#f"+(i)+" input[name='stayStart']").val(stayStart);
			var stayDate = $("#f"+(i)+" select[name='stayDate']").val();
			var stayEnd = new Date(stayStart.replace(/-/g, '/'));
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
			
			var jsonCity = JSON.stringify(eval("cityObj"+i));
				
			totalDate += $("#f"+(i)+" select[name='stayDate']").val()*1;
		        	
	        $.ajax({
	        	type : "POST",
	        	url : "/plan/addCity",
	        	async: false,
	        	data :{ a:jsonCity},
	        	datatype : "json",
	        	context: this,
	        	success : function(result){
	                
	        		}
	        	
	        }); 
			
			
       }  
		 
		 
	}
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		 
		function addTotalDate() {
	
         	var thumbObj = new Object();
   			
   			thumbObj.travelNo = travelNo;
   			thumbObj.totalDate = String(totalDate);
   			
   			var jsonThumb = JSON.stringify(thumbObj);
         	  
             $.ajax({
                 type: "post",
                 data: {THUMB_NAIL:jsonThumb},
                 url : "/plan/imageCreate.ajax"
             });
        }
///////////////////////////////////////////////////////////////////////////////////////////////////////// 
    function initialize(position) {
      directionsDisplay = new google.maps.DirectionsRenderer();
      geocoder = new google.maps.Geocoder();
    
      //var currentLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
  
      var mapOptions = {
        zoom:8,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        center: {lat: 36.8488, lng: 127.7792} 
    }
      map = new google.maps.Map(document.getElementById('map'), mapOptions);
      
      var input = document.getElementById('temp');
      var options = {
        types: ['(cities)'],
        componentRestrictions: {country: 'kr'}
      };

      autocomplete = new google.maps.places.Autocomplete(input, options);
    
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
    					
    					var address = results[0].formatted_address.replace(/^����, /, '');
    					address = address.split(' ');
    					
    					address = address[1]+" " +address[2]
    					new google.maps.InfoWindow({
    						content: address + "<br>(Lat, Lng) = " + latlng
    					})/* .open(map, new google.maps.Marker({//�ʿ� �ڽ� �ߴ°�
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
    				//	 alert(markers.length); //��Ŀ ����
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
    		
    		var newLeftDiv = "<button type='button' id = 'btn-test' style='color: #fff; WIDTH: 170pt; height: 25pt; margin-top: 8pt;margin-left:5px;'>"+start+"</button>"
    			+"<div id = 'f0' style='display:none'>"    
    			+"<input type='hidden' id='startCity' name='startCity' class='startCity'/>"
    			+"<input type='hidden' id='city' name='city' class='city'/>"
    			+"</br>"
    			+"<label>������</label>"
    		    +"<select id='stayDate' name='stayDate' class='stayDate'>"
    		    +"<option>0</option>"
    		    +"<option selected='selected'>0</option>"
    		    +"</select>"
    			+"<input type='hidden' id='travelNo' name='travelNo' class='travelNo' value='"+travelNo+"'/>"
    			+"<input type='hidden' id='cityId' name='cityId' class='cityId'/>"
    			+"<input type='hidden' id='cityX' name='cityX' class='cityX'/>"
    			+"<input type='hidden' id='cityY' name='cityY' class='cityY'/>"
    			+"<input type='hidden' id='preCityNo' name='preCityNo' value='0'/>"
    			+"<input type='hidden' id='nextCityNo' name='nextCityNo' value='2'/>"
    			+"<input type='hidden' id='stayStart' name='stayStart' class='stayStart'/>"
    			+"<input type='hidden' id='stayEnd' name='stayEnd' class='stayEnd'/>"
    			+"</div>";
    		
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
    		  
    		//$("#mainCity").append(newUpButton);
    		$("#formTag").append(newLeftDiv);
			$("#temp").val(null);
    		$("#start").val(start);
    		$("#end").val(start);    		
    	    Javascript:calcRoute();			
			
    		$("#f"+(tempNum)+" input[name='startCity']").val(document.querySelector('#start').value);  
    		$("#f"+(tempNum)+" input[name='city']").val(document.querySelector('#start').value);  
			
			
			tempNum++;
			return;
    	}
    		tempNum++;	
    	
    		end = document.getElementById('temp').value;
    		
    		$("#temp").val(null);
    		
    		var newLeftButton = "<div id = 'f"+(tempNum-1)+"' >"    
				+"<input type='text' id='distance' name='distance'style='background-color: #ffffff !important;'/>"
    			+"<input type='text' id='duration' name='duration' style='background-color: #ffffff !important; float:left;' />"
    			+"<input type='hidden' id='startCity' name='startCity' class='startCity'/>"
    			+"<input type='hidden' id='city' name='city' class='city'/>"
    			+"<button type='button' id = 'btn-route' style=' margin-top: 2px;'>�������� ����</button>"
    			+"<input type='hidden' id='travelNo' name='travelNo' class='travelNo' value='"+travelNo+"'/>"
    			+"<input type='hidden' id='cityId' name='cityId' class='cityId'/>"
    			+"<input type='hidden' id='cityX' name='cityX' class='cityX'/>"
    			+"<input type='hidden' id='cityY' name='cityY' class='cityY'/>"
    			+"<input type='hidden' id='preCityNo' name='preCityNo'/>"
    			+"<input type='hidden' id='nextCityNo' name='nextCityNo'/>"
    			+"<input type='hidden' id='stayStart' name='stayStart' class='stayStart'/>"
    			+"<input type='hidden' id='stayEnd' name='stayEnd' class='stayEnd'/>"
    			+"</br>"
    			+"<button type='button' id = 'btn-test' style='margin-left:5px; padding:0px 0px 0px 0px !important; float:left; color: #fff; WIDTH: 100pt; height: 25pt; margin-top: 3pt;'>"+end+"</button>"
    			+"<label style='margin-top: 10px; margin-left: 5px; width: 50px; float:left; '>������</label>"
    		    +"<select id='stayDate' name='stayDate' class='stayDate' style='margin-top: 4px; background-color: #ffffff !important; width: 45px; float:left; cursor: Pointer;'>"
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
    			+"</div>";
    			
    			
    			
			
    		$("#formTag").append(newLeftButton);
			
    		$("#start").val(start);
    		$("#end").val(end);    		
    		
    	
    		$("#f"+(tempNum-1)+" input[name='startCity']").val(document.querySelector('#start').value);
    		$("#f"+(tempNum-1)+" input[name='city']").val(document.querySelector('#end').value);
    		$("#f"+(tempNum-1)+" input[name='preCityNo']").val(tempNum-1);
    		$("#f"+(tempNum-1)+" input[name='nextCityNo']").val(tempNum+1);
    	
    	    Javascript:calcRoute();
    		
    		start = end;
    		
    }// setTemp() ��
/////////////////////////////////////////////////////////////////////////////////////////////////////////
 /*  function addLatLng(event) {
	//	alert(event); // ���� �𸣰ڰ� [object Object] �̷��� ����
	//	alert(JSON.stringify(event)); // ��ǥ��~~~~
	
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
          // directionsDisplay.setDirections(response);//�׺���̼� ���� ��Ʈ ����Ǵ°�
        }  	
        var cityX = response.routes[0].legs[0].end_location.lat();
        var cityY = response.routes[0].legs[0].end_location.lng();
        
      
/////////////////////////////////////////////////////////////////////////////////////////////////////////        
        $("#f"+(tempNum-1)+" input[name='cityX']").val(cityX);
        $("#f"+(tempNum-1)+" input[name='cityY']").val(cityY);
        $("#f"+(tempNum-1)+" input[name='cityId']").val(response.geocoded_waypoints[1].place_id);
        
        var rere = JSON.stringify(response.routes[0].legs[0].duration.text);
        
        var cityXY = new Object();
        cityXY.lat = cityX;
        cityXY.lng = cityY;
      
        var marrk = cityXY;
        routes.push(cityXY);duration
		   
        $("#f"+(tempNum-1)+" input[name='duration']").val(JSON.stringify(
       		 response.routes[0].legs[0].duration.text).replace("\"",'').replace("\"",''));
        $("#f"+(tempNum-1)+" input[name='distance']").val(JSON.stringify(
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
//�����      $('#a1').val(request.origin); 
      
//������     $('#nextCity').val(request.destination);
      /* alert(response.routes[0].duration); */
//    alert("��Ʈ������ ������\n"+JSON.stringify(response));
//    alert(JSON.stringify(response.routes[0]));
//    alert(JSON.stringify(response.routes[0]));
//    alert(JSON.stringify(response.routes[0].legs[0].duration.text))
//   alert(JSON.stringify(response.routes[0].legs[0].distance.text))
//alert(response.geocoded_waypoints[0].place_id);
       // alert(response.geocoded_waypoints[1].place_id);
       //$('#a2').val(response.duration.text);
        //$('#fortDetail').val(JSON.stringify(response.routes));
	
	google.maps.event.addDomListener(window, 'load', initialize);
	
    </script>

</head>

<body>
	<jsp:include page="/common/toolbar.jsp" />
	<div id="panel" class="panel">
		<input type="hidden" id="start" value="" /> <input type="hidden"
			id="end" value="" /> <input type="text" id="temp" value=""
			onkeypress="if(document.querySelector('#temp').value != ''&&event.keyCode==13) {Javascript:setTemp();}" />
		<button type='button' id='insert' onclick="{Javascript:movePlace();}">����ϱ�</button>
		<button type='button' id='moveList' onclick="{Javascript:moveList();}">�÷�����Ʈ �̵�</button>

	</div>

	<div id="mainCity"></div>

	<div id="btn"></div>
	<form id="formTag">
		<h3  style="text-align: center;"><strong style=" color:#f6755e;">���� ����</strong></h3>
	</form>
	
	<div id="map"></div>

</body>
</html>