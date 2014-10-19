json.array!(current_user.lessons) do |user|
  json.allDay user.all_day
  json.title user.title
  json.description user.description
  json.start(user.start)
  json.end(user.end)
  json.url lesson_url(user, format: :html)
  json.userid User.find(user.user_id).id
end

