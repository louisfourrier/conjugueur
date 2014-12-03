# == Schema Information
#
# Table name: questions
#
#  id             :integer          not null, primary key
#  exercice_id    :integer
#  tense_entry_id :integer
#  answer         :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Question < ActiveRecord::Base
  belongs_to :exercice
  belongs_to :tense_entry
end
