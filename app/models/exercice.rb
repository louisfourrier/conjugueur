# == Schema Information
#
# Table name: exercices
#
#  id              :integer          not null, primary key
#  question_number :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Exercice < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :tense_entries, :through => :questions
  
  has_many :exercicings, dependent: :destroy
  has_many :tenses, :through => :exercicings
  
  attr_writer :tenses_associated
  after_create :save_tenses_associated
  after_create :create_questions
  
  validates :question_number, presence: true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
  validates :tenses_associated, presence: true
  
  def tenses_associated
    @tenses_associated || self.tenses.pluck(:id)
  end
  
  def save_tenses_associated
    keys = tenses_associated.keys
    keys.each do |k|
      t = Tense.find_by(:id => k.to_i)
      self.tenses << t
    end
  end
  
  def create_questions
    tense_entries = TenseEntry.joins(:tense).where('tenses.id IN (?)', self.tenses.pluck(:id)).order('RANDOM ()').limit(self.question_number)
    self.tense_entry_ids = tense_entries.pluck(:id)
  end
  
  def score(answers)
    score = 0
    tab = answers.to_a
    tense_entries = self.tense_entries
    tab.each do |q|
      t = tense_entries.find(q[0].to_i)
      if t.correct_answer(q[1])
        score += 1
      end
    end
    return score
  end
  
end
