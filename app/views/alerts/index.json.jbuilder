json.array!(@alerts) do |alert|
  json.extract! alert, :id, :heures, :minutes, :lieu, :active
  json.url alert_url(alert, format: :json)
end
