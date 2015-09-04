json.array!(@ranks) do |rank|
  json.extract! rank, :id, :email, :score
  json.url rank_url(rank, format: :json)
end
