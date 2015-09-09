json.array!(@stations) do |station|
  json.extract! station, :id, :name, :costMineral, :costCristal, :costFuel
  json.url station_url(station, format: :json)
end
