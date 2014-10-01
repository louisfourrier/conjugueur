# == Schema Information
#
# Table name: synonymings
#
#  id         :integer          not null, primary key
#  verb_id    :integer
#  synonym_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Synonyming < ActiveRecord::Base
  belongs_to :verb
  belongs_to :synonym, :class_name => 'Verb'

  validates :synonym, :uniqueness => {:scope => :verb}
  
  
end
