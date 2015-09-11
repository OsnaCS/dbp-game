json.array!(@expeditions) do |expedition|
  json.extract! expedition, :id
  json.url expedition_url(expedition, format: :json)
end
