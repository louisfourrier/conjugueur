class CreateExercicings < ActiveRecord::Migration
  def change
    create_table :exercicings do |t|
      t.references :exercice, index: true
      t.references :tense, index: true

      t.timestamps
    end
  end
end
