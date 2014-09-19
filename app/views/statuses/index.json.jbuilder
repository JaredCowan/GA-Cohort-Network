json.array!(@statuses) do |status|
  json.extract! status, :id, :subject, :content
  json.id status.id
  json.title status.subject
  json.description status.content
  json.start status.created_at
  json.end status.updated_at
  json.url status_url(status, format: :html)
end