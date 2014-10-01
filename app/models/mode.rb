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

class Mode < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  
  has_many :tenses
  
  
  def self.update_tenses_count
    self.find_each do |mode|
      mode.update(:tenses_count => mode.tenses.count)
    end
  end
  
end
