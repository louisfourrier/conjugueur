class AddNewColumns < ActiveRecord::Migration
  def change
    add_column :verbs, :letters_count, :integer, default: 0
    add_column :modes, :tenses_count, :integer, default: 0
    add_column :modes, :order, :integer, default: 0
  end
end
