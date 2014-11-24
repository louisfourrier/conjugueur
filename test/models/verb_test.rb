# == Schema Information
#
# Table name: verbs
#
#  id            :integer          not null, primary key
#  content       :string(255)
#  group         :string(255)
#  employ        :text
#  auxiliary     :text
#  definition    :text
#  created_at    :datetime
#  updated_at    :datetime
#  first_letter  :string(255)
#  page_content  :text
#  html_name     :string(255)
#  letters_count :integer          default(0)
#  research_name :text
#  slug          :string(255)
#

require 'test_helper'

class VerbTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
