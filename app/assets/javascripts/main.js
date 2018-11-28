// window.addEventListener("load", () => {
//     var notice = document.getElementById("notice");
//     var alert = document.getElementById("alert");
//     if (notice.innerHTML == ""){
//       notice.style.display = "none";
//     }
//     if (alert.innerHTML == "") {
//       alert.style.display = "none";
//     };
//   })

function showLoad() {
    var spinner = document.getElementsByClassName('spinner')
    spinner[0].style.display = "inline-block";
}