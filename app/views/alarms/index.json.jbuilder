json.array!(@alarms) do |alarm|
  json.extract! alarm, :id, :heures, :minutes, :lieu
  json.url alarm_url(alarm, format: :json)
end
