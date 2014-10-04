json.array!(@activities) do |a|
  json.id a.id
  json.targetable_id a.targetable_id
  json.action a.action
  json.targetable_type a.targetable_type
  json.user_id a.user_id
  json.created_at a.created_at
  json.updated_at a.updated_at
  json.status Status.where(id: a.targetable_id)
  json.comment Comment.where(id: a.targetable_id)
  json.question Question.where(id: a.targetable_id)
  json.answers Answer.where(question_id: a.targetable_id)
  json.user User.first
end