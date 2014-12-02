class AddIndexOnImportant < ActiveRecord::Migration
  def change
    add_index :tense_entries, :important_content
  end
end
