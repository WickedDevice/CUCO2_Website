json.array!(@experiments) do |experiment|
  json.extract! experiment, :id, :name, :location, :start, :end
  json.url experiment_url(experiment, format: :json)
end
