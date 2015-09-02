json.array!(@sciences) do |science|
  json.extract! science, :id, :science_id, :cost1, :cost2, :cost3, :factor, :duration, :condition
  json.url science_url(science, format: :json)
end
