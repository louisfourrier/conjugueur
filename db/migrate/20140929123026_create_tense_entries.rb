class CreateTenseEntries < ActiveRecord::Migration
  def change
    create_table :tense_entries do |t|
      t.text :total_content
      t.text :begin_content
      t.text :important_content
      t.integer :order
      t.references :verb, index: true
      t.references :tense, index: true

      t.timestamps
    end
  end
end
