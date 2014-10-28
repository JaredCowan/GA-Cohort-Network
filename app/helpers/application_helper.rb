module ApplicationHelper
  
  def all_column_style_centered(l=12,m=12,s=12)
    "large-#{l} medium-#{m} small-#{s} large-centered medium-centered small-centered columns"
  end

  def all_column_style(l=12,m=12,s=12)
    "large-#{l} medium-#{m} small-#{s} columns"
  end

  def login_form
    if !signed_in?
       render :partial => "partials/loginform"
    end
  end

  def tour(text)
  #   if signed_in? && current_user.created_at > 1.minutes.ago
  #   tag(:li, data: {id: "firstStop", options: "tip_location: bottom; prev_button: false; next_button: false"}) + 
  #   "<h5>".html_safe + text.html_safe + "</h5>".html_safe
  #   end
  end
  
  def signup_form
    render :partial => "partials/signupform"
  end

  def ask(user)
    link_to "Ask #{user.full_name}", user_path(user)
  end

  def friendship_path
    link_to "Friends", user_friendships_path if signed_in?
  end
  
  def full_name
    "#{first_name} + '\s' + #{last_name}"
  end 

  def forum_path
    link_to "Forum", forum_url if signed_in?
  end

  def has_unread?
    current_user && current_user.receipts.is_unread.length > 0 
  end

  def user_profile
    user_profile = request.original_url
  end

  def unread_message_count
    current_user && current_user.receipts.is_unread.length
  end

  def message_name
    if conversation.recipients.length >= 2
      if current_user.full_name != nil && conversation.recipients[0].full_name == current_user.full_name
         "Your conversation with<br>".html_safe + conversation.recipients[1].full_name

      elsif current_user.full_name != nil && conversation.recipients[1].full_name == current_user.full_name
         "Your conversation with<br>".html_safe + conversation.recipients[0].full_name
      end
    else
      # Display none if no recipients of message
    end
  end

  def user_online(u)
    if User.online_now.include?(u)
      link_to u.full_name, "#", class: "online"
    elsif User.online_idle.include?(u)
      link_to u.full_name, "#", class: "idle"
    else
      link_to u.full_name, "#", class: "offline"
    end
  end

  def avatar_url
    image = ["http://www.gravatar.com/avatar/#{hash}d=identicon",
             "http://hospitalfranciscovilar.com.br/wp-content/uploads/2013/11/gravatar-60-grey.jpg",
             "http://sarahealy.com/wp-content/uploads/2009/01/illustration.jpg",
             "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT9YE7L6xuG02as4qbFVAsK6Htrep3c1XB9EBFzDlw-r9ywdPVp",
             "http://1.bp.blogspot.com/_uOjdqRYi_HM/TM81wfeZ79I/AAAAAAAAAYI/o9S91JOXr1M/s1600/TRU-ANIMATED-SPRITE-B5.gif",
             "http://primarytech.global2.vic.edu.au/files/2010/04/gravatar.jpg",
             "http://the14thgod.com/images/users/guest.jpg"
             ]
    image_tag image.sample, width: '100px'
  end

  def small_avatar
    image = ["http://www.gravatar.com/avatar/#{hash}d=identicon",
             "http://hospitalfranciscovilar.com.br/wp-content/uploads/2013/11/gravatar-60-grey.jpg",
             "http://sarahealy.com/wp-content/uploads/2009/01/illustration.jpg",
             "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT9YE7L6xuG02as4qbFVAsK6Htrep3c1XB9EBFzDlw-r9ywdPVp",
             "http://1.bp.blogspot.com/_uOjdqRYi_HM/TM81wfeZ79I/AAAAAAAAAYI/o9S91JOXr1M/s1600/TRU-ANIMATED-SPRITE-B5.gif",
             "http://primarytech.global2.vic.edu.au/files/2010/04/gravatar.jpg",
             "http://the14thgod.com/images/users/guest.jpg"
             ]
    image_tag image.sample, width: '100px', class: "avatar"
  end

  def can_display_status?(status) 
    signed_in? && !current_user.has_blocked?(status.user) || !signed_in?
  end

  def can_display_question?(question) 
    signed_in? && !current_user.has_blocked?(question.user) || !signed_in?
  end

  def navbar_home_link
    if signed_in?
       link_to "Dashboard", dashboard_url
     else
      link_to "Home", root_path
    end
  end

  def login_logout_link
    if signed_in?
       link_to "Log Out", signout_path, method: "delete"
     else
      link_to("Log In", root_path) <<
      link_to("Sign Up", signup_path)
    end
  end

  def js_email_regex # Javascript Email Reqex
    "([a-zA-Z0-9]){3,30}[.!#$%&'*+\/=?^_`{|}~-]{0,10}@[a-zA-Z0-9]{3,30}(?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9]){1,20}?)"
  end

  def chr_length(min, max)
    "([a-zA-Z0-9]){" << min.to_s << "," << max.to_s << "}"
  end

  def block_button(text, link = "")
    $link_error = 'alert("You didn\'t put a path for this button. Correct format is <%= block_button \'Button text\', your_link_path %>")'
    @style = 'button expand'
    if !link.blank?
      link_to(text, link, class: @style )
    else
      link_to("Button Error. Click me.", '#', class: @style << " alert",
        :onclick => $link_error)
    end
  end

  def block_button_alert(text, link = "")
    @style = 'button expand alert'
    if !link.blank?
      link_to(text, link, class: @style )
    else
      link_to("Button Error. Click me.", '#', class: @style,
        :onclick => $link_error)
    end
  end

  def tag_cloud(tags, classes)
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / Integer(max.count) * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

  def convo_subject(convo)
    convo.subject.titleize
  end

  def convo_link(convo)
    conversation_path(convo)
  end

  def dashboard_questions_count(question)
    pluralize(question.answers.count.to_s, "Answer" )
  end

end