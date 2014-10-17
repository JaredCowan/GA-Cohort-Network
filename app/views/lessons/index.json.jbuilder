json.array!(Lesson.all) do |lesson|
  json.allDay lesson.all_day
  json.title lesson.title
  json.description lesson.description
  json.start(lesson.start)
  json.end(lesson.end)
  json.userid User.find(lesson.user_id).id
end
