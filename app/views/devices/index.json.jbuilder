json.array!(@devices) do |device|
  json.extract! device, :id, :name, :address, :notes
  json.url device_url(device, format: :json)
end
