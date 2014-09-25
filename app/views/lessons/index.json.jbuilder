json.array!(Lesson.all) do |lesson|
  json.title lesson.subject
  json.description lesson.description
  json.start(lesson.start.strftime('%Y %m %d %H:%M:%S'))
  json.end(lesson.end.strftime('%Y %m %d %H:%M:%S'))
  json.url lesson_url(lesson, format: :html)
  json.userid User.find(lesson.user_id).id
end
