json.array!(@resources) do |resource|
  json.extract! resource, :id, :name, :production
  json.url resource_url(resource, format: :json)
end
