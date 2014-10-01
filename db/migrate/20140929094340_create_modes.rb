class CreateModes < ActiveRecord::Migration
  def change
    create_table :modes do |t|
      t.text :name
      t.text :description
      t.text :markup

      t.timestamps
    end
  end
end
