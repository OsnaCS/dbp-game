json.array!(@units) do |unit|
  json.extract! unit, :id, :name, :metal_price, :crystal_price, :fuel_price, :total_cost, :shell, :damage, :damage_type_id, :cargo, :speed, :shipyard_requirement, :research_requirement_one, :research_requiement_two
  json.url unit_url(unit, format: :json)
end
