window.userFriendships = [];

$(document).ready(function() {
  $.ajax({
    url: Routes.user_friendships_path({format: 'json'}),
    dataType: 'json',
    type: 'GET',
    success: function(data) {
      window.userFriendships = data;
    }
  });

  $('#add-friendship').click(function(event) {
    event.preventDefault();
    var addFriendshipBtn = $(this);
    $.ajax({
      url: Routes.user_friendships_path({user_friendship: { friend_id: addFriendshipBtn.data('friendId') }}),
      dataType: 'json',
      type: 'POST',
      success: function(e) {
        addFriendshipBtn.hide();
        $('#friend-status').html("<a href='/user_friendships/" + window.user_id + "/edit?friend_id=" + window.user_id + "'" + " class='success radius tiny button'>Friendship Requested</a>");
      }
    });
  });
});

// ==============================================
