json.array!(@fights) do |fight|
  json.extract! fight, :id, :report, :time
  json.url fight_url(fight, format: :json)
end
