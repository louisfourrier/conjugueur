class AddHtmlNameToVerbs < ActiveRecord::Migration
  def change
    add_column :verbs, :html_name, :string
  end
end
