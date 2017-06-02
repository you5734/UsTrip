<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<meta charset=utf-8 />
<title>Auto Resize Textarea</title>
  <style>
    .wrap {
      width: 500px;
    }
    .wrap textarea {
      width: 100%;
      resize: none;
      overflow-y: hidden; /* prevents scroll bar flash */
      padding: 1.1em; /* prevents text jump on Enter keypress */
      padding-bottom: 0.2em;
      line-height: 1.6;
    }
  </style>
  <script>
    $(document).ready(function() {
      $('.wrap').on( 'keyup', 'textarea', function (e){
        $(this).css('height', 'auto' );
        $(this).height( this.scrollHeight );
      });
      $('.wrap').find( 'textarea' ).keyup();
    });
  </script>
</head>
<body>
  <p>Source Code From <a href="http://jsfiddle.net/chim/53eAy/">chim</a>(http://stackoverflow.com/users/673282)</p>
  <div class="wrap">
    <textarea>모든 국민은 법 앞에 평등하다. 누구든지 성별·종교 또는 사회적 신분에 의하여 정치적·경제적·사회적·문화적 생활의 모든 영역에 있어서 차별을 받지 아니한다. 국군은 국가의 안전보장과 국토방위의 신성한 의무를 수행함을 사명으로 하며, 그 정치적 중립성은 준수된다. 연소자의 근로는 특별한 보호를 받는다. 모든 국민은 신체의 자유를 가진다. 여자의 근로는 특별한 보호를 받으며, 고용·임금 및 근로조건에 있어서 부당한 차별을 받지 아니한다. 공무원의 신분과 정치적 중립성은 법률이 정하는 바에 의하여 보장된다. 정기회의 회기는 100일을, 임시회의 회기는 30일을 초과할 수 없다. 국회의원의 선거구와 비례대표제 기타 선거에 관한 사항은 법률로 정한다. 정기회의 회기는 100일을, 임시회의 회기는 30일을 초과할 수 없다. 주거에 대한 압수나 수색을 할 때에는 검사의 신청에 의하여 법관이 발부한 영장을 제시하여야 한다.

사는곳 안드로메다. 직업 개념수집. 게시글 지구인들이어 개념 항상 감사합니다. 입법권은 국회에 속한다. 국가는 청원에 대하여 심사할 의무를 진다. 주거에 대한 압수나 수색을 할 때에는 검사의 신청에 의하여 법관이 발부한 영장을 제시하여야 한다. 공공필요에 의한 재산권의 수용, 사용 또는 제한 및 그에 대한 보상은 법률로써 하되, 정당한 보상을 지급하여야 한다. 입법권은 국회에 속한다. 모든 국민은 행위시의 법률에 의하여 범죄를 구성하지 아니하는 행위로 소추되지 아니하며, 동일한 범죄에 대하여 거듭 처벌받지 아니한다. 사는곳 안드로메다. 직업 개념수집. 게시글 지구인들이어 개념 항상 감사합니다.</textarea>
  </div>
</body>
</html>