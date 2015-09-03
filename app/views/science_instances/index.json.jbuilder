json.array!(@science_instances) do |science_instance|
  json.extract! science_instance, :id, :science_id, :user_id, :level
  json.url science_instance_url(science_instance, format: :json)
end
