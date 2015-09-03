json.array!(@rankings) do |ranking|
  json.extract! ranking, :id, :user_id, :value
  json.url ranking_url(ranking, format: :json)
end
