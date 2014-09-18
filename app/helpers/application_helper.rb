module ApplicationHelper

  def login_form
    if !signed_in?
       render :partial => "partials/loginform"
    end
  end
  
  def signup_form
    render :partial => "partials/signupform"
  end

  def friendship_path
    link_to "Friends", user_friendships_path if signed_in?
  end

  # def edit_user_path
  #   link_to "Edit profile", edit_user_path(current_user)
  # end 

  def full_name
    first_name + '\s' + last_name
  end 

  def forum_path
    link_to "Forum", forum_url if signed_in?
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
             "http://androidandme.wpengine.netdna-cdn.com/wp-content/themes/android-and-me-v4/images/avatars/generic-gravatar-nerd.png",
             "http://primarytech.global2.vic.edu.au/files/2010/04/gravatar.jpg",
             "http://the14thgod.com/images/users/guest.jpg"
             ]
    image_tag image.sample, width: '100px'
  end

  def can_display_status?(status) 
    signed_in? && !current_user.has_blocked?(status.user) || !signed_in?
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
      link_to("Log In", new_session_path) <<
      link_to("Sign Up", signup_path)
    end
  end

  def js_email_regex
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

end