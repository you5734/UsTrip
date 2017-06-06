<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<!-- Bootstrap Core CSS -->
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
	
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script src="https://use.fontawesome.com/04438b50a5.js"></script>
		
	<style>
	    .container {
	        margin-top: 70px;
	        padding: 0;
	    }
	 
	    #custom-search-form .search-query {
	        padding-right: 3px;
	        padding-right: 4px \9;
	        padding-left: 3px;
	        padding-left: 4px \9;
	        /* IE7-8 doesn't have border-radius, so don't indent the padding */
	 
	        margin-bottom: 0;
	        -webkit-border-radius: 3px;
	        -moz-border-radius: 3px;
	        border-radius: 3px;
	    }
	 
	    #custom-search-form button {
	        border: 0;
	        background: none;
	        /** belows styles are working good */
	        padding: 2px 5px;
	        margin-top: 2px;
	        position: relative;
	        left: -28px;
	        /* IE7-8 doesn't have border-radius, so don't indent the padding */
	        margin-bottom: 0;
	        -webkit-border-radius: 3px;
	        -moz-border-radius: 3px;
	        border-radius: 3px;
	    }
	 
	    .search-query:focus + button {
	        z-index: 3;   
	    }	
	    
	</style>
</head>
<body>

<div class="container">
	<div class="row" >

	<div class="col-md-1">
		<input class="form-control" type="text" name="search" placeholder="Search" required/>
	</div>
	
	<div class="col-md-6">
        <form role="form">
				<div class="input-group">
					<input class="form-control" type="text" name="search" placeholder="Search" required/>
					<span class="input-group-btn">
						<button class="btn btn-success" type="submit">
		                    <i class="fa fa-search" aria-hidden="true"></i>
							<span style="margin-left:10px;">Search</span>
						</button>
					</span>
				</div>
			</form>
		</div>
	</div>
</div>

</body>
</html>