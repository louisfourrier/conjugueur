# == Schema Information
#
# Table name: modes
#
#  id           :integer          not null, primary key
#  name         :text
#  description  :text
#  markup       :text
#  created_at   :datetime
#  updated_at   :datetime
#  tenses_count :integer          default(0)
#  order        :integer          default(0)
#

require 'test_helper'

class ModeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
