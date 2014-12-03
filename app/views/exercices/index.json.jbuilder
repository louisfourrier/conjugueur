json.array!(@exercices) do |exercice|
  json.extract! exercice, :id, :question_number
  json.url exercice_url(exercice, format: :json)
end
