// Axios 라이브러리를 불러옵니다.
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';

var modal = document.getElementById('myModal');
var btn = document.getElementById('alarm');
var span = document.getElementsByClassName('close')[0];
var notificationArea = document.getElementById('notificationContent');

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
        })
        .catch(function (error) {
            console.log(error);
        });
}
