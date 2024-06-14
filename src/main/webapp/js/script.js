// Axios 라이브러리를 불러옵니다.
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';

var modal = document.getElementById('myModal');
var btn = document.getElementById('alarm');
var span = document.getElementsByClassName('close')[0];
var notificationArea = document.getElementById('notificationContent');
var divs = notificationArea.querySelectorAll('div');

btn.onclick = function() {
    console.log('click')
    modal.style.display = 'block';
    loadNotifications();
}

span.onclick = function() {
    modal.style.display = 'none';
}

window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = 'none';
    }
}

function loadNotifications() {
    axios.get('getNotifications.jsp')
        .then(function (response) {
            notificationArea.innerHTML = response.data;

            // 알림 데이터를 동적으로 로드한 후 클릭 이벤트 핸들러를 추가합니다.
            var divs = notificationArea.querySelectorAll('div');
            divs.forEach(function(div) {
                div.onclick = function() {
                    var aTag = this.querySelector('a'); // div 내의 a 태그 선택
                    var href = aTag.getAttribute('href'); // a 태그의 href 속성 값 가져오기
                    var urlParams = new URLSearchParams(href.split('?')[1]); // href의 쿼리스트링 파싱
                    var lostId = urlParams.get('lost_id'); // lost_id 값 추출
                    console.log(lostId);
                    updateAlarmStatus(lostId);
                }
            });
        })
        .catch(function (error) {
            console.log(error);
        });
}

function updateAlarmStatus(lostId) {
    axios.post('modifyAlarmstatus.jsp', {
        lostId : lostId
    })
        .then(function(response){
            console.log("alarm update");
        })
        .catch(function (error) {
            console.log(error);
        });
}
