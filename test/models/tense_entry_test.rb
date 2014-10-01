# == Schema Information
#
# Table name: tense_entries
#
#  id                :integer          not null, primary key
#  total_content     :text
#  begin_content     :text
#  important_content :text
#  order             :integer
#  verb_id           :integer
#  tense_id          :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class TenseEntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
