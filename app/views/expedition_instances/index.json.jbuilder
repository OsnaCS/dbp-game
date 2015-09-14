json.array!(@expedition_instances) do |expedition_instance|
  json.extract! expedition_instance, :id, :user_id, :expedition_id
  json.url expedition_instance_url(expedition_instance, format: :json)
end
