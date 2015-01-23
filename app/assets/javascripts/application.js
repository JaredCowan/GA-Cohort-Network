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


// $(document).ready(function() {

  $(".comment").on("click", function(event) {
    // event.preventDefault();

    var $commentBtn = $(this)
      , $textarea   = $(this).parent().parent().find("textarea");
    // console.log($textarea.val());
    // $textarea.val("")
    // $('#test-ajax').load(document.URL + ' #test-ajax')
    // $("textarea, #comment_status_id").val("")

    $.ajax({
      // url: Routes.comment_path({status_id: $commentBtn.data('statusId'), user_id: $commentBtn.data('userId'), body: $textarea.val()}),
      url: '/comments',
      dataType: 'html',
      type: 'POST',
      error: function() {
        console.error("There was an error.");
        // console.log($commentBtn.data('userId'));
        // alert("There was an error.");
      },
      success: function() {
        // $textarea.val("")
        $("textarea").val("")
        $("#comment_body").val("")
        $("form").find("#comment_body").val("")
        $('#test-ajax-two').load(document.URL + ' #test-ajax-two')
        $('#test-ajax').load(document.URL + ' #test-ajax')
      }
    });
  });
  // $(".comment").on("click", function(event) {
  //   $("form").find("#comment_body").val("")
  //   document.getElementById('comment_body').value = ""
  //   $('#test-ajax-two').load(document.URL + ' #test-ajax-two')
  // });
// });

