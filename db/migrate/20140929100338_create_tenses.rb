class CreateTenses < ActiveRecord::Migration
  def change
    create_table :tenses do |t|
      t.text :name
      t.text :description
      t.text :markup
      t.references :mode, index: true
      t.integer :entry_type

      t.timestamps
    end
  end
end
