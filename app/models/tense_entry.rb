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

class TenseEntry < ActiveRecord::Base
  belongs_to :verb
  belongs_to :tense
  
  validates :order, presence: true
  validates :total_content, presence: true
  validates :total_content, :uniqueness => {:scope => [:tense, :verb, :order]}
  
  
  def self.destroy_not_ordered
    self.where('order is NULL').destroy_all
  end
  
  
end
