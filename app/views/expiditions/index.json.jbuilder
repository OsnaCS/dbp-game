json.array!(@expiditions) do |expidition|
  json.extract! expidition, :id
  json.url expidition_url(expidition, format: :json)
end
