json.array!(@damage_types) do |damage_type|
  json.extract! damage_type, :id, :name, :shell_mult, :shield_mult, :station_mult, :plattform_mult
  json.url damage_type_url(damage_type, format: :json)
end
