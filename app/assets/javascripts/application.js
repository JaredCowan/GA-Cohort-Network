//= require jquery
//= require jquery_ujs
//= require js-routes
//= require foundation
//= require turbolinks
//= require fullcalendar
//= require_tree .

// =================================
// Start activities API
// =================================
window.loadedActivities = [];

  // 
  var deleteActivity = function() {
    window.loadedActivities.length = 0
  }

  // 
var addActivity = function(item) {
  var found = false;
  for (var i = 0; i < window.loadedActivities.length; i++) {
    if (window.loadedActivities[i].id == item.id) {
      var found = true;
    }
  }

  if (!found) {
    window.loadedActivities.push(item);
    window.loadedActivities.sort(function(a, b) {
      var returnValue;
      if (a.created_at > b.created_at)
        returnValue = -1;
      if (b.created_at > a.created_at)
        returnValue = 1;
      if (a.created_at == b.created_at)
        returnValue = 0;
      return returnValue;
    });
  }

  return item;
}

var renderActivities = function() {
  var source = $('#activities-template').html();
  var template = Handlebars.compile(source);
  var html = template({
    activities: window.loadedActivities, 
    count: window.loadedActivities.length
  });
//   var $activityFeedLink = $('li#activity-feed');
  
//   $activityFeedLink.addClass('dropdown');
//   $activityFeedLink.html(html);
//   $activityFeedLink.find('a.dropdown-toggle').dropdown();
}

var pollActivity = function() {
  $.ajax({
    url: '/activities.json',
    type: "GET",
    dataType: "json",
    success: function(data) {
      window.lastFetch = Math.floor((new Date).getTime() / 1000);
      if (data.length > 0) {
        for (var i = 0; i < data.length; i++) {
          addActivity(data[i]);
        }
        renderActivities();
      }
    }
  });
}

// Handlebars.registerHelper('activityFeedLink', function() {
//   return new Handlebars.SafeString(Routes.activities_path());
// });

Handlebars.registerHelper('activityLink', function() {
  var link, path, html;
  var activity = this;
  var linkText = activity.targetable_type.toLowerCase();

  switch (linkText) {
    case "status":
      path = Routes.status_path(activity.targetable_id);
      break;
    case "album":
      path = Routes.album_path(activity.profile_name, activity.targetable_id);
      break;
    case "picture":
      path = Routes.album_picture_path(activity.profile_name, activity.targetable.album_id, activity.targetable_id);
      break;
    case "userfriendship":
      path = Routes.profile_path(activity.profile_name);
      linkText = "friend";
      break;
  }

  if (activity.action === 'deleted') {
    path = '#';
  }

  html = "<li><a href='" + path + "'>" + this.user_name + " " + this.action + " a " + linkText + ".</a></li>";
  return new Handlebars.SafeString( html );
});

// window.pollInterval = window.setInterval( pollActivity, 5000 );
pollActivity();

// =================================
// End activities API
// =================================


// =================================
// Start mobile navbar fix
// =================================

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

// =================================
// End mobile navbar fix
// =================================

// =================================
// Fade alert box
// =================================

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
// =================================
// End fade alert box
// =================================
