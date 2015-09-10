json.array!(@fighting_fleets) do |fighting_fleet|
  json.extract! fighting_fleet, :id, :shield, :user_id
  json.url fighting_fleet_url(fighting_fleet, format: :json)
end
