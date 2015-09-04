json.array!(@stations) do |station|
  json.extract! station, :id, :name, :costMIneral, :costCristal, :costFuel
  json.url station_url(station, format: :json)
end
