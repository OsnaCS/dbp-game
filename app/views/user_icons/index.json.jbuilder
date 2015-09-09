json.array!(@user_icons) do |user_icon|
  json.extract! user_icon, :id, :user_id
  json.url user_icon_url(user_icon, format: :json)
end
