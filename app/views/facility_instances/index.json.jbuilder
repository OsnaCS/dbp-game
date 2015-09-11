json.array!(@facility_instances) do |facility_instance|
  json.extract! facility_instance, :id, :facility_id, :ship_id, :count, :create_count, :start_time
  json.url facility_instance_url(facility_instance, format: :json)
end
