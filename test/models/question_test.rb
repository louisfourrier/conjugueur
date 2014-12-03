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

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
