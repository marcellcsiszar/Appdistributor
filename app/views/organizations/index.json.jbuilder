json.array!(@organizations) do |organization|
  json.extract! organization, 
  json.url organization_url(organization, format: :json)
end
