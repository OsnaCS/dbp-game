json.array!(@user_ships) do |user_ship|
  json.extract! user_ship, :id, :user_id, :ship_id
  json.url user_ship_url(user_ship, format: :json)
end
