json.array!(@statuses) do |status|
  json.status status
  json.poster status.user
  json.description status.content
  json.comments status.comments
end
