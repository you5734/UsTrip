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
	position: fixed;
	margin-top: 15px;
	margin-left: 65%;
	z-index: 5;
	color: #fff;
	padding: none;
	border: none;
}

#duration, #distance {
	border: none;
}
</style>

<script type="text/javascript">
    var markers = [
    {
        "title": 'Aksa Beach',
        "lat": '19.1759668',
        "lng": '72.79504659999998',
        "description": 'Aksa Beach is a popular beach and a vacation spot in Aksa village at Malad, Mumbai.'
    },
    {
        "title": 'Juhu Beach',
        "lat": '19.0883595',
        "lng": '72.82652380000002',
        "description": 'Juhu Beach is one of favourite tourist attractions situated in Mumbai.'
    },
    {
        "title": 'Girgaum Beach',
        "lat": '18.9542149',
        "lng": '72.81203529999993',
        "description": 'Girgaum Beach commonly known as just Chaupati is one of the most famous public beaches in Mumbai.'
    },
    {
        "title": 'Jijamata Udyan',
        "lat": '18.979006',
        "lng": '72.83388300000001',
        "description": 'Jijamata Udyan is situated near Byculla station is famous as Mumbai (Bombay) Zoo.'
    },
    {
        "title": 'Sanjay Gandhi National Park',
        "lat": '19.2147067',
        "lng": '72.91062020000004',
        "description": 'Sanjay Gandhi National Park is a large protected area in the northern part of Mumbai city.'
    }
    ];
    window.onload = function () {
        LoadMap();
    }
    var map, mapOptions;
    function LoadMap() {
        mapOptions = {
            center: new google.maps.LatLng(19.0883595, 72.82652380000002),
            zoom: 10,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("dvMap"), mapOptions);
 
        for (var i = 0; i < markers.length; i++) {
            var data = markers[i];
            var myLatlng = new google.maps.LatLng(data.lat, data.lng);
            var marker = new google.maps.Marker({
                position: myLatlng,
                map: map,
                title: data.title
            });
        }
    };
    function Export() {
        //URL of Google Static Maps.
        var staticMapUrl = "https://maps.googleapis.com/maps/api/staticmap";
 
        //Set the Google Map Center.
        staticMapUrl += "?center=" + mapOptions.center.lat() + "," + mapOptions.center.lng();
 
        //Set the Google Map Size.
        staticMapUrl += "&size=220x350";
 
        //Set the Google Map Zoom.
        staticMapUrl += "&zoom=" + mapOptions.zoom;
 
        //Set the Google Map Type.
        staticMapUrl += "&maptype=" + mapOptions.mapTypeId;
 
        //Loop and add Markers.
        for (var i = 0; i < markers.length; i++) {
            staticMapUrl += "&markers=color:red|" + markers[i].lat + "," + markers[i].lng;
        }
 		
        //Display the Image of Google Map.
        var imgMap = document.getElementById("imgMap");
        imgMap.src = staticMapUrl;
        
    }
</script>

</head>

<body>
	<jsp:include page="/common/toolbar.jsp" />
	<div id="panel" class="panel">
		<input type="hidden" id="start" value="" /> <input type="hidden"
			id="end" value="" /> <input type="text" id="temp" value=""
			onkeypress="if(document.querySelector('#temp').value != ''&&event.keyCode==13) {Javascript:setTemp();}" />
		<button type='button' id='insert' onclick="{Javascript:movePlace();}">등록하기</button>
		<button type='button' id='moveList' onclick="{Javascript:moveList();}">플랜리스트 이동</button>

		<input type="hidden" id="imgSrc" name="imgSrc" />
	</div>

	<div id="mainCity"></div>

	<div id="btn"></div>
	<form id="formTag">
	
            <div id="dvMap" style="width: 300px; height: 350px"></div>
            <img id="imgMap" alt="" src='https:maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=AIzaSyDgS9rLrRIo9sBKIyAK7Opc5fMeVvbzhy4'></img>
           
	</form>
	<div id="map"></div>

</body>
</html>