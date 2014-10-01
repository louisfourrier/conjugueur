json.array!(@tense_entries) do |tense_entry|
  json.extract! tense_entry, :id, :total_content, :begin_content, :important_content, :order, :verb_id, :tense_id
  json.url tense_entry_url(tense_entry, format: :json)
end
