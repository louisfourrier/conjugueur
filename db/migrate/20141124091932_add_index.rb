class AddIndex < ActiveRecord::Migration
  def change
    add_index :modes, :order
    add_index :tense_entries, :order
  end
end
