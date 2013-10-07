json.array!(@ipaapps) do |ipaapp|
  json.extract! ipaapp, 
  json.url ipaapp_url(ipaapp, format: :json)
end
