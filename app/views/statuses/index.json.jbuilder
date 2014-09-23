json.array!(@statuses) do |status|
  json.extract! status, :id, :subject, :content
  json.id status.id
  json.title status.subject
  json.description status.content
  json.start(status.created_at.strftime('%Y %m %d %H:%M:%S'))
  json.end(status.created_at.strftime('%Y %m %d %H:%M:%S'))
  json.url status_url(status, format: :html)
end
