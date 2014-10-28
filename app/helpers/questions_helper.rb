module QuestionsHelper

  def document_url(element)
      element.document.attachment.url
  end

  def time_ago(time)
    time_ago_in_words(time) + "\sago"
  end

  def time_date(timedate)
    timedate.created_at.strftime("%D at %l:%H %P")
  end

  def limit_length(element)
    truncate(element.body, length: 400){ link_to "Read More", question_path(element) }
  end

  def question_document_valid?(element)
    element.document && element.document.attachment? && element.document.valid?
  end

  def question_user_name(element, *options)
    link_to element.user.full_name, user_path(element.user), *options
  end

  def image_user_path(element_user)
    link_to avatar_url, user_path(element_user)
  end

end