<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBlWKR_u9NsT-3h0mdZ_5gg-aB4Eh58Ajo&v=3.exp&libraries=places&region=kr"></script>

<script type="text/javascript" >   
var map;
var target;

jQuery(document).ready(function(){
	
    target = [
              {lat: 36.8488, lng: 127.7792},
              {lat:37.4923, lng:127.0292}
            ];
	
	var position = {
			lon : 37.5651,
			lat : 126.98955
	}
/* 	var position = {
			lon : $('.cityX').val(),
			lat : $('.cityY').val()
	} */
	/* 37.5651, 126.98955 */
    google.maps.event.addDomListener(window, 'load', initialize(target));
 
function initialize(target){
	console.log(target);
	
    if($("#map").length) {
	    var mapOptions = { //���� �� �ɼ� ����
	        zoom : 9, //�⺻ Ȯ����
	      /*   center : new google.maps.LatLng(target.lon, data.lat), // ���� �߾� ��ġ */
	        center: {lat: 36.8488, lng: 127.7792} ,
	        scrollwheel : true, //���콺 �ٷ� Ȯ�� ��� ��� ����
	        mapTypeControl : false, //�� Ÿ�� ��Ʈ�� ��� ����
	        
	        disableDefaultUI : true, //�⺻ UI ��� ����
	        disableDoubleClickZoom : true, //����Ŭ�� �߽����� Ȯ�� ��� ����
	        draggable : true, //���� �巡�� �̵� ��� ����
	        keyboardShortcuts : true,
    	};
 
    var map = new google.maps.Map(document.getElementById('map'), mapOptions); //���� ���� ����� Ÿ��
    


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

    
    
    
    /* var image = 'http://cheolguso.com/img/iconimg.png'; //��Ŀ �̹��� ���� */
 
  /*   var marker = new google.maps.Marker({ //��Ŀ ����
        map : map,
        position : map.getCenter(), //��Ŀ ��ġ
        icon : image //��Ŀ �̹��� 
    }); */
    
    google.maps.event.addDomListener(window, "resize", function() { //������� ���� ��Ŀ ��ġ
        var center = map.getCenter();
        google.maps.event.trigger(map, "resize");
        map.setCenter(center); 
    });
    
    
    }//if-end
}//function-end
 
});//jQuery-en
</script>

	<div id="map" style="width: 100%; height: 400px;"></div>
	
 		<c:forEach items="${city}" var="city" varStatus="status">
 			<hr/>
			<input type="text" class="cityX" value="${city.cityX}">
			<input type="text" class="cityY" value="${city.cityY}">
		</c:forEach>



