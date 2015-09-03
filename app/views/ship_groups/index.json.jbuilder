json.array!(@ship_groups) do |ship_group|
  json.extract! ship_group, :id, :fleet_id, :ship_id, :number, :group_hitpoints
  json.url ship_group_url(ship_group, format: :json)
end
