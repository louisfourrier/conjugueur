class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :exercice, index: true
      t.references :tense_entry, index: true
      t.string :answer

      t.timestamps
    end
  end
end
