class AddResearchAndIndex < ActiveRecord::Migration
  def change
    add_column :verbs, :research_name, :text
    add_index :verbs, :research_name
    add_index :verbs, :content
  end
end
