$(document).ready(function() {

  $('.like-status').click(function(event) {
    event.preventDefault();
    var $likeBtn      = $(this).find("#like-heart")
      , $icon         = $(this).find("i")
      , $label        = $(this).find("label");

    var unlikeTemp = "<a action='downvote' data-id='" + $likeBtn.data('id') +"' data-method='put' data-remote='true' data-vote='like' data-voter='" + $likeBtn.data('voter') + "' href='/statuses/" + $likeBtn.data('voter') + "/dislike' id='like-heart' rel='nofollow'>"
        unlikeTemp +="<i class='fi-heart' id='test'></i>"
        unlikeTemp +="<label>Like</label>"
        unlikeTemp +="<sub>" + $likeBtn.data('voter') +"</sub>"
        unlikeTemp +="</a>"

    var likeTemp = "<a action='upvote' data-id='" + $likeBtn.data('id') +"' data-method='put' data-remote='true' data-vote='unlike' data-voter='" + $likeBtn.data('voter') + "' href='/statuses/" + $likeBtn.data('voter') + "/like' id='like-heart' rel='nofollow'>"
        likeTemp +="<i class='fi-heart red' id='test'></i>"
        likeTemp +="<label>Liked</label>"
        likeTemp +="<sub>" + $likeBtn.data('voter') +"</sub>"
        likeTemp +="</a>"

      if ($(this).find("i").hasClass("red")) {
        var route  = Routes.dislike_status_path({id: $likeBtn.data('id'), voter: $likeBtn.data('voter'), vote: $likeBtn.data('vote')});
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
        return true
      }
    });
  });
});