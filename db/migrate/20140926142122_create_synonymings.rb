class CreateSynonymings < ActiveRecord::Migration
  def change
    create_table :synonymings do |t|
      t.references :verb, index: true
      t.integer :synonym_id

      t.timestamps
    end
    add_index :synonymings, :synonym_id
  end
end
