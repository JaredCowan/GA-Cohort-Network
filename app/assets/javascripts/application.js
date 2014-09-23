//= require jquery
//= require jquery_ujs
//= require js-routes
//= require foundation
//= require turbolinks
//= require fullcalendar
//= require_tree .


// Here is my fix for the navbar menu not expanding on mobile
// devices. Calls function to reload window once it is done being
// resized and the width of the screen to detect mobile device.
// Adds touch functionality when screen is tablet~>phone sized.
var id; // instantiate the variable for our mobile navbar menu fix
// $(window).resize(function() {
  // clearTimeout(id);
  // id = setTimeout(isMobile, 500);
  // location.reload();
// });

function isMobile() {
  if(window.innerWidth <= 600) {

    $(".left-off-canvas-toggle").tap(function() {
    $(".off-canvas-wrap").addClass("move-right");

  });

    $(".right-off-canvas-toggle").tap(function() {
    $(".off-canvas-wrap").addClass("move-left");

  });

  } else {

    $(".left-off-canvas-toggle").hover(function() {
    $(".off-canvas-wrap").addClass("move-right");

  });

    $(".right-off-canvas-toggle").hover(function() {
    $(".off-canvas-wrap").addClass("move-left");
  });
}};
isMobile();
// End mobile navbar fix


// Fade alert box
if ($('.alert-box').length >= 0) {
  setTimeout(function () {
    $('.alert-box .close').click();
  }, 5000);
}
if ($('.joyride-tip-guide').length >= 0) {
  setTimeout(function () {
    $('.joyride-close-tip').click();
  }, 5000);
}
// End fade alert box
