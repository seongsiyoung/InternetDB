// Axios 라이브러리를 불러옵니다.
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';

// DOM 요소들을 가져옵니다.
var modal = document.getElementById('myModal');
var btn = document.getElementById('alarm');
var span = document.getElementsByClassName('close')[0];
var notificationArea = document.getElementById('notificationContent');
var divs = notificationArea.querySelectorAll('div');

// 알림 버튼 클릭 시 모달을 열고 알림 데이터를 로드합니다.
btn.onclick = function() {
    console.log('click')
    modal.style.display = 'block';
    loadNotifications();
}

// 모달의 닫기 버튼 클릭 시 모달을 닫습니다.
span.onclick = function() {
    modal.style.display = 'none';
}

// 모달 외부 클릭 시 모달을 닫습니다.
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = 'none';
    }
}

// 알림 데이터를 로드하는 하뭇입니다.
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

// 알림 상태를 업데이트하는 함수입니다.
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
