# == Schema Information
#
# Table name: exercicings
#
#  id          :integer          not null, primary key
#  exercice_id :integer
#  tense_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Exercicing < ActiveRecord::Base
  belongs_to :exercice
  belongs_to :tense
end
