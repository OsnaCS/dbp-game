json.array!(@notifications) do |notification|
  json.extract! notification, :id, :user_id, :message_id
  json.url notification_url(notification, format: :json)
end
