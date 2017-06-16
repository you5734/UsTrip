
<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Vidbg.js Demo</title>
  <link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
  <link href="/css/fullscreenDemo.css" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
</head>

<body>

  <div class="block-container">
    <div class="block">
      <h1>Video Background</h1>
      <h3>Fullscreen applied to &lt;body&gt; </h3>
    </div>
  </div>

  <script type="text/javascript">
    jQuery(function($){
          $('body').vidbg({
              'mp4': '/images/media/mp4_video.mp4',
              'webm': '/images/media/webm_video.webm',
              'poster': '/images/media/fallback.jpg',
          }, {
            // Options
            muted: true,
            loop: true,
  					overlay: true,
            overlayColor: '#000',
            overlayAlpha: '0.3',
          });
      });
  </script>

  <script src="/js/vidbg.min.js"></script>

</body>
</html>