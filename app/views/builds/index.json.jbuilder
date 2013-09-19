json.array!(@builds) do |build|
  json.extract! build, 
  json.url build_url(build, format: :json)
end
