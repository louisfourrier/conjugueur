json.array!(@modes) do |mode|
  json.extract! mode, :id, :name, :description, :markup
  json.url mode_url(mode, format: :json)
end
