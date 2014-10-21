json.array!(@statuses) do |status|
  json.status status
  json.likes status.get_upvotes
  json.poster status.user
  json.comments status.comments
end
