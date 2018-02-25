function increaseElem() {
  var elem = document.getElementsByName("text");
  var curr = parseFloat(getComputedStyle(elem[0], null).fontSize);
  elem[0].style.fontSize = (5+curr)+"px";
}
function reduceElem() {
  var elem = document.getElementsByName("text");
  var curr = parseFloat(getComputedStyle(elem[0], null).fontSize);
  elem[0].style.fontSize = (curr-5)+"px";
}
function changeText(flag) {
  var elem = document.getElementsByClassName("header_text");
  flag ? elem[0].innerHTML = "Вы навели на шапку сайта!" : elem[0].innerHTML = "Желаешь узнать  достоверные сведения о происхождении своей фамилии? Читай ниже"
}
