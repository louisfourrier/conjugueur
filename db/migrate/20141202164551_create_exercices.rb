class CreateExercices < ActiveRecord::Migration
  def change
    create_table :exercices do |t|
      t.integer :question_number

      t.timestamps
    end
  end
end
