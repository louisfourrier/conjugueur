class AddColToVerbs < ActiveRecord::Migration
  def change
    
    add_column :verbs, :first_letter, :string
    add_column :verbs, :page_content, :text
    
  end
end
