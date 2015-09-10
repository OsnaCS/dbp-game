json.array!(@unit_instances) do |unit_instance|
  json.extract! unit_instance, :id, :unit_id, :ship_id, :amount
  json.url unit_instance_url(unit_instance, format: :json)
end
