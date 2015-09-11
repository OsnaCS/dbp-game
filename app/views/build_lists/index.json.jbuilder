json.array!(@build_lists) do |build_list|
  json.extract! build_list, :id
  json.url build_list_url(build_list, format: :json)
end
