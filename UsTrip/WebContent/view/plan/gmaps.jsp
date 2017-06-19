<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="EUC-KR">
<title>Insert title here</title>

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
          </style>
</head>
<body>
<div id="map"></div>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyBlWKR_u9NsT-3h0mdZ_5gg-aB4Eh58Ajo&sensor=false"></script>
<script src="/js/gmaps.js"></script>
 <script type="text/javascript">
  var delay = 100;
  var infowindow = new google.maps.InfoWindow();
  
  
  var latlng = new google.maps.LatLng(21.0000, 78.0000);
  var mapOptions = {
    zoom: 8,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  var geocoder = new google.maps.Geocoder(); 
  var map = new google.maps.Map(document.getElementById("map"), mapOptions);
  var bounds = new google.maps.LatLngBounds();

  function geocodeAddress(address, next) {
    geocoder.geocode({address:address}, function (results,status)
      { 
         if (status == google.maps.GeocoderStatus.OK) {
          var p = results[0].geometry.location;
          var lat=p.lat();
          var lng=p.lng();
          createMarker(address,lat,lng);
        }
        else {
           if (status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
            nextAddress--;
            delay++;
          } else {
                        }   
        }
        next();
      }
    );
  }
 function createMarker(add,lat,lng) {
   var contentString = add;
   var marker = new google.maps.Marker({
     position: new google.maps.LatLng(lat,lng),
     map: map,
           });

  google.maps.event.addListener(marker, 'click', function() {
     infowindow.setContent(contentString); 
     infowindow.open(map,marker);
   });

   bounds.extend(marker.position);

 }
 var locations = [ '����', '��õ', '����', '�뱸', '���ֱ�����', '�λ�', '���',
   				'����Ư����ġ��', '����', '����', '��õ��', '�����', '���ֽ�', '������', '������',
   				'������', '�����ֽ�', '����õ��', '��õ��', '������', '������', '�����', '�Ȼ��',
   				'�ȼ���', '�Ⱦ��', '���ֽ�', '����', '���ֽ�', '��õ��', '�����', '���ν�', '�ǿս�',
   				'	�����ν�	', '	��õ��	', '	���ֽ�	', '	���ý�	', '	��õ��	', '	�ϳ���	', '	ȭ����',
   				'	������	', '	����	', '	���ؽ�	', '	��ô��	', '	���ʽ�	', '	�籸��	', '	��籺	',
   				'	������	', '	���ֽ�	', '	������	', '	������	', '	ö����	', '	��õ��	', '	�¹��	',
   				'	��â��	', '	ȫõ��	', '	ȭõ��	', '	Ⱦ����	', '	���걺	', '	�ܾ籺	', '	������	',
   				'	������	', '	��õ��	', '	������	', '	��õ��	', '	��õ��	', '	û����	', '	û�ֽ�	',
   				'	���ֽ�	', '	����	', '	���ֽ�	', '	�ݻ걺	', '	����	', '	������	', '	���ɽ�	',
   				'	�ο���	', '	�����	', '	��õ��	', '	�ƻ��	', '	���걺	', '	õ�Ƚ�	', '	û�籺	',
   				'	�¾ȱ�	', '	ȫ����	', '	����	', '	����	', '	���ֽ�	', '	��ɱ�	', '	���̽�	',
   				'	������	', '	��õ��	', '	�����	', '	��ȭ��	', '	���ֽ�	', '	���ֱ�	', '	�ȵ���	',
   				'	������	', '	���籺	', '	���ֽ�	', '	��õ��	', '	��õ��	', '	�︪��	', '	������	',
   				'	�Ǽ���	', '	û����	', '	û�۱�	', '	ĥ�	', '	���׽�	', '	������	', '	��â��	',
   				'	����	', '	���ؽ�	', '	���ر�	', '	�����	', '	�о��	', '	��õ��	', '	��û��	',
   				'	����	', '	�Ƿɱ�	', '	���ֽ�	', '	���ؽ�	', '	â�籺	', '	â����	', '	�뿵��	',
   				'	�ϵ���	', '	�Ծȱ�	', '	�Ծ籺	', '	��õ��	', '	��â��	', '	�����	', '	������	',
   				'	������	', '	���ֱ�	', '	�ξȱ�	', '	��â��	', '	���ֱ�	', '	�ͻ��	', '	�ӽǱ�	',
   				'	�����	', '	���ֽ�	', '	������	', '	���ȱ�	', '	������	', '	���ﱺ	', '	���	',
   				'	�����	', '	���ʱ�	', '	���ֽ�	', '	��籺	', '	������	', '	���ȱ�	', '	������	',
   				'	��õ��	', '	�žȱ�	', '	������	', '	������	', '	���ϱ�	', '	�ϵ���	', '	�强��	',
   				'	���ﱺ	', '	������	', '	����	', '	�س���	', '	ȭ����	', '	���ֵ�	', '	��������',
   				'	���ֽ�	'
   		];
  var nextAddress = 0;
  function theNext() {
    if (nextAddress < locations.length) {
      setTimeout('geocodeAddress("'+locations[nextAddress]+'",theNext)', delay);
      nextAddress++;
    } else {
      map.fitBounds(bounds);
    }
  }
  theNext();

</script>

</body>
</html>