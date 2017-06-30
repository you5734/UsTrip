<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
 <HEAD>
  <TITLE>html2canvas_exam01</TITLE>
 
 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.js"></script>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="/js/canvas2image.js"></script>
  
<script>

	
	
  
	function div2img(document.body,function(pImgData){
    var tNewDiv = document.createElement('div');
    document.body.appendChild(tNewDiv);
    tNewDiv.innerHTML = "<img src='" + pImgData + "'>";
}, 1200, 2400, 0, 0);

</script>
 
 </HEAD>
 
 <BODY>
 <div></div>
 
 </BODY>
</HTML>