//= require jquery
//= require jquery_ujs
//= require js-routes
//= require foundation
//= require fullcalendar
//= require_tree .

$("img").error(function () {
  $(this).unbind("error").attr("src", "http://hospitalfranciscovilar.com.br/wp-content/uploads/2013/11/gravatar-60-grey.jpg");
});

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
  // var source = $('#activities-template').html();
  // var template = Handlebars.compile(source);
  // var html = template({
  //   activities: window.loadedActivities, 
  //   count: window.loadedActivities.length
  // });
  // var $activityFeedLink = $('li#activity-feed');
  
  // $activityFeedLink.addClass('dropdown');
  // $activityFeedLink.html(html);
  // $activityFeedLink.find('a.dropdown-toggle').dropdown();
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

  // html = "<li><a href='" + path + "'>" + this.user_name + " " + this.action + " a " + linkText + ".</a></li>";
  // return new Handlebars.SafeString( html );
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
  // if(window.innerWidth <= 600) {

  //   $(".left-off-canvas-toggle").tap(function() {
  //   $(".off-canvas-wrap").addClass("move-right");

  // });

  //   $(".right-off-canvas-toggle").tap(function() {
  //   $(".off-canvas-wrap").addClass("move-left");

  // });

  // } else {

    $(".left-off-canvas-toggle").hover(function() {
    $(".off-canvas-wrap").addClass("move-right");

  });

    $(".right-off-canvas-toggle").hover(function() {
    $(".off-canvas-wrap").addClass("move-left");
  });
// }
};
isMobile();

// =================================
// End mobile navbar fix
// =================================


// $("#view-heart a").click(function() {
//   var id = this.getElementsByTagName('sub')[0].innerHTML

//   if ($( "#test" ).hasClass( "red" )) {
//     $( "#test" ).removeClass( 'red' );
//     $(this).replaceWith('<span id="view-heart"><a href="' + window.location.href + "/" + id + "/like" + '" action="upvote" data-method="put" class="item like-dislike" data-type="json" data-remote="true"><i class="fi-heart" id="test"></i><label>Like</label></a></span>');
//   } else {
//     $(this).replaceWith('<span id="view-heart"><a href="' + window.location.href + "/" + id + "/dislike" + '" action="downvote" data-method="put" class="item like-dislike" data-type="json" data-remote="true"><i class="fi-heart red" id="test"></i><label>Liked</label></a></span>');
//   }

// });


//  ===============================================

// $( ".new_comment" ).submit(function( event ) {
//   setTimeout(function () {
//     $( "textarea" ).val( ' ' ).delay( 100 ).fadeIn( 400 );
//     event.preventDefault();
//   }, 1100);
// });



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

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
    $('#img_prev')
      .attr('src', e.target.result)
      .width(90)
      .height(100);
    };
    reader.readAsDataURL(input.files[0]);
  }
}

$(document).on('change', '.upload :file', function() {
  var input = $(this),
      numFiles = input.get(0).files ? input.get(0).files.length : 1,
      label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
  input.trigger('fileselect', [numFiles, label]);
});

$(document).ready( function() {
  $('.upload :file').on('fileselect', function(event, numFiles, label) { 
    var input = $(this).parents('.input-group').find(':text'),
      log = numFiles > 1 ? numFiles + ' files selected' : label;
  });
});

;( function( window ) {
  
  'use strict';

  function extend( a, b ) {
    for( var key in b ) { 
      if( b.hasOwnProperty( key ) ) {
        a[key] = b[key];
      }
    }
    return a;
  }

  function CBPFWTabs( el, options ) {
    this.el = el;
    this.options = extend( {}, this.options );
      extend( this.options, options );
      this._init();
  }

  CBPFWTabs.prototype.options = {
    start : 0
  };

  CBPFWTabs.prototype._init = function() {
    // tabs elems
    this.tabs = [].slice.call( this.el.querySelectorAll( 'nav > ul > li' ) );
    // content items
    this.items = [].slice.call( this.el.querySelectorAll( '.content-wrap > section' ) );
    // current index
    this.current = -1;
    // show current content item
    this._show();
    // init events
    this._initEvents();
  };

  CBPFWTabs.prototype._initEvents = function() {
    var self = this;
    this.tabs.forEach( function( tab, idx ) {
      tab.addEventListener( 'click', function( ev ) {
        $('#calendar').fullCalendar('render');
        ev.preventDefault();
        self._show( idx );
      } );
    } );
  };

  CBPFWTabs.prototype._show = function( idx ) {
    if( this.current >= 0 ) {
      this.tabs[ this.current ].className = this.items[ this.current ].className = '';
    }
    // change current
    this.current = idx != undefined ? idx : this.options.start >= 0 && this.options.start < this.items.length ? this.options.start : 0;
    this.tabs[ this.current ].className = 'tab-current';
    this.items[ this.current ].className = 'content-current';
  };

  // add to global namespace
  window.CBPFWTabs = CBPFWTabs;

})( window );

//=============================================== 

window.statuses = [];
$(document).ready(function() {
  $.ajax({
    url: Routes.statuses_path({format: 'json'}),
    dataType: 'json',
    type: 'GET',
    success: function(data) {
      window.statuses = data;
    }
  });

  $('#view-heart').click(function(event) {
    event.preventDefault();
    var $likeBtn      = $(this).find("#like-heart")
      , $icon         = $(this).find("i")
      , $label        = $(this).find("label")
      , $likeStatus   = $(".like-status")
      , $unlikeStatus = $(".unlike-status");

    // console.log($(this).find("i").hasClass("red"));

    var unlikeTemp = "<a action='downvote' data-id='" + $likeBtn.data('id') +"' data-method='put' data-remote='true' data-vote='bad' data-voter='" + $likeBtn.data('voter') + "' href='/statuses/" + $likeBtn.data('voter') + "/dislike' id='like-heart' rel='nofollow'>"
        unlikeTemp +="<i class='fi-heart' id='test'></i>"
        unlikeTemp +="<label>Like</label>"
        unlikeTemp +="<sub>" + $likeBtn.data('voter') +"</sub>"
        unlikeTemp +="</a>"

    var likeTemp = "<a action='upvote' data-id='" + $likeBtn.data('id') +"' data-method='put' data-remote='true' data-vote='like' data-voter='" + $likeBtn.data('voter') + "' href='/statuses/" + $likeBtn.data('voter') + "/like' id='like-heart' rel='nofollow'>"
        likeTemp +="<i class='fi-heart red' id='test'></i>"
        likeTemp +="<label>Liked</label>"
        likeTemp +="<sub>" + $likeBtn.data('voter') +"</sub>"
        likeTemp +="</a>"

    if ($(this).find("i").hasClass("red")) {
      var route = Routes.dislike_status_path({id: $likeBtn.data('id'), voter: $likeBtn.data('voter'), vote: $likeBtn.data('vote')});
      $(this).find("a").replaceWith(unlikeTemp);
    } else {
      var route = Routes.like_status_path({id: $likeBtn.data('id'), voter: $likeBtn.data('voter'), vote: $likeBtn.data('vote')});
      $(this).find("a").replaceWith(likeTemp)
    }

    $.ajax({
      url: route,
      dataType: 'json',
      type: 'PUT',
      error: function(e) {
        console.error("There was an error.");
        alert("There was an error.");
      },
      success: function(e) {
        // $(this).find("a").replaceWith(unlikeTemp)
        console.log(this);
      }
    });
  });
});
// $(".like-status").on("click", function(e) {
//   $(this).html("<%= link_to like_status_path(status.id), method: 'put', remote: true, id: 'like-heart', action: 'downvote', data: { id: status.id, voter: current_user.id, vote: 'like' } do %> <i class='fi-heart red' id='test'></i> <label>Like</label> <sub><%= status.id %></sub> <% end %>");
// });

// $(".likeable, .liked").forEach("click", function(e) {
//   $(this).html("<%= link_to like_status_path(status.id), method: 'put', remote: true, id: 'like-heart', action: 'downvote', data: { id: status.id, voter: current_user.id, vote: 'like' } do %> <i class='fi-heart red' id='test'></i> <label>Like</label> <sub><%= status.id %></sub> <% end %>");
// });

// $(window).ready(function() {
//   var $iconBar   = $(".icon-bar")
//     , $likeable  = $(".likeable")
//     , $liked     = $(".liked")
//     , $likeBtn   = $(".like-status")
//     , $unLikeBtn = $(".unlike-status");

  // $likeBtn.hide();
  // $unLikeBtn.hide();






