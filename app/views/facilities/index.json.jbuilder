json.array!(@facilities) do |facility|
  json.extract! facility, :id, :cost1, :cost2, :cost3, :duration, :name, :facility_condition_id, :icon
  json.url facility_url(facility, format: :json)
end
