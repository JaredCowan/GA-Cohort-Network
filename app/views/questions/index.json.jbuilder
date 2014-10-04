json.array!(@questions) do |question|
  json.question question
  json.poster question.user
  json.answers question.answers
end
