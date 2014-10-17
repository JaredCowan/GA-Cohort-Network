json.array!(current_user.lessons) do |user|
  json.allDay user.all_day
  json.id user.id
  json.title user.subject
  json.description user.description
  json.start user.start.strftime('%Y-%m-%dT%H:%M:%S')
  json.end user.end.strftime('%Y-%m-%dT%H:%M:%S')
  json.url lesson_url(user, format: :html)
  json.userid User.find(user.user_id).id
end