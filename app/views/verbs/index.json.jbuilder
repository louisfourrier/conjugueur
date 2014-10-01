json.array!(@verbs) do |verb|
  json.extract! verb, :content
  json.url verb_url(verb, format: :json)
end
