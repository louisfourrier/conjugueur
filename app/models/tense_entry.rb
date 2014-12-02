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
  include ActionView::Helpers
  
  validates :order, presence: true
  validates :total_content, presence: true
  validates :total_content, :uniqueness => {:scope => [:tense, :verb, :order]}
  
  
  def self.destroy_not_ordered
    self.where('order is NULL').destroy_all
  end
  
  def get_important_content
    string = strip_tags(self.total_content)
    string = I18n.transliterate(string)
    string = string.downcase
    self.update_column(:important_content, string)
  end
  
  def self.update_important_content
    self.find_each do |t|
      puts t.id.to_s
      t.get_important_content
    end
  end
  
  def self.search_verb(term)
    term = I18n.transliterate(term.to_s.downcase.strip)
    if term.empty?
      return []
    end
    results = self.where('important_content ILIKE ?', "%#{term}%")
    if results.empty?
      return []
    else
      verbs = []
      results.each do |r|
        verbs << r.verb
      end
      return verbs.uniq
    end
  end
  
  
end
