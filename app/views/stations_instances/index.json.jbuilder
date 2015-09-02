json.array!(@stations_instances) do |stations_instance|
  json.extract! stations_instance, :id, :shipID, :statID, :level
  json.url stations_instance_url(stations_instance, format: :json)
end
