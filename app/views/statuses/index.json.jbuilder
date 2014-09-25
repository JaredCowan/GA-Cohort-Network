json.array!(@statuses) do |status|
  json.status status
  json.poster status.user
  json.comments status.comments
end
