# == Schema Information
#
# Table name: tenses
#
#  id          :integer          not null, primary key
#  name        :text
#  description :text
#  markup      :text
#  mode_id     :integer
#  entry_type  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class TenseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
