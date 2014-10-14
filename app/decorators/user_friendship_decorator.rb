class UserFriendshipDecorator < Draper::Decorator
  decorates :user_friendship
  delegate_all

  def friendship_state
    model.state.titleize
  end

  def sub_message
    case model.state
    when 'pending'
      "Friend request pending."
    when 'accepted'
      "You are friends with #{model.friend.first_name}."
    end
  end

  def update_action_verbiage
    case model.state
    when 'pending'
      'Update Request'
    when 'requested'
      'Accept Request'
    when 'accepted'
      'Update Friendship'
    when 'blocked'
      'Unblock Friend'
    end
  end

  def update_class
    case model.state
    when 'pending'
      'default'
    when 'requested'
      'success'
    when 'accepted'
      'success'
    when 'blocked'
      'alert'
    end
  end

end
