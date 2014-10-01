class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.string :content
      t.string :group
      t.text :employ
      t.text :auxiliary
      t.text :definition

      t.timestamps
    end
  end
end
