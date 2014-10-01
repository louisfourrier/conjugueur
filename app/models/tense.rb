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

class Tense < ActiveRecord::Base
  belongs_to :mode
  
  validates :name, presence: true
  validates :name, :uniqueness => {:scope => :mode}
  
  has_many :tense_entries
  
  
end
