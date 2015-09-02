json.array!(@scanner_minerals) do |scanner_mineral|
  json.extract! scanner_mineral, :id, :price, :level, :production, :time
  json.url scanner_mineral_url(scanner_mineral, format: :json)
end
