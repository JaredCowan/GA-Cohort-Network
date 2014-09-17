json.array!(@statuses) do |status|
  json.full_name status.user.first_name + ' ' + status.user.last_name
  json.avatar image_tag status.user.avatar.url
  json.id status.id
  json.status_user status.user
  json.status_user_friends status.user.friends
  json.status status
  json.status_document status.document
  json.document_url image_tag status.document.attachment.url if status.document != nil
  json.edit_status_url edit_status_path(status)
  json.user_profile_url profile_page_path(status.user)
  json.edit_profile_url edit_user_registration_path(status.user)
end

