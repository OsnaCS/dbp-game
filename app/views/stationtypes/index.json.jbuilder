json.array!(@stationtypes) do |stationtype|
  json.extract! stationtype, :id, :statID, :name, :costMineral, :costCristal, :costFuel
  json.url stationtype_url(stationtype, format: :json)
end
