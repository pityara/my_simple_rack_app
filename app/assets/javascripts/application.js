window.onload = function () {
  document.querySelector('#new_comment').onclick = function () {
    ajaxPost('/comment/create', function (data) {

    });
  };
};

function ajaxPost(url, callback) {
  var inpAuthor = document.querySelector('input[name=author]').value;
  var inpText = document.querySelector('textarea[name=text]').value;
  var surnameId = document.querySelector('input[name=surname_id]').value;
  var requestText = 'author=' + inpAuthor +
                    '&' + 'text=' + inpText +
                    '&' + 'surname_id=' + surnameId;
  var fun = callback || function (data) { };

  var request = new XMLHttpRequest();
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      var comment = '<div class=v_comment>' + request.responseText + '</div>';
      document.querySelector('.comments').innerHTML += comment;
    }
  };

  request.open('POST', url);
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  request.send(requestText);
}
