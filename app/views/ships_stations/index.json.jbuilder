json.array!(@ships_stations) do |ships_station|
  json.extract! ships_station, :id, :ships_id, :stations_id, :level
  json.url ships_station_url(ships_station, format: :json)
end
