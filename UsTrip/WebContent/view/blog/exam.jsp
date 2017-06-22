<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBlWKR_u9NsT-3h0mdZ_5gg-aB4Eh58Ajo&v=3.exp&libraries=places&region=kr&callback=initMap" defer></script>
	<style type="text/css">
         #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
        </style>
	<script>
	 var map;
	 var target;
	 
     function initMap() {
       map = new google.maps.Map(document.getElementById('map'), {
         center: {lat: 36.8488, lng: 127.7792} ,
         zoom: 8,
         scrollwheel: true,
         navigationControl: false,
         mapTypeControl: false,
         scaleControl: false,
         draggable: false,
         disableDoubleClickZoom: true
       });
       
       var target = [
                                    {lat: 36.8488, lng: 127.7792},
                                    {lat:37.4923, lng:127.0292}
                                  ];

       var i;

       for (i = 0; i < target.length; i++) { 
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

        							 polylinePath.setMap(map);
                                } 
       
     //}
	
	</script>
</head>
<body>
<div id="map"></div>

</body>
</html>