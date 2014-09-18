json.array!(@statuses) do |status|
  json.full_name status.user.first_name + ' ' + status.user.last_name
  json.id status.id
  json.status_user status.user
  json.status_user_friends status.user.user_friendships
  json.status status
  json.comments status.comments
  json.status_document status.document
  json.document_url image_tag status.document.attachment.url if status.document != nil
end

