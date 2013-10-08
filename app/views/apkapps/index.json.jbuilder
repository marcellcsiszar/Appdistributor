json.array!(@apkapps) do |apkapp|
  json.extract! apkapp,
  json.url apkapp_url(apkapp, format: :json)
end
